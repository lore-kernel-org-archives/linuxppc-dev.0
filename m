Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B19F31A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 17:28:09 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 12:58:02 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 46BCD3940049
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 12:58:00 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P7TANn32309310
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 12:59:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P7RvwI021299
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 12:57:57 +0530
Message-ID: <53AA79FB.5000202@linux.vnet.ibm.com>
Date: Wed, 25 Jun 2014 15:27:55 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Create eeh sysfs entry in post_init()
References: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140625053312.GA3808@shangw>
In-Reply-To: <20140625053312.GA3808@shangw>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2014 01:33 PM, Gavin Shan wrote:
> On Tue, Jun 24, 2014 at 11:32:07PM -0400, Mike Qiu wrote:
>
> [ cc Richard ]
>
>> Eeh sysfs entry created must be after EEH_ENABLED been set
>> in eeh_subsystem_flags.
>>
>> In PowerNV platform, it try to create sysfs entry before
>> EEH_ENABLED been set, when boot up. So nothing will be
>> created for eeh in sysfs.
>>
> Could you please make the commit log more clear? :-)
>
> I guess the issue is introduced by commit 2213fb1 ("
> powerpc/eeh: Skip eeh sysfs when eeh is disabled"). The
> commit checks EEH is enabled while creating PCI device
> EEH sysfs files. If not, the sysfs files won't be created.
> That's to avoid warning reported during PCI hotplug.
>
> The problem you're reporting (if I understand completely):
> You don't see the sysfs files after the system boots up.
> If it's the case, you probably need following changes in
> arch/powerpc/platforms/powernv/pci.c::pnv_pci_ioda_fixup().
> Could you have a try with it?
>
> #ifdef CONFIG_EEH
> 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
> -	eeh_addr_cache_build();
> 	eeh_init();
> +	eeh_addr_cache_build();
> #endif

But this was not work, as I test, see boot log below:

[    0.233993] Unable to handle kernel paging request for data at 
address 0x00000010
[    0.234086] Faulting instruction address: 0xc000000000036c84
[    0.234144] Oops: Kernel access of bad area, sig: 11 [#1]
[    0.234188] SMP NR_CPUS=1024 NUMA PowerNV
[    0.234235] Modules linked in:
[    0.234282] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 3.16.0-rc1+ #61
[    0.234339] task: c0000003bfcc0000 ti: c0000003bfd00000 task.ti: 
c0000003bfd00000
[    0.234405] NIP: c000000000036c84 LR: c000000000036c4c CTR: 
0000000000000000
[    0.234472] REGS: c0000003bfd03430 TRAP: 0300   Not tainted (3.16.0-rc1+)
[    0.234528] MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI> CR: 
44008088  XER: 00000000
[    0.234686] CFAR: c000000000009358 DAR: 0000000000000010 DSISR: 
40000000 SOFTE: 1
GPR00: c000000000036c4c c0000003bfd036b0 c000000001448d58 c0000003bce30080
GPR04: 0000000000000000 0000000000000000 0000000000000001 c0000003bce300c8
GPR08: c0000003bce300e8 0000000000000000 0000000000000000 000000003030f000
GPR12: 0000000022008042 c00000000fee1200 c000000000b0e1f0 0000000000000000
GPR16: f000000000019600 0000000000000008 000000000000003f c000000003022280
GPR20: c000000000b0e058 0000000000400000 0000000000000008 0000000000000007
GPR24: c000000003120f80 c000000000b0e2d0 c0000000013bc6f0 c0000003bca18400
GPR28: 0000000000000000 c000000003010000 c0000003bce30080 c0000003bb2c3b40
[    0.235582] NIP [c000000000036c84] .eeh_add_to_parent_pe+0x164/0x340
[    0.235639] LR [c000000000036c4c] .eeh_add_to_parent_pe+0x12c/0x340
[    0.235695] Call Trace:
[    0.235719] [c0000003bfd036b0] [c000000000036c4c] 
.eeh_add_to_parent_pe+0x12c/0x340 (unreliable)
[    0.235810] [c0000003bfd03730] [c000000000070ee8] 
.powernv_eeh_dev_probe+0x158/0x1d0
[    0.235890] [c0000003bfd037c0] [c00000000048768c] 
.pci_walk_bus+0x8c/0x120
[    0.235957] [c0000003bfd03860] [c0000000000341c4] .eeh_init+0xf4/0x310
[    0.236025] [c0000003bfd03900] [c00000000006e7a8] 
.pnv_pci_ioda_fixup+0x688/0xb30
[    0.236105] [c0000003bfd03a60] [c000000000c2ee90] 
.pcibios_resource_survey+0x334/0x3f4
[    0.236183] [c0000003bfd03b50] [c000000000c2e65c] .pcibios_init+0xa0/0xd4
[    0.236251] [c0000003bfd03be0] [c00000000000bc94] 
.do_one_initcall+0x124/0x280
[    0.236329] [c0000003bfd03cd0] [c000000000c24acc] 
.kernel_init_freeable+0x250/0x348
[    0.236408] [c0000003bfd03db0] [c00000000000c4c4] .kernel_init+0x24/0x140
[    0.236475] [c0000003bfd03e30] [c00000000000a45c] 
.ret_from_kernel_thread+0x58/0x7c
[    0.236553] Instruction dump:
[    0.236586] 815f000c 60000000 e9228890 915e000c 81290000 7926f7e3 
813f0008 913e0008
[    0.236698] 41820018 2fbf0000 419e0154 e93f0088 <e9290010> f93e0018 
e93f0080 48000034
[    0.236819] ---[ end trace e78b31e354e84859 ]---
[    0.236864]
[    2.236933] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b

This may because  edev->pdev is set in eeh_addr_cache_build(), while 
eeh_init() use that entry.

After changed the code, the call patch:

eeh_init() ---->
                         pci_walk_bus()---->
powernv_eeh_dev_probe() ----->
                                        eeh_add_to_parent_pe()
eeh_addr_cache_build()

We can see in
eeh_add_to_parent_pe() {
......
pe->bus = eeh_dev_to_pci_dev(edev)->bus;
......
}

That is sure eeh_dev_to_pci_dev(edev) will be *NULL*, because this is 
set in  eeh_addr_cache_build()


Thanks
Mike
> Eventually PowerNV/pSeries have same function call sequence:
>
> - Set EEH probe mode
> - Doing probe (with device node or PCI device)
> - Build address cache.
>
>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>> ---
>> arch/powerpc/platforms/powernv/eeh-ioda.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> index 8ad0c5b..5f95581 100644
>> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>> @@ -136,6 +136,9 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
>> 	struct pnv_phb *phb = hose->private_data;
>> 	int ret;
>>
>> +	/* Creat sysfs after EEH_ENABLED been set */
>> +	eeh_add_sysfs_files(hose->bus);
>> +
>> 	/* Register OPAL event notifier */
>> 	if (!ioda_eeh_nb_init) {
>> 		ret = opal_notifier_register(&ioda_eeh_nb);
> Thanks,
> Gavin
>
>
