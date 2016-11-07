Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBtc759JnzDvNV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 11:29:27 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA70TFe5030721
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 6 Nov 2016 19:29:25 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26h922syp1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Nov 2016 19:29:25 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 7 Nov 2016 10:29:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 876BD2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 11:29:18 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA70TI7O3277150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 11:29:18 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA70THwl006083
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 11:29:18 +1100
Subject: Re: [RESEND] [PATCH v3] cxl: Prevent adapter reset if an active
 context exists
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
References: <1476437916-31010-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <544d8d01-162a-9634-258d-05e6314bddcc@au1.ibm.com>
 <f95e641e-3ceb-5f28-ea45-95fce2d9d2e1@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 stable@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>,
 gkurz@linux.vnet.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 7 Nov 2016 11:29:16 +1100
MIME-Version: 1.0
In-Reply-To: <f95e641e-3ceb-5f28-ea45-95fce2d9d2e1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e100268c-e15c-0b0c-62eb-b3ab10a8ce64@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/16 23:07, Frederic Barrat wrote:
>> When I inject an EEH error, this patch causes the following WARN.
>> Thoughts?
>
> mmm, hard to see a relation with that patch. I couldn't reproduce
> either. Could it bear any relation with the patch you're working on
> (lspci called while the capi device is unconfigured)?

No, this was without any other patches...

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

That *definitely* looks related to this patch...


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
