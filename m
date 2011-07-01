Return-Path: <jdmason@kudzu.us>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 10F26B6F54
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Jul 2011 05:02:25 +1000 (EST)
Received: by eyg5 with SMTP id 5so1177110eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 01 Jul 2011 12:02:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E0E1253.1000909@linux.vnet.ibm.com>
References: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
	<4E0E1253.1000909@linux.vnet.ibm.com>
Date: Fri, 1 Jul 2011 14:02:19 -0500
Message-ID: <BANLkTinTEk2SgBwVUHc49cDLEwH_a-XsJg@mail.gmail.com>
Subject: Re: pci_pcie_cap invalid on AER/EEH enabled PPC?
From: Jon Mason <jdmason@kudzu.us>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Fri, Jul 1, 2011 at 1:30 PM, Richard A Lary <rlary@linux.vnet.ibm.com> w=
rote:
> On 7/1/2011 8:24 AM, Jon Mason wrote:
>>
>> I recently sent out a number of patches to migrate drivers calling
>> `pci_find_capability(pdef, PCI_CAP_ID_EXP)` to pci_pcie_cap. =A0This
>> function takes uses a PCI-E capability offset that was determined by
>> calling pci_find_capability during the PCI bus walking. =A0In response
>> to one of the patches, James Smart posted:
>>
>> "The reason is due to an issue on PPC platforms whereby use of
>> "pdev->is_pcie" and pci_is_pcie() will erroneously fail under some
>> conditions, but explicit search for the capability struct via
>> pci_find_capability() is always successful. =A0 I expect this to be due
>> a shadowing of pci config space in the hal/platform that isn't
>> sufficiently built up. =A0We detected this issue while testing AER/EEH,
>> and are functional only if the pci_find_capability() option is used."
>>
>> See http://marc.info/?l=3Dlinux-scsi&m=3D130946649427828&w=3D2 for the w=
hole
>> post.
>>
>> Based on his description above pci_pcie_cap
>> andpci_find_capability(pdef, PCI_CAP_ID_EXP) should be functionally
>> equivalent. =A0If this is not safe, then the PCI bus walking code is
>> most likely busted on EEH enabled PPC systems (and that is a BIG
>> problem). =A0Can anyone confirm this is still an issue?
>
> Jon,
>
> I applied the following debug patch to lpfc driver in a 2.6.32 distro
> kernel ( I had this one handy, I can try with mainline later today )
>
> ---
> =A0drivers/scsi/lpfc/lpfc_init.c | =A0 10 =A0 10 + =A0 =A00 - =A0 =A0 0 !
> =A01 file changed, 10 insertions(+)
>
> Index: b/drivers/scsi/lpfc/lpfc_init.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -3958,6 +3958,16 @@ lpfc_enable_pci_dev(struct lpfc_hba *phb
> =A0 =A0 =A0 =A0pci_try_set_mwi(pdev);
> =A0 =A0 =A0 =A0pci_save_state(pdev);
>
> + =A0 =A0 =A0 printk(KERN_WARNING "pcicap: is_pcie=3D%x pci_cap=3D%x pcie=
_type=3D%x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->is_pcie,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->pcie_cap,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->pcie_type);
> +
> + =A0 =A0 =A0 if (pci_is_pcie(pdev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "pcicap: true\n");
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "pcicap: false\n");
> +
> =A0 =A0 =A0 =A0/* PCIe EEH recovery on powerpc platforms needs fundamenta=
l reset */
> =A0 =A0 =A0 =A0if (pci_find_capability(pdev, PCI_CAP_ID_EXP))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev->needs_freset =3D 1;
>
> This is output upon driver load on an IBM Power 7 model 8233-E8B server.
>
> dmesg | grep pcicap
> Linux version 2.6.32.42-pcicap-ppc64 (geeko@buildhost) (gcc version 4.3.4
> [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jul 1 09:31:27
> PDT 2011
> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
> pcicap: false
> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
> pcicap: false
> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
> pcicap: false
> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
> pcicap: false
>
> It would appear that the pcie information is not set in pci_dev structure
> for
> this device at the time the driver is being initialized during boot.

Thanks for trying this.  Can you confirm that the other devices in the
system have this issue as well (or show that it is isolated to the lpr
device)?  You can add printks in set_pcie_port_type() to verify what
is being set on bus walking and to see when it is being called with
respect to when it is being populated by firmware.

Thanks,
Jon

>
> -rich
>
>
>
