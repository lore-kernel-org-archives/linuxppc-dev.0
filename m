Return-Path: <anton@samba.org>
Date: Tue, 5 Jun 2012 12:47:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: pseries: Round up MSI-X requests
Message-ID: <20120605124703.12bb4cc3@kryten>
In-Reply-To: <1338792897.7150.68.camel@pasglop>
References: <20120604091545.03ce738b@kryten>
 <1338792215.15716.5.camel@concordia>
 <1338792897.7150.68.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> On Mon, 2012-06-04 at 16:43 +1000, Michael Ellerman wrote:
> > There is some chance this will result in breakage because the driver
> > asks for N - and assumes that is what was allocated - and the
> > device is configured for > N.
> 
> We can fix that. We can whack the configuration back with N, just know
> that we have "allocated"  > N.

I agree we don't want to be giving back a larger value than requested.
There's only one place that can happen in theory and since firmware only
returns power of two values I dont think it will happen in practise.

Even so do we want to do something like this (as yet untested)? If the
rounded up request fails we retry with the original request.

The pseries msi free code just sets our vectors to 0 so it doesn't need
to know how many were originally allocated.
 
Anton
--

[PATCH] powerpc: pseries: Round up MSI-X requests

The pseries firmware currently refuses any non power of two MSI-X
request. Unfortunately most network drivers end up asking for that
because they want a power of two for RX queues and one or two extra
for everything else.

This patch rounds up the firmware request to the next power of two
if the quota allows it. If this fails we fall back to using the
original request size.

Signed-off-by: Anton Blanchard <anton@samba.org>
---        

Index: linux-build/arch/powerpc/platforms/pseries/msi.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/msi.c	2012-06-04 15:58:48.095833249 +1000
+++ linux-build/arch/powerpc/platforms/pseries/msi.c	2012-06-05 12:15:58.711074499 +1000
@@ -387,12 +387,13 @@ static int check_msix_entries(struct pci
 	return 0;
 }
 
-static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
 {
 	struct pci_dn *pdn;
 	int hwirq, virq, i, rc;
 	struct msi_desc *entry;
 	struct msi_msg msg;
+	int nvec = nvec_in;
 
 	pdn = get_pdn(pdev);
 	if (!pdn)
@@ -402,10 +403,23 @@ static int rtas_setup_msi_irqs(struct pc
 		return -EINVAL;
 
 	/*
+	 * Firmware currently refuse any non power of two allocation
+	 * so we round up if the quota will allow it.
+	 */
+	if (type == PCI_CAP_ID_MSIX) {
+		int m = roundup_pow_of_two(nvec);
+		int quota = msi_quota_for_device(pdev, m);
+
+		if (quota >= m)
+			nvec = m;
+	}
+
+	/*
 	 * Try the new more explicit firmware interface, if that fails fall
 	 * back to the old interface. The old interface is known to never
 	 * return MSI-Xs.
 	 */
+again:
 	if (type == PCI_CAP_ID_MSI) {
 		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
 
@@ -417,6 +431,10 @@ static int rtas_setup_msi_irqs(struct pc
 		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
 
 	if (rc != nvec) {
+		if (nvec != nvec_in) {
+			nvec = nvec_in;
+			goto again;
+		}
 		pr_debug("rtas_msi: rtas_change_msi() failed\n");
 		return rc;
 	}
