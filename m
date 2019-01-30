Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0CEC282D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 07:03:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6B020857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 07:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6B020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qDpt2W7xzDqSJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 18:03:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.131; helo=7.mo7.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 7.mo7.mail-out.ovh.net (7.mo7.mail-out.ovh.net [46.105.43.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qDmw4bwxzDqSJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 18:01:34 +1100 (AEDT)
Received: from player697.ha.ovh.net (unknown [10.109.159.139])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0E793F84CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 08:01:30 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player697.ha.ovh.net (Postfix) with ESMTPSA id 00CC122FBB4C;
 Wed, 30 Jan 2019 07:01:22 +0000 (UTC)
Subject: Re: [PATCH 05/19] KVM: PPC: Book3S HV: add a new KVM device for the
 XIVE native exploitation mode
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-6-clg@kaod.org> <20190122050520.GC15124@blackberry>
 <d21664e5-1d9c-5a55-5b83-bf5e6247917a@kaod.org>
 <20190130042919.GA27109@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <74d4fe26-9e5a-a72e-815a-223a55f1bc0f@kaod.org>
Date: Wed, 30 Jan 2019 08:01:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130042919.GA27109@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5461177501257075591
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/30/19 5:29 AM, Paul Mackerras wrote:
> On Mon, Jan 28, 2019 at 06:35:34PM +0100, Cédric Le Goater wrote:
>> On 1/22/19 6:05 AM, Paul Mackerras wrote:
>>> On Mon, Jan 07, 2019 at 07:43:17PM +0100, Cédric Le Goater wrote:
>>>> This is the basic framework for the new KVM device supporting the XIVE
>>>> native exploitation mode. The user interface exposes a new capability
>>>> and a new KVM device to be used by QEMU.
>>>
>>> [snip]
>>>> @@ -1039,7 +1039,10 @@ static int kvmppc_book3s_init(void)
>>>>  #ifdef CONFIG_KVM_XIVE
>>>>  	if (xive_enabled()) {
>>>>  		kvmppc_xive_init_module();
>>>> +		kvmppc_xive_native_init_module();
>>>>  		kvm_register_device_ops(&kvm_xive_ops, KVM_DEV_TYPE_XICS);
>>>> +		kvm_register_device_ops(&kvm_xive_native_ops,
>>>> +					KVM_DEV_TYPE_XIVE);
>>>
>>> I think we want tighter conditions on initializing the xive_native
>>> stuff and creating the xive device class.  We could have
>>> xive_enabled() returning true in a guest, and this code will get
>>> called both by PR KVM and HV KVM (and HV KVM no longer implies that we
>>> are running bare metal).
>>
>> So yes, I gave nested a try with kernel_irqchip=on and the nested hypervisor 
>> (L1) obviously crashes trying to call OPAL. I have tighten the test with : 
>>
>> 	if (xive_enabled() && !kvmhv_on_pseries()) {
>>
>> for now.
>>
>> As this is a problem today in 5.0.x, I will send a patch for it if you think
> 
> How do you mean this is a problem today in 5.0?  I just tried 5.0-rc1
> with kernel_irqchip=on in a nested guest and it works just fine.  What
> exactly did you test?

L0: Linux 5.0.0-rc3 (+ KVM HV)
L1:     QEMU pseries-4.0 (kernel_irqchip=on) - Linux 5.0.0-rc3 (+ KVM HV)
L2:          QEMU pseries-4.0 (kernel_irqchip=on) - Linux 5.0.0-rc3

L1 crashes when L2 starts and tries to initialize the KVM IRQ device as 
it does an OPAL call and its running under SLOF. See below.

I don't understand how L2 can work with kernel_irqchip=on. Could you
please explain ? 

>> it is correct. I don't think we should bother taking care of the PR case
>> on P9. Should we ? 
> 
> We do need to take care of PR KVM on P9, since it is the only form of
> nested KVM that works inside a host in HPT mode.

ok. That is the test case. There are quite a few combinations now.

Thanks,

C.

[   49.547056] Oops: Exception in kernel mode, sig: 4 [#1]
[   49.555101] LE SMP NR_CPUS=2048 NUMA pSeries
[   49.555132] Modules linked in: xt_CHECKSUM iptable_mangle ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6 libcrc32c nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter vmx_crypto crct10dif_vpmsum crc32c_vpmsum kvm_hv kvm sch_fq_codel ip_tables x_tables autofs4 virtio_net net_failover failover virtio_scsi
[   49.555335] CPU: 9 PID: 2162 Comm: qemu-system-ppc Kdump: loaded Not tainted 5.0.0-rc3+ #53
[   49.555378] NIP:  c0000000000a7548 LR: c0000000000a4044 CTR: c0000000000a24b0
[   49.555421] REGS: c0000003ad71f8a0 TRAP: 0700   Not tainted  (5.0.0-rc3+)
[   49.555456] MSR:  8000000000041033 <SF,ME,IR,DR,RI,LE>  CR: 44222822  XER: 20040000
[   49.555501] CFAR: c0000000000a2508 IRQMASK: 0 
[   49.555501] GPR00: 0000000000000087 c0000003ad71fb30 c00000000175f700 000000000000000b 
[   49.555501] GPR04: 0000000000000000 0000000000000000 c0000003f88d4000 000000000000000b 
[   49.555501] GPR08: 00000003fd800000 000000000000000b 0000000000000800 0000000000000031 
[   49.555501] GPR12: 8000000000001002 c000000007ff3280 0000000000000000 0000000000000000 
[   49.555501] GPR16: 00007ffff8d2bd60 0000000000000000 000002c9896d7800 00007ffff8d2b970 
[   49.555501] GPR20: 000002c95c876f90 000002c95c876fa0 000002c95c876f80 000002c95c876f70 
[   49.555501] GPR24: 000002c95cf4f648 ffffffffffffffff c0000003ab3e4058 00000000006000c0 
[   49.555501] GPR28: 000000000000000b c0000003ab3e0000 0000000000000000 c0000003f88d0000 
[   49.555883] NIP [c0000000000a7548] opal_xive_alloc_vp_block+0x50/0x68
[   49.555919] LR [c0000000000a4044] opal_return+0x0/0x48
[   49.555947] Call Trace:
[   49.555964] [c0000003ad71fb30] [c0000000000a250c] xive_native_alloc_vp_block+0x5c/0x1c0 (unreliable)
[   49.556019] [c0000003ad71fbc0] [c00800000430c0c0] kvmppc_xive_create+0x98/0x168 [kvm]
[   49.556065] [c0000003ad71fc00] [c0080000042f9fcc] kvm_vm_ioctl+0x474/0xa00 [kvm]
[   49.556113] [c0000003ad71fd10] [c000000000423a64] do_vfs_ioctl+0xd4/0x8e0
[   49.556153] [c0000003ad71fdb0] [c000000000424334] ksys_ioctl+0xc4/0x110
[   49.556190] [c0000003ad71fe00] [c0000000004243a8] sys_ioctl+0x28/0x80
[   49.556230] [c0000003ad71fe20] [c00000000000b288] system_call+0x5c/0x70
[   49.556265] Instruction dump:
[   49.556288] 60000000 7d600026 91610008 39600000 616b8000 f98d0980 7d8c5878 7d810164 
[   49.556332] e9628098 7d6803a6 39600031 7d8c5878 <7d9b4ba6> e96280b0 e98b0008 e84b0000 
[   49.556378] ---[ end trace ac7420a6784de93b ]---
