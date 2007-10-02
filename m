Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 64F55DE2EB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 07:40:17 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l92LeEpP011695
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 17:40:14 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l92LeDgY465164
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 15:40:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l92LeD0B008864
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Oct 2007 15:40:13 -0600
Date: Tue, 2 Oct 2007 16:40:12 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] powerpc: another use of zalloc_maybe_bootmem()
Message-ID: <20071002214012.GL4338@austin.ibm.com>
References: <20071002133753.662397db.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002133753.662397db.sfr@canb.auug.org.au>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use alloc_maybe_bootmem() which wraps the if(mem_init_done)
malloc clause.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
On Tue, Oct 02, 2007 at 01:37:53PM +1000, Stephen Rothwell wrote:
> This patch introduces zalloc_maybe_bootmem and uses it so that we don;t
> have to mark a whole (largish) routine as __init_ref_ok.

sfr missed a spot -- may as well get rid of this one too.


 arch/powerpc/kernel/pci-common.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6.23-rc8-mm1/arch/powerpc/kernel/pci-common.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/arch/powerpc/kernel/pci-common.c	2007-09-26 15:02:41.000000000 -0500
+++ linux-2.6.23-rc8-mm1/arch/powerpc/kernel/pci-common.c	2007-10-02 16:28:16.000000000 -0500
@@ -65,14 +65,11 @@ static void __devinit pci_setup_pci_cont
 	spin_unlock(&hose_spinlock);
 }
 
-__init_refok struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
+struct pci_controller * pcibios_alloc_controller(struct device_node *dev)
 {
 	struct pci_controller *phb;
 
-	if (mem_init_done)
-		phb = kmalloc(sizeof(struct pci_controller), GFP_KERNEL);
-	else
-		phb = alloc_bootmem(sizeof (struct pci_controller));
+	phb = alloc_maybe_bootmem(sizeof(struct pci_controller), GFP_KERNEL);
 	if (phb == NULL)
 		return NULL;
 	pci_setup_pci_controller(phb);
