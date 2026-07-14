Return-Path: <linuxppc-dev+bounces-24186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EE1C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 04:48:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzmzS353Sz2y71;
	Tue, 14 Jul 2026 14:48:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784004532;
	cv=none; b=UsPGec4nyxZ7EsrR0hVbr/enhP+50ocBdEyKlh0mN5wdakIwl/owqjW77aHelSc2VjHllKeRSzTw0HQ+zzcdlfBnn22Us3sMO9exLZW8jWeuE3SIviXe7wtPobf4fvMOJ5/5f2Ku1M8GnqGNk20nKbPipTTaCpouCmNNCJpxO5rfxH6SVHcVDfSk4xsVWms4h/2rYJx1Ka4ZN8FQq8N9bHjbYdLjk1/y5yv1/oq+KqIn1Sm4R26UWN9ghdEtee6Rq6zIjFbyWvwIWm5F6hM+637dmiAPT6UAhhNzTAALM8PTju3Eaoc7mOxXxM0Sn9z1wufyiw5nweVDwWQgH1AhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784004532; c=relaxed/relaxed;
	bh=cqXVe80SJTZPvo2iwEmdhzBsrs8+umAmYsdY068iB8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuzwrnZH7Xnd7Q2eYApcsgI+HTZTruaDGDL8iOFO0iS0zhctlxse1nUxtAuW4J9WzCU4qHbqwIqdNDL9Rs/DtaSagpVlIU5PkwOajrQ9WOGxVibW+5j4k+nxr11CNmdTxjHNvVdFBApnBCOIDgUN27x7Kn8urz/6rKLtfpwaMNka7EucYHa6xIkrCZg9DucUp8mCDBKJ5Bk6pQNqfJONNJQF6LMJxRxD1hBCol4trzLHsxhcNTHNB/2ks/f0nZoJJ9GiwLAAaZI25T1eK/THkCfxRHsRiFalwyvkmqLXnbLJz7fbjkai75wjNIBGBQ3uwJyXFROYP2eytMHDXnci6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pNXHuuXk; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pNXHuuXk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzmzR53bvz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 14:48:51 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E3BvNg127000;
	Tue, 14 Jul 2026 04:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cqXVe8
	0SJTZPvo2iwEmdhzBsrs8+umAmYsdY068iB8U=; b=pNXHuuXkzfHb7Ip6MiZNMj
	oYvFb1K/WF3tUvp/KtSp/LS+BoiH7/O0jtxT5mvxA6HvQ1FCAYi9xC33Cl2Qgeqn
	IFbCyHFNQ5L/bAxmwWoy7H/KHihaf+1qTUxfbvde1ukbYCGNDuwb5oRjQ8BmMEOF
	EFBu3tl12KbL/0ggX0ea4Hhrn4/rDGyU5F7shHB/Wp0MCuaLOah6HVB1AsnS4mhc
	CouBscU5IpaECvRfUwUxkI/jrWRzkS8iTHjnNIo5IMuLlihtzEqRf5Vld2mGD1sO
	ZJP1PPo/Y/FYrwPO0+fX0gkH5G2iE/TWmGg03PkNSYBkXmV8gqBwFZmmxrfYjgKg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxc5ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 04:48:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E4YlqV032578;
	Tue, 14 Jul 2026 04:48:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uy0mnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 04:48:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E4mNpd61276474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 04:48:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C9258055;
	Tue, 14 Jul 2026 04:48:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC86558059;
	Tue, 14 Jul 2026 04:48:19 +0000 (GMT)
Received: from [9.123.5.176] (unknown [9.123.5.176])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jul 2026 04:48:19 +0000 (GMT)
Message-ID: <edb7bc45-87a8-4627-8761-96e2ecb28e8e@linux.ibm.com>
Date: Tue, 14 Jul 2026 10:18:18 +0530
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
Subject: Re: [PATCH] powerpc/powernv: fix null pointer dereference in
 pnv_get_random_long()
