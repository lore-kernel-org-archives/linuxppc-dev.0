Return-Path: <nacc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8439AB6F12
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 12:41:10 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p23LMIg4012021
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 16:22:18 -0500
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id A89C36E8036
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Mar 2011 20:41:06 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p241f6em192392
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 20:41:06 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p241f5EG009999
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Mar 2011 20:41:06 -0500
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: disable MSI using new interface if possible
Date: Thu,  3 Mar 2011 17:41:02 -0800
Message-Id: <1299202862-10682-1-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1299200729.3630.52.camel@concordia>
References: <1299200729.3630.52.camel@concordia>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04.03.2011 [12:05:29 +1100], Michael Ellerman wrote:
> On Thu, 2011-03-03 at 11:39 -0800, Nishanth Aravamudan wrote:
> > On upcoming hardware, we have a PCI adapter with two functions, one of
> > which uses MSI and the other uses MSI-X. This adapter, when MSI is
> > disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
> > signals an MSI-X interrupt and triggers an EEH. We are working with the
> > vendor to ensure that the hardware is not at fault, but if we use the
> > "new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
> > automatically disable MSI-X and the adapter does not appear to signal
> > any stray MSI-X interrupt.
> 
> It seems this could also be a firmware bug, have we heard anything from
> them? PAPR explicitly says that RTAS_CHANGE_FN (function=1) should
> disable MSI _and_ MSI-X (R1???7.3.10.5.1???1).

We're tracking that down too. I think the fact that the interrupt is
coming in is a hardware bug in this particular adapter.

I'm looking at PAPR again and I see what might be a contradiction:

7.3.10.5.1: "To removing all MSIs, set the Requested Number of
Interrupts to zero."

Table 71: "Function ... 1: Request to set to a new number of MSI or
MSI-X (platform choice) interrupts (including set to 0)"

It seems like the Table claims that using RTAS_CHANGE_FN with 0, could
change only MSI or MSI-X and still be not a bug?

It does seem like it should disable both, but from what we've seen with
this adapter, it doesn't appear to.

> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > Cc: Milton Miller <miltonm@bga.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> 
> Cc: Me  :)

Sorry! I was in a hurry to get this out the door, my fault. Note, you
don't show up per scripts/get_maintainer.pl :)

> > diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> > index 1164c34..9434576 100644
> > --- a/arch/powerpc/platforms/pseries/msi.c
> > +++ b/arch/powerpc/platforms/pseries/msi.c
> > @@ -93,8 +93,18 @@ static void rtas_disable_msi(struct pci_dev *pdev)
> >     if (!pdn)
> >             return;
> >  
> > -   if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0)
> > -           pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
> > +   /*
> > +    * disabling MSI with the explicit interface also disables MSI-X
> > +    */
> > +   if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
> > +           /* 
> > +            * may have failed due to lacking
> > +            * "ibm,change-msix-capable" property
> > +            */
> > +           if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0) {
> > +                   pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
> > +           }
> > +   }
> >  }
> 
> This is probably a pretty safe change anyway, ie. use the newer API if
> it is present. The comment is backward though, the call fails because
> the new interface is not implemented, and that fact is signalled by the
> absence of the property.

Updated the comment, thanks:

On upcoming hardware, we have a PCI adapter with two functions, one of
which uses MSI and the other uses MSI-X. This adapter, when MSI is
disabled using the "old" firmware interface (RTAS_CHANGE_FN), still
signals an MSI-X interrupt and triggers an EEH. We are working with the
vendor to ensure that the hardware is not at fault, but if we use the
"new" interface (RTAS_CHANGE_MSI_FN) to disable MSI, we also
automatically disable MSI-X and the adapter does not appear to signal
any stray MSI-X interrupt.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---

 arch/powerpc/platforms/pseries/msi.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 1164c34..18ac801 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -93,8 +93,18 @@ static void rtas_disable_msi(struct pci_dev *pdev)
 	if (!pdn)
 		return;
 
-	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0)
-		pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
+	/*
+	 * disabling MSI with the explicit interface also disables MSI-X
+	 */
+	if (rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, 0) != 0) {
+		/* 
+		 * may have failed because explicit interface is not
+		 * present
+		 */
+		if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0) {
+			pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
+		}
+	}
 }
 
 static int rtas_query_irq_number(struct pci_dn *pdn, int offset)
-- 
1.7.1
