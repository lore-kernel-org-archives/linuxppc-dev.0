Return-Path: <linuxppc-dev+bounces-25977-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA251C5DF86
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 11:02:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQ3Z56btMz2yRP;
	Wed, 19 Aug 2026 21:02:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787137357;
	cv=none; b=GFJR1PrNQw0rprcNqleXfScBRBCCHQ+h9QnjSWGuoStaSYSz3ThJzu+cFiOFZx9d+L0sggRT2wA/htZWY+93qDzKA7TvhW4h74eCt+aQdoIaJ/KbC2Rh+WHterOPBmcjl1E7eUjM99XQZOeHVRhULWDMvPOVk5FqtHu/KVVehMgiN+NdCQFy0ik0qb1Jnz6mPyiwzFIpjy0dNNAB7a5XrHXyc1rF5DizMyTGPbhT4yK/tYmyebLa/joBPZcYG+1ckgtThGwi0XyFUmZjRpgzvTOcflUlvwkIhSVQ5ldMmHUk/0PvLEAh/ybvyuPPDOxdPK7O84an8Dd5SHlOmazE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787137357; c=relaxed/relaxed;
	bh=O5UesY+xoqNP6flb/ZAxbIGZI8OcZYPFr35ftBiVGJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6nLSBRbZ2gR2Woybp40k5BVRqB5X6ZC94Q+85Y2AUdGdyGKOYZ+HmaKwK1L1jEapI/3bhvamHcwHH9rrve6ecH6NT4XxMmIaZgj10fIzCzwTrIQub0w5FZmViI8aWMSiTiDnZ0HrHzfTca57Pbt7pDtgtct4JnOUpfsl2Ox80bd0OPRXWHqiHRbsTQqPIZWBveW5xWnzCCR7utjHf2hGvuieD74hAHF/WUD5Gxb8m3o3x8pSSAmzy+LkWRy889ijD16VgJwcprJI3YZ2Lvwx++fTkIHj4dGXDPP8iKwO1eog4KJExwTTlEn8Et+Wl2bUq8Ot/ptM4LOysDAxTKrnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nnLDW85G; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nnLDW85G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQ3Z45z2Rz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 21:02:36 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVsDs3191621;
	Wed, 19 Aug 2026 11:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O5UesY
	+xoqNP6flb/ZAxbIGZI8OcZYPFr35ftBiVGJQ=; b=nnLDW85G1yh0dV+5Yla29S
	+9/9x2Ad1easfkWguuQXf9D841kwi2c/paB31mx4oHHd7V4G8b0vA/xaRx4EIxi9
	sCzMpS/eUS+DC5xZJxhx1CW//4opgFAFSp+YU4Wg+LL6slY2coI5B+xV3yv+V9yr
	Kq4XvGSsZOotyJ+GEtM1imsFcfyhYohMaB6I1MnbBNDrz+quXxG7Luz0VO3YOgCp
	0HbyV8jOSUQ7BKq5oBfDZs+brQ2TfPhvFoo9ugEQToI3wepo+UZ/0W7yDK/+BQs7
	rnmJW+ByBGdsU5y1T+Wc/xyYTIv2+oj7Z2twqtniaeN7THcZKVa2dMsYeRYZaiEw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0b762-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:02:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JAuJiQ013597;
	Wed, 19 Aug 2026 11:02:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq8p5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 11:02:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JB2QgE31785662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 11:02:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E971F58066;
	Wed, 19 Aug 2026 11:02:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E3245806B;
	Wed, 19 Aug 2026 11:02:23 +0000 (GMT)
Received: from [9.61.240.114] (unknown [9.61.240.114])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 11:02:23 +0000 (GMT)
Message-ID: <aceec38a-7405-4020-b682-5a8c31af30f9@linux.ibm.com>
Date: Wed, 19 Aug 2026 16:32:22 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: PPC: Book3S HV nestedv2: Don't drop pending doorbell
 across L2 entry
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260803034426.44249-1-vaibhav@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260803034426.44249-1-vaibhav@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a858d45 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=7wFjLDfdxS4MxDXi_8QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: e9EcZsZib6jSnu-Za4DK3vFg0UwU4OQp
X-Proofpoint-GUID: e9EcZsZib6jSnu-Za4DK3vFg0UwU4OQp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4NSBTYWx0ZWRfXyuBrpolTtCkY
 6L5Eo89FbuWBSuPoCXseO21bo3gOpj7UvkiHzV9qhUVa8pad/Rim/t9CklzHHaM1pkw1ExMVp00
 Z7X3d9Jj/toT2GNODJIl8V5PgBLsHbQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4NSBTYWx0ZWRfXwTjkDiKnYM19
 ICwhz2dQ352IObhBA5QIpx884RAC/FOOZgam5kR693bQ2pIOsHvsf9Y7MVHB1kvekIuj+8aypxX
 j+tpbQzZnJO2X3bjXx9b0lbNnHge8MfWXJH5Vl0q37JueQlLasvu0wNks3dOuVDiPNe4nHQH+Mh
 WODxU7eYMqGCbw2AOcsURILZqkm/bwDaznZRqg5LaVVwtdPG1cLjIjqqYQNHgFgexsIoxm9/97q
 4fOUZXEc01Qs5x5zZYF00A103quOPuTj3xm7HxXdcAp2SAZq12IwclzPH9froj01aiuZwvlAH6g
 1XqmdZ61wodiNqLP8m8obHKVrygwjJg8XI85YWzJBoMeMhOiqr83om8hxekLHDdmCgvUbw59X3f
 eRQBeFzLnTmLytxWU+7wP7aF0MDGsX7hUXapH5xrCTmKifDtXnilgZcH/wEKPtmb9BJqh8xZ4Q3
 6s360VlzL7kJvyfFX1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190085