To: Paul Menzel <pmenzel@molgen.mpg.de>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260511120413.254934-2-pmenzel@molgen.mpg.de>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260511120413.254934-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fA7TLOmeliu1zxuTAS-MPHgWYGQ9OxTE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA0NSBTYWx0ZWRfX7Oa1gOV7434S
 AdSxHKLuKhEMG+Oghi9nPwGXNQs7vfdBm4+qMIgUB7tBVggvairo9RY6CGARxw4D0U3fCTO93fH
 pMsVckVv8IC+XH4TmFriLK3IQhH43C8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA0NSBTYWx0ZWRfXyQ/cj99G5eD4
 YpbPbFH3gGHYzgSvvmnTaiZ16RlO/PR9jMr48JMasld1MdKqymjN6DxsYxV5gsvqB9mtdGDdJid
 jXKorjX329lP6EgNqcUIOiZdY98cETLV6SoeZm2buE/6CWe9dSJBQ9PNCa7pTjYucb+H5U16svR
 APBIQVEcqt4PEzMg9x3zYN3ewsJgzh+DStECp9sFOUD24+m6N7n6AEmNpMLZcVaaEjaY/bG0Vym
 +AJKrlUpdQHq1/QEvp9+XLHr2Opo87R9bjbGZ/mgqDNkeG6ViY8btebiEY3MDM7xBkArUTSV4gk
 RAE/SWD6GvBcliOSFk049C1ZUdYpInohJGlJKJAGREyoo1ZOifPSd53b16orDrWnWgI7eTS0q4V
 /0b4oXCxi66Ec63Iw0bTZuqQe9wv/ea5ReYFicxdZetunEpJdz0zAWdAa17KBfxumxvjHWBZzjy
 6EKOiWrDiIuslypjWBw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a55bf99 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=UGG5zPGqAAAA:8 a=TaPjbHdsciI2fCAiIo4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=17ibUXfGiVyGqR_YBevW:22
X-Proofpoint-ORIG-GUID: cPATeZ5Ffd-2fVf4s6zgDX2EhauY4Gso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140045


