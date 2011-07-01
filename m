Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1560B6F64
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 04:31:19 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p61IOsxn005066
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2011 12:24:54 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p61IUvJ0170130
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2011 12:30:57 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p61CUtAC011476
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2011 06:30:56 -0600
Message-ID: <4E0E1253.1000909@linux.vnet.ibm.com>
Date: Fri, 01 Jul 2011 11:30:43 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jon Mason <jdmason@kudzu.us>
Subject: Re: pci_pcie_cap invalid on AER/EEH enabled PPC?
References: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
In-Reply-To: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Richard Lary <rlary@us.ibm.com>, James Smart <james.smart@emulex.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/1/2011 8:24 AM, Jon Mason wrote:
> I recently sent out a number of patches to migrate drivers calling
> `pci_find_capability(pdef, PCI_CAP_ID_EXP)` to pci_pcie_cap.  This
> function takes uses a PCI-E capability offset that was determined by
> calling pci_find_capability during the PCI bus walking.  In response
> to one of the patches, James Smart posted:
>
> "The reason is due to an issue on PPC platforms whereby use of
> "pdev->is_pcie" and pci_is_pcie() will erroneously fail under some
> conditions, but explicit search for the capability struct via
> pci_find_capability() is always successful.   I expect this to be due
> a shadowing of pci config space in the hal/platform that isn't
> sufficiently built up.  We detected this issue while testing AER/EEH,
> and are functional only if the pci_find_capability() option is used."
>
> See http://marc.info/?l=linux-scsi&m=130946649427828&w=2 for the whole post.
>
> Based on his description above pci_pcie_cap
> andpci_find_capability(pdef, PCI_CAP_ID_EXP) should be functionally
> equivalent.  If this is not safe, then the PCI bus walking code is
> most likely busted on EEH enabled PPC systems (and that is a BIG
> problem).  Can anyone confirm this is still an issue?

Jon,

I applied the following debug patch to lpfc driver in a 2.6.32 distro
kernel ( I had this one handy, I can try with mainline later today )

---
  drivers/scsi/lpfc/lpfc_init.c |   10 	10 +	0 -	0 !
  1 file changed, 10 insertions(+)

Index: b/drivers/scsi/lpfc/lpfc_init.c
===================================================================
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -3958,6 +3958,16 @@ lpfc_enable_pci_dev(struct lpfc_hba *phb
  	pci_try_set_mwi(pdev);
  	pci_save_state(pdev);

+	printk(KERN_WARNING "pcicap: is_pcie=%x pci_cap=%x pcie_type=%x\n",
+		pdev->is_pcie,
+		pdev->pcie_cap,
+		pdev->pcie_type);
+
+	if (pci_is_pcie(pdev))
+		printk(KERN_WARNING "pcicap: true\n");
+	else
+		printk(KERN_WARNING "pcicap: false\n");
+
  	/* PCIe EEH recovery on powerpc platforms needs fundamental reset */
  	if (pci_find_capability(pdev, PCI_CAP_ID_EXP))
  		pdev->needs_freset = 1;

This is output upon driver load on an IBM Power 7 model 8233-E8B server.

dmesg | grep pcicap
Linux version 2.6.32.42-pcicap-ppc64 (geeko@buildhost) (gcc version 4.3.4 
[gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jul 1 09:31:27 PDT 2011
pcicap: is_pcie=0 pci_cap=0 pcie_type=0
pcicap: false
pcicap: is_pcie=0 pci_cap=0 pcie_type=0
pcicap: false
pcicap: is_pcie=0 pci_cap=0 pcie_type=0
pcicap: false
pcicap: is_pcie=0 pci_cap=0 pcie_type=0
pcicap: false

It would appear that the pcie information is not set in pci_dev structure for
this device at the time the driver is being initialized during boot.

-rich