On 03/08/26 9:14 AM, Vaibhav Jain wrote:
> On nestedv2 the L1 converts a pending doorbell into guest DPDES state at
> the top of kvmhv_vcpu_entry_nestedv2() and immediately forgets about it:
>
> 	if (vcpu->arch.doorbell_request) {
> 		vcpu->arch.doorbell_request = 0;
> 		kvmppc_set_dpdes(vcpu, 1);
> 	}
>
> Clearing 'doorbell_request' at this point assumes that handing DPDES to the
> L0 is equivalent to the L2 having taken the doorbell. That is not true, and
> the doorbell can be lost in two ways:
>
>    - The block runs before the lazy_irq_pending() check, so the doorbell is
>      consumed even on the path that returns 0 without ever calling
>      H_GUEST_RUN_VCPU.
>
>    - DPDES stays pending in the L2 until it is actually delivered. The L2
>      may exit for an unrelated reason (hcall, page fault, HDEC) with the
>      doorbell still set, typically because it was running with MSR[EE]=0.
>      Nothing reloads DPDES afterwards, so the L1 never learns this.
>
> Once 'doorbell_request' has been cleared, the L1 has no record of the
> pending doorbell. kvmppc_doorbell_pending() returns false, so
> kvmppc_read_dpdes() reports the target thread as idle when a sibling vCPU
> emulates 'mfspr DPDES', and the vCPU can be treated as having no work
> pending and blocked. From the L2's point of view the doorbell is silently
> lost, which shows up as an SMT guest hanging on a doorbell-based IPI.
>
> Fix this by making 'doorbell_request' track the L2's DPDES rather than
> being consumed by entry:
>
>    - inject DPDES after the early-return paths and before
>      kvmhv_nestedv2_flush_vcpu() serializes it into the vcpu run input
>      buffer, and no longer clear 'doorbell_request' there,
>
>    - after H_GUEST_RUN_VCPU, reload DPDES from the L0. The run output only
>      carries the state the L0 chose to return and the 'valids' bitmap is
>      zeroed on exit, so an explicit kvmhv_nestedv2_cached_reload() is
>      needed to see the L2's current value,
>
>    - if DPDES is still set the doorbell was not delivered, so keep
>      'doorbell_request' pending so that it is re-injected on the next
>      entry; otherwise clear it.
>
> This keeps a pending doorbell visible to the L1 for as long as the L2 has
> not consumed it, so vCPU wakeup and DPDES emulation on sibling vCPUs stay
> consistent with the L2's actual state.
>
> Fixes: 54ec2bd9e017 ("KVM: PPC: Book3S HV nestedv2: Fix doorbell emulation")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Assisted-by: Claude:Opus-5
> ---
>   arch/powerpc/kvm/book3s_hv.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..40f8717b8a7d 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -15,6 +15,7 @@
>    * by Alexander Graf <agraf@suse.de>.
>    */
>   
> +#include "asm/guest-state-buffer.h"
>   #include <linux/kvm_host.h>
>   #include <linux/kernel.h>
>   #include <linux/err.h>
> @@ -4253,11 +4254,6 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>   	int trap;
>   	long rc;
>   
> -	if (vcpu->arch.doorbell_request) {
> -		vcpu->arch.doorbell_request = 0;
> -		kvmppc_set_dpdes(vcpu, 1);
> -	}
> -
>   	io = &vcpu->arch.nestedv2_io;
>   
>   	msr = mfmsr();
> @@ -4265,6 +4261,9 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>   	if (lazy_irq_pending())
>   		return 0;
>   
> +	if (vcpu->arch.doorbell_request)
> +		kvmppc_set_dpdes(vcpu, 1);
> +
>   	rc = kvmhv_nestedv2_flush_vcpu(vcpu, time_limit);
>   	if (rc < 0)
>   		return -EINVAL;
> @@ -4296,6 +4295,17 @@ static int kvmhv_vcpu_entry_nestedv2(struct kvm_vcpu *vcpu, u64 time_limit,
>   	if (rc < 0)
>   		return -EINVAL;
>   
> +	/* Check if privileged door bell was requested and handled */
> +	if (vcpu->arch.vcore->dpdes) {
> +		kvmhv_nestedv2_cached_reload(vcpu, KVMPPC_GSID_DPDES);
> +		if (vcpu->arch.vcore->dpdes)
> +			vcpu->arch.doorbell_request |= vcpu->arch.vcore->dpdes;
> +		else
> +			cpu->arch.doorbell_request = 0;
> +	} else {
> +		vcpu->arch.doorbell_request = 0;
> +	}
> +
>   	timer_rearm_host_dec(*tb);
>   
>   	/* Record context switch and guest_run_time data */
Hi Vaibhav,

I have tested this patch and it is still giving me the issue I reported, 
so here is my analysis:

a) Without applying the patch :

