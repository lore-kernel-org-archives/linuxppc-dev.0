Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9Ml8659lzDvYr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Nov 2016 00:15:15 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA4DDbNA002475
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 09:15:13 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26gtjfafsu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 09:15:13 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 4 Nov 2016 07:15:12 -0600
Subject: Re: [RESEND] [PATCH v3] cxl: Prevent adapter reset if an active
 context exists
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <1476437916-31010-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <544d8d01-162a-9634-258d-05e6314bddcc@au1.ibm.com>
 <f95e641e-3ceb-5f28-ea45-95fce2d9d2e1@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 gkurz@linux.vnet.ibm.com, Christophe Lombard <clombard@linux.vnet.ibm.com>,
 stable@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Date: Fri, 4 Nov 2016 08:15:20 -0500
MIME-Version: 1.0
In-Reply-To: <f95e641e-3ceb-5f28-ea45-95fce2d9d2e1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d318986b-6495-25f0-193d-aef046af6938@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic/Andrew,

Just recently this issue has been reported by system test without any
of the two patches you are suspecting - this patch nor the lspci patch.
I was hoping the lspci patch from Andrew can possibly solve it.
System test CQ is SW370625. The stack reported in that is same,

[ 5895.245959] EEH: PHB#2 failure detected, location: N/A
[ 5895.246078] CPU: 19 PID: 121774 Comm: lspci Not tainted
3.10.0-514.el7.ppc64le #1
[ 5895.246240] Call Trace:
[ 5895.246307] [c0000009f3707a60] [c000000000017ce0]
show_stack+0x80/0x330 (unreliable)
[ 5895.246501] [c0000009f3707b10] [c0000000009b22f4]
dump_stack+0x30/0x44
[ 5895.246665] [c0000009f3707b30] [c00000000003b9ac]
eeh_dev_check_failure+0x21c/0x580
[ 5895.246855] [c0000009f3707bd0] [c0000000000879dc]
pnv_pci_read_config+0xbc/0x160
[ 5895.247045] [c0000009f3707c10] [c000000000527d54]
pci_user_read_config_dword+0x84/0x160
[ 5895.247233] [c0000009f3707c60] [c000000000547224]
pci_read_config+0xf4/0x2e0
[ 5895.247398] [c0000009f3707ce0] [c0000000003efb3c] read+0x10c/0x2a0
[ 5895.247561] [c0000009f3707da0] [c00000000031d160]
vfs_read+0x110/0x290
[ 5895.247726] [c0000009f3707de0] [c00000000031ec70]
SyS_pread64+0xb0/0xd0

Uma Krishnan


