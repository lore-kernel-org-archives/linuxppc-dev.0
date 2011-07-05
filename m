Return-Path: <jdmason@kudzu.us>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A54D01007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 02:18:49 +1000 (EST)
Received: by ewy6 with SMTP id 6so1976742ewy.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Jul 2011 09:18:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E1330A3.8080004@linux.vnet.ibm.com>
References: <BANLkTinZSeq5H=K4K4s_cuC2tOwsTZEDJg@mail.gmail.com>
	<4E0E1253.1000909@linux.vnet.ibm.com>
	<BANLkTinTEk2SgBwVUHc49cDLEwH_a-XsJg@mail.gmail.com>
	<4E0E274C.4000402@linux.vnet.ibm.com>
	<4E1330A3.8080004@linux.vnet.ibm.com>
Date: Tue, 5 Jul 2011 11:18:43 -0500
Message-ID: <CAPoiz9wArpezPaovSwKVCX3whGRmbAcYjywKX_dUng7wSeW7KQ@mail.gmail.com>
Subject: Re: pci_pcie_cap invalid on AER/EEH enabled PPC?
From: Jon Mason <jdmason@kudzu.us>
To: Richard A Lary <rlary@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Richard Lary <rlary@us.ibm.com>,
	James Smart <james.smart@emulex.com>, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 5, 2011 at 10:41 AM, Richard A Lary
<rlary@linux.vnet.ibm.com> wrote:
> On 7/1/2011 1:00 PM, Richard A Lary wrote:
>>
>> On 7/1/2011 12:02 PM, Jon Mason wrote:
>>>
>>> On Fri, Jul 1, 2011 at 1:30 PM, Richard A Lary<rlary@linux.vnet.ibm.com=
>
>>> wrote:
>>>>
>>>> On 7/1/2011 8:24 AM, Jon Mason wrote:
>>>>>
>>>>> I recently sent out a number of patches to migrate drivers calling
>>>>> `pci_find_capability(pdef, PCI_CAP_ID_EXP)` to pci_pcie_cap. This
>>>>> function takes uses a PCI-E capability offset that was determined by
>>>>> calling pci_find_capability during the PCI bus walking. In response
>>>>> to one of the patches, James Smart posted:
>>>>>
>>>>> "The reason is due to an issue on PPC platforms whereby use of
>>>>> "pdev->is_pcie" and pci_is_pcie() will erroneously fail under some
>>>>> conditions, but explicit search for the capability struct via
>>>>> pci_find_capability() is always successful. I expect this to be due
>>>>> a shadowing of pci config space in the hal/platform that isn't
>>>>> sufficiently built up. We detected this issue while testing AER/EEH,
>>>>> and are functional only if the pci_find_capability() option is used."
>>>>>
>>>>> See http://marc.info/?l=3Dlinux-scsi&m=3D130946649427828&w=3D2 for th=
e whole
>>>>> post.
>>>>>
>>>>> Based on his description above pci_pcie_cap
>>>>> andpci_find_capability(pdef, PCI_CAP_ID_EXP) should be functionally
>>>>> equivalent. If this is not safe, then the PCI bus walking code is
>>>>> most likely busted on EEH enabled PPC systems (and that is a BIG
>>>>> problem). Can anyone confirm this is still an issue?
>>>>
>>>> Jon,
>>>>
>>>> I applied the following debug patch to lpfc driver in a 2.6.32 distro
>>>> kernel ( I had this one handy, I can try with mainline later today )
>>>>
>>>> ---
>>>> drivers/scsi/lpfc/lpfc_init.c | 10 10 + 0 - 0 !
>>>> 1 file changed, 10 insertions(+)
>>>>
>>>> Index: b/drivers/scsi/lpfc/lpfc_init.c
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> --- a/drivers/scsi/lpfc/lpfc_init.c
>>>> +++ b/drivers/scsi/lpfc/lpfc_init.c
>>>> @@ -3958,6 +3958,16 @@ lpfc_enable_pci_dev(struct lpfc_hba *phb
>>>> pci_try_set_mwi(pdev);
>>>> pci_save_state(pdev);
>>>>
>>>> + printk(KERN_WARNING "pcicap: is_pcie=3D%x pci_cap=3D%x pcie_type=3D%=
x\n",
>>>> + pdev->is_pcie,
>>>> + pdev->pcie_cap,
>>>> + pdev->pcie_type);
>>>> +
>>>> + if (pci_is_pcie(pdev))
>>>> + printk(KERN_WARNING "pcicap: true\n");
>>>> + else
>>>> + printk(KERN_WARNING "pcicap: false\n");
>>>> +
>>>> /* PCIe EEH recovery on powerpc platforms needs fundamental reset */
>>>> if (pci_find_capability(pdev, PCI_CAP_ID_EXP))
>>>> pdev->needs_freset =3D 1;
>>>>
>>>> This is output upon driver load on an IBM Power 7 model 8233-E8B serve=
r.
>>>>
>>>> dmesg | grep pcicap
>>>> Linux version 2.6.32.42-pcicap-ppc64 (geeko@buildhost) (gcc version
>>>> 4.3.4
>>>> [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jul 1
>>>> 09:31:27
>>>> PDT 2011
>>>> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
>>>> pcicap: false
>>>> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
>>>> pcicap: false
>>>> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
>>>> pcicap: false
>>>> pcicap: is_pcie=3D0 pci_cap=3D0 pcie_type=3D0
>>>> pcicap: false
>>>>
>>>> It would appear that the pcie information is not set in pci_dev
>>>> structure
>>>> for
>>>> this device at the time the driver is being initialized during boot.
>>>
>>> Thanks for trying this. Can you confirm that the other devices in the
>>> system have this issue as well (or show that it is isolated to the lpr
>>> device)? You can add printks in set_pcie_port_type() to verify what
>>> is being set on bus walking and to see when it is being called with
>>> respect to when it is being populated by firmware.
>>
>> Jon,
>>
>> I will give this suggestion a try and post results
>
> On Power PC platforms, set_pcie_port_type() is not called. =A0On Power PC=
,
> pci_dev structure is initialized by of_create_pci_dev(). =A0However, the
> structure member pcie_cap is NOT computed nor set in this function.

Yes, it is.  of_create_pci_dev() calls set_pcie_port_type()
http://lxr.linux.no/linux+v2.6.39/arch/powerpc/kernel/pci_of_scan.c#L144

That function sets pdev->pcie_cap
http://lxr.linux.no/linux+v2.6.39/drivers/pci/probe.c#L896

So, it should be set.  It looks like there is a bug in
of_create_pci_dev, as set_pcie_port_type is being called BEFORE the
BARs are setup.  If you move set_pcie_port_type prior to
pci_device_add (perhaps even after), then I bet the issue is resolved.

Thanks,
Jon

> The information used to populate pci_dev comes from the Power PC
> device_tree passed to the OS by Open Firmware.
>
> Based upon standing Power PC design, we cannot support patches
> which replace pci_find_capability(pdef, PCI_CAP_ID_EXP) with
> pci_is_pcie(pdev) on Power PC platforms.
>
> -rich
>
>