1) Start the guest and run stress-ng as below for sometime
localhost:~ # stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 
1G --sched other --timeout 3600000s
stress-ng: info:  [1464] setting to a 41 days, 16 hours, 0 secs run per 
stressor
stress-ng: info:  [1464] dispatching hogs: 4 cpu, 2 vm, 2 hdd



2) Start the migration from H1 to H2:

ltc-lp7:~ # virsh migrate --live --domain sles16_anu 
qemu+ssh://10.xx.xx.xx/system --verbose --undefinesource --persistent 
--auto-converge --postcopy
(root@10.xx.xx.xx) Password:
Migration: [100.00 %]

3) Migration got completed but guest is not getting recovered from 
continuous softlockups

[ 1336.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 
977s! [htxd_monitor:1337]
[ 1336.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 
1002s! [rcu_exp_par_gp_:19]
[ 1346.015839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 
flags=0x0 nice=0 stuck for 1090s!
[ 1346.016355][    C0] BUG: workqueue lockup - pool cpus=3 node=0 
flags=0x0 nice=0 stuck for 1107s!
[ 1346.016874][    C0] BUG: workqueue lockup - pool cpus=7 node=0 
flags=0x0 nice=0 stuck for 1093s!
[ 1356.007835][    C6] watchdog: BUG: soft lockup - CPU#6 stuck for 
912s! [systemd:1353]
[ 1356.008835][    C7] watchdog: BUG: soft lockup - CPU#7 stuck for 
998s! [systemd-journal:570]
[ 1360.003836][    C1] watchdog: BUG: soft lockup - CPU#1 stuck for 
999s! [htxd_monitor:1337]
[ 1360.006834][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 
1024s! [rcu_exp_par_gp_:19]
[ 1368.933835][    C4] rcu: INFO: rcu_preempt self-detected stall on CPU
[ 1368.933973][    C4] rcu:     4-....: (1129830 ticks this GP) 
idle=afc4/1/0x4000000000000002 softirq=3694/428556 fqs=259639
[ 1368.934106][    C4] rcu:              hardirqs   softirqs  csw/system
[ 1368.934188][    C4] rcu:      number:        1     444039       0
[ 1368.934271][    C4] rcu:     cputime:        3          8 1096165  
  ==> 1110021(ms)
[ 1368.934373][    C4] rcu:     (t=1140022 jiffies g=6177 q=1684 ncpus=8)
[ 1376.224839][    C0] BUG: workqueue lockup - pool cpus=1 node=0 
flags=0x0 nice=0 stuck for 1120s!
[ 1376.225307][    C0] BUG: workqueue lockup - pool cpus=3 node=0 
flags=0x0 nice=0 stuck for 1138s!
[ 1376.225428][    C0] BUG: workqueue lockup - pool cpus=5 node=0 
flags=0x0 nice=0 stuck for 715s!
[ 1376.225548][    C0] BUG: workqueue lockup - pool cpus=6 node=0 
flags=0x0 nice=0 stuck for 1027s!
[ 1376.225667][    C0] BUG: workqueue lockup - pool cpus=7 node=0 
flags=0x0 nice=0 stuck for 1123s!
[ 1444.006835][    C4] watchdog: BUG: soft lockup - CPU#4 stuck for 
1100s! [rcu_exp_par_gp_:19]


b) Even after applying the patch also it is giving same softlockup issue 
as mentioned above:
Though I have enough vcpus and memory on the guest (16 vcpus , 13Gi of 
memory)  and ample amount of memory and cpus
present on host still these softlockups are happening after applying the 
patch too. I tried reducing stress also on the guest
but still this issue is seen.

stress-ng --cpu 4 --vm 2 --vm-bytes 1G --hdd 2 --hdd-bytes 1G --sched 
other --timeout 3600000s

If you are planning to send next version of this patch,
Please do add my reported-by:
Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>