On 5/11/26 5:34 PM, Paul Menzel wrote:
> pnv_get_random_long() dereferences the per-CPU pnv_rng pointer without
> checking whether it has been initialized resulting in the oops below:
>
>      [    0.000000] Linux version 7.1.0-rc2+ (pmenzel@flughafenberlinbrandenburgwillybrandt.molgen.mpg.de) (gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0, GNU ld (GNU Binutils for Ubuntu) 2.37) #3 SMP PREEMPT Wed May  6 08:50:58 CEST 2026
>      […]
>      [   17.901992] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
>      [   17.902011] BUG: Kernel NULL pointer dereference on read at 0x00000000
>      [   17.902018] Faulting instruction address: 0xc0000000000e7138
>      [   17.902027] Oops: Kernel access of bad area, sig: 11 [#1]
>      [   17.902034] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
>      [   17.902045] Modules linked in: powernv_rng(+) bnx2x ofpart ibmpowernv bfq mdio cmdlinepart powernv_flash ipmi_powernv ipmi_devintf mtd ipmi_msghandler at24(+) vmx_crypto opal_prd sch_fq_codel nfsd parport_pc ppdev auth_rpcgss nfs_acl lp lockd grace parport sunrpc autofs4 btrfs xor libblake2b raid6_pq ast drm_shmem_helper drm_client_lib i2c_algo_bit drm_kms_helper drm ahci drm_panel_orientation_quirks libahci
>      [   17.902185] CPU: 147 UID: 0 PID: 2626 Comm: hwrng Not tainted 7.1.0-rc2+ #3 PREEMPTLAZY
>      [   17.902197] Hardware name: 8335-GCA POWER8 (raw) 0x4d0200 opal:skiboot-5.4.8-5787ad3 PowerNV
>      [   17.902204] NIP:  c0000000000e7138 LR: c00800001ec8013c CTR: c0000000000e70fc
>      [   17.902212] REGS: c000000092913c50 TRAP: 0300   Not tainted  (7.1.0-rc2+)
>      [   17.902222] MSR:  900000000280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44420220  XER: 20000000
>      [   17.902269] CFAR: c00800001ec8026c DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
>                     GPR00: c00800001ec8013c c000000092913ef0 c000000001c18100 c00000002222d900
>                     GPR04: c00000002222d900 0000000000000080 0000000000000001 0000000000000000
>                     GPR08: 0000000000000000 c000000002212000 c0000000951e1780 c00800001ec80258
>                     GPR12: c0000000000e70fc c00000ffff6fd700 c0000000001d11c0 c00000001b99b9c0
>                     GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                     GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>                     GPR24: 0000000000000000 c000000002fe6a58 0000000000000000 0000000000000000
>                     GPR28: c000000002fe6a20 0000000000000010 000000000000000f c00000002222d900
>      [   17.902406] NIP [c0000000000e7138] pnv_get_random_long+0x3c/0x114
>      [   17.902426] LR [c00800001ec8013c] powernv_rng_read+0x78/0xc4 [powernv_rng]
>      [   17.902444] Call Trace:
>      [   17.902448] [c000000092913ef0] [c000000092913f30] 0xc000000092913f30 (unreliable)
>      [   17.902463] [c000000092913f30] [c000000000decd58] hwrng_fillfn+0xd4/0x3dc
>      [   17.902484] [c000000092913f90] [c0000000001d1328] kthread+0x170/0x1a4
>      [   17.902498] [c000000092913fe0] [c00000000000d030] start_kernel_thread+0x14/0x18
>      [   17.902513] Code: 60000000 7d2000a6 71290010 418200bc e94d0908 812a0000 39290001 912a0000 e90d0030 3d220060 39299f00 7d08482a <e9280000> 7c0004ac e8e90000 0c070000
>      [   17.902569] ---[ end trace 0000000000000000 ]---
>      [   18.008801] pstore: backend (nvram) writing error (-1)
>
>      [   18.015458] note: hwrng[2626] exited with irqs disabled
>      [   18.015483] note: hwrng[2626] exited with preempt_count 1
>
> Commit f3eac426657d ("powerpc/powernv: wire up rng during setup_arch")
> introduced a lazy initialization path via pnv_get_random_long_early():
> per-CPU pointers are left NULL until slab becomes available and
> rng_create() completes.
>
> pnv_get_random_long() is an exported symbol called directly by the
> powernv_rng hwrng module (powernv_rng_read()), bypassing the
> ppc_md.get_random_seed guard that would otherwise ensure per-CPU data is
> ready.  If the hwrng fill thread runs on a CPU whose slot is still NULL,
> the function crashes dereferencing rng->regs at offset 0.
>
> Guard both branches with a NULL check and return 0 (no data) when the
> per-CPU pointer has not been set up yet.
>
> Testing on the IBM Power S822LC (8335-GCA POWER8 (raw) 0x4d0200
> opal:skiboot-5.4.8-5787ad3 PowerNV) is successful:
>
>      [   23.850775] powernv_rng: Registered powernv hwrng.
>
> Fixes: f3eac426657d ("powerpc/powernv: wire up rng during setup_arch")
> Link: https://lore.kernel.org/all/a159e81a-ccfd-440f-af68-6a56cca09cb2@molgen.mpg.de/
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: stable@vger.kernel.org # v5.18
> Assisted-by: Claude Sonnet 4.6
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> No idea, how to test, that the rng works as expected (and if, despite
> the missing message) it  didn’t work before.
>
>   arch/powerpc/platforms/powernv/rng.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/rng.c b/arch/powerpc/platforms/powernv/rng.c
> index 7a4c38cd6a82..dc71eaf5d954 100644
> --- a/arch/powerpc/platforms/powernv/rng.c
> +++ b/arch/powerpc/platforms/powernv/rng.c
> @@ -87,12 +87,16 @@ int pnv_get_random_long(unsigned long *v)
>   
>   	if (mfmsr() & MSR_DR) {
>   		rng = get_cpu_var(pnv_rng);
> -		*v = rng_whiten(rng, in_be64(rng->regs));
> +		if (rng)
> +			*v = rng_whiten(rng, in_be64(rng->regs));
>   		put_cpu_var(rng);
> -	} else {
> -		rng = raw_cpu_read(pnv_rng);
> -		*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));


Not sure whether I understand this. rng is not initialized, we will need 
raw_cpu_read before check right?


> +		return rng ? 1 : 0;
>   	}
> +
> +	rng = raw_cpu_read(pnv_rng);
> +	if (!rng)
> +		return 0;
> +	*v = rng_whiten(rng, __raw_rm_readq(rng->regs_real));
>   	return 1;
>   }
>   EXPORT_SYMBOL_GPL(pnv_get_random_long);