On 11/4/2016 7:07 AM, Frederic Barrat wrote:
> Hi Andrew,
>
> Le 04/11/2016 à 07:27, Andrew Donnellan a écrit :
>> On 14/10/16 20:38, Vaibhav Jain wrote:
>>> This patch prevents resetting the cxl adapter via sysfs in presence of
>>> one or more active cxl_context on it. This protects against an
>>> unrecoverable error caused by PSL owning a dirty cache line even after
>>> reset and host tries to touch the same cache line. In case a force reset
>>> of the card is required irrespective of any active contexts, the int
>>> value -1 can be stored in the 'reset' sysfs attribute of the card.
>>>
>>> The patch introduces a new atomic_t member named contexts_num inside
>>> struct cxl that holds the number of active context attached to the card
>>> , which is checked against '0' before proceeding with the reset. To
>>> prevent against a race condition where a context is activated just after
>>> reset check is performed, the contexts_num is atomically set to '-1'
>>> after reset-check to indicate that no more contexts can be activated on
>>> the card anymore.
>>>
>>> Before activating a context we atomically test if contexts_num is
>>> non-negative and if so, increment its value by one. In case the value of
>>> contexts_num is negative then it indicates that the card is about to be
>>> reset and context activation is error-ed out at that point.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 62fa19d4 ("cxl: Add ability to reset the card")
>>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>>> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>>
>> When I inject an EEH error, this patch causes the following WARN.
>> Thoughts?
>
> mmm, hard to see a relation with that patch. I couldn't reproduce
> either. Could it bear any relation with the patch you're working on
> (lspci called while the capi device is unconfigured)?
>
>   Fred
>
>
>>
>>
>> [   55.965011] EEH: PHB#0 failure detected, location: N/A
>> [   55.965078] CPU: 20 PID: 9933 Comm: lspci Not tainted
>> 4.9.0-rc1-ajd-00006-g6fb17cc #4
>> [   55.965080] Call Trace:
>> [   55.965091] [c00000036818fab0] [c000000000950ec8]
>> dump_stack+0xb0/0xf0 (unreliable)
>> [   55.965100] [c00000036818faf0] [c00000000002eb44]
>> eeh_dev_check_failure+0x1e4/0x540
>> [   55.965107] [c00000036818fb90] [c000000000064090]
>> pnv_pci_read_config+0xc0/0x130
>> [   55.965114] [c00000036818fbd0] [c0000000004bec24]
>> pci_user_read_config_dword+0x84/0x160
>> [   55.965119] [c00000036818fc20] [c0000000004d12f4]
>> pci_read_config+0x164/0x2a0
>> [   55.965125] [c00000036818fca0] [c000000000318e70]
>> sysfs_kf_bin_read+0x70/0xc0
>> [   55.965131] [c00000036818fcc0] [c000000000317ff8]
>> kernfs_fop_read+0xd8/0x260
>> [   55.965136] [c00000036818fd10] [c000000000278b7c]
>> __vfs_read+0x3c/0x180
>> [   55.965141] [c00000036818fda0] [c000000000279e2c] vfs_read+0xac/0x1a0
>> [   55.965146] [c00000036818fde0] [c00000000027bc24]
>> SyS_pread64+0xb4/0xd0
>> [   55.965152] [c00000036818fe30] [c00000000000bd20]
>> system_call+0x38/0xfc
>> [   55.965171] EEH: Detected error on PHB#0
>> [   55.965173] EEH: This PCI device has failed 1 times in the last hour
>> [   55.965174] EEH: Notify device drivers to shutdown
>> [   55.965182] cxl afu0.0: Deactivating AFU directed mode
>> [   55.965261] Harmless Hypervisor Maintenance interrupt [Recovered]
>> [   55.965263]  Error detail: Unknown
>> [   55.965265]  HMER: 8040000000000000
>> [   55.965267] Harmless Hypervisor Maintenance interrupt [Recovered]
>> [   55.965268]  Error detail: Unknown
>> [   55.965270]  HMER: 8040000000000000
>> [   55.965326] cxl afu0.0: PSL Purge called with link down, ignoring
>> [   55.965563] EEH: Collect temporary log
>> [   55.965565] PHB3 PHB#0 Diag-data (Version: 1)
>> [   55.965566] brdgCtl:     0000ffff
>> [   55.965568] UtlSts:      00200000 00000000 00000000
>> [   55.965570] RootSts:     ffffffff ffffffff ffffffff ffffffff 0000ffff
>> [   55.965571] RootErrSts:  ffffffff ffffffff ffffffff
>> [   55.965572] RootErrLog:  ffffffff ffffffff ffffffff ffffffff
>> [   55.965574] RootErrLog1: ffffffff 0000000000000000 0000000000000000
>> [   55.965575] nFir:        0000809000000000 0030006e00000000
>> 0000800000000000
>> [   55.965577] PhbSts:      0000001c00000000 0000001c00000000
>> [   55.965578] Lem:         0000020000100000 40018e2400022482
>> 0000000000100000
>> [   55.965582] OutErr:      0000002000000000 0000002000000000
>> 0000000000000000 0000000000000000
>> [   55.965584] InAErr:      8000000000000000 8000000000000000
>> 0402000000000000 0000000000000000
>> [   55.965586] PE[  0] A/B: 8000000000000000 8000000000000000
>> [   55.965587] EEH: Reset without hotplug activity
>> [   60.592750] EEH: Notify device drivers the completion of reset
>> [   60.592760] cxl-pci 0000:01:00.0: enabling device (0140 -> 0142)
>> [   60.593018] pci 0000:01     : [PE# 000] Switching PHB to CXL
>> [   60.593116] pci 0000:01     : [PE# 000] Switching PHB to CXL
>> [   60.622727] Adapter context unlocked with 0 active contexts
>> [   60.622762] ------------[ cut here ]------------
>> [   60.622771] WARNING: CPU: 12 PID: 627 at
>> ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 [cxl]
>> [   60.622772] Modules linked in: fuse powernv_rng rng_core leds_powernv
>> powernv_op_panel led_class vmx_crypto ib_iser rdma_cm iw_cm ib_cm
>> ib_core libiscsi scsi_transport_iscsi autofs4 btrfs raid10 raid456
>> async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq
>> multipath bnx2x mdio libcrc32c cxl
>> [   60.622794] CPU: 12 PID: 627 Comm: eehd Not tainted
>> 4.9.0-rc1-ajd-00006-g6fb17cc #4
>> [   60.622795] task: c0000003be084900 task.stack: c0000003be108000
>> [   60.622797] NIP: d000000004350be0 LR: d000000004350bdc CTR:
>> c000000000492fd0
>> [   60.622799] REGS: c0000003be10b660 TRAP: 0700   Not tainted
>> (4.9.0-rc1-ajd-00006-g6fb17cc)
>> [   60.622800] MSR: 900000010282b033
>> <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
>> [   60.622810]   CR: 28000282  XER: 20000000
>> [   60.622811] SOFTE: 1 CFAR: c00000000094fc88
>> [   60.622814] GPR00: d000000004350bdc c0000003be10b8e0 d000000004379ae8
>> 000000000000002f
>> [   60.622818] GPR04: 0000000000000001 0000000000000000 00000000000003b8
>> 0000000000000000
>> [   60.622822] GPR08: 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000001
>> [   60.622826] GPR12: 0000000000000000 c00000000fe03000 c0000000000baac8
>> c0000003c5166500
>> [   60.622830] GPR16: 0000000000000000 0000000000000000 0000000000000000
>> 0000000000000000
>> [   60.622834] GPR20: 0000000000000000 0000000000000000 0000000000000000
>> c000000000b14fe8
>> [   60.622837] GPR24: c000000000b14fc0 c0000003afc10400 c0000003b0c40000
>> 0000000000000000
>> [   60.622841] GPR28: c0000003c505a098 0000000000000000 c0000003afc10400
>> 0000000000000006
>> [   60.622850] NIP [d000000004350be0]
>> cxl_adapter_context_unlock+0x60/0x80 [cxl]
>> [   60.622856] LR [d000000004350bdc]
>> cxl_adapter_context_unlock+0x5c/0x80 [cxl]
>> [   60.622857] Call Trace:
>> [   60.622863] [c0000003be10b8e0] [d000000004350bdc]
>> cxl_adapter_context_unlock+0x5c/0x80 [cxl] (unreliable)
>> [   60.622871] [c0000003be10b940] [d00000000435e810]
>> cxl_configure_adapter+0x930/0x960 [cxl]
>> [   60.622879] [c0000003be10b9f0] [d00000000435e88c]
>> cxl_pci_slot_reset+0x4c/0x230 [cxl]
>> [   60.622883] [c0000003be10baa0] [c000000000032cd4]
>> eeh_report_reset+0x164/0x1a0
>> [   60.622887] [c0000003be10bae0] [c000000000031220]
>> eeh_pe_dev_traverse+0x90/0x170
>> [   60.622890] [c0000003be10bb70] [c000000000033354]
>> eeh_handle_normal_event+0x3d4/0x520
>> [   60.622892] [c0000003be10bc20] [c000000000033624]
>> eeh_handle_event+0x44/0x360
>> [   60.622895] [c0000003be10bcd0] [c000000000033a58]
>> eeh_event_handler+0x118/0x1d0
>> [   60.622898] [c0000003be10bd80] [c0000000000babc8] kthread+0x108/0x130
>> [   60.622902] [c0000003be10be30] [c00000000000c0a0]
>> ret_from_kernel_thread+0x5c/0xbc
>> [   60.622903] Instruction dump:
>> [   60.622905] 2f84ffff 4dfe0020 7c0802a6 7c8407b4 39200000 f8010010
>> f821ffa1 91230348
>> [   60.622911] 3c620000 e8638070 48016639 e8410018 <0fe00000> 38210060
>> e8010010 7c0803a6
>> [   60.622918] ---[ end trace d358551c9a007b4f ]---
>> [   60.622959] cxl afu0.0: Activating AFU directed mode
>> [   60.623097] EEH: Notify device driver to resume
>>
>>
>
