Return-Path: <linuxppc-dev+bounces-26866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161F4C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 03:59:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfnBP37L8z2xlZ;
	Wed, 09 Sep 2026 13:59:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788926381;
	cv=none; b=apsgS56CWi+f0umRaT4gM8KrZyvVj18cYSWmqSyvNh0c4A4+qjBXd8YAh7fEdzc40CuDIPv/8OEf6YqN27IeVryt1WGJvLvJFqXJauuro0WqUE7K1fc/mNLzsEcLveqSQdzIH5X/aCoUTaYgd5F+H2047jdYkibn0Gq9wk3xD/dk+3pgDt8+KbjWzHBZQ7YEVVbykQgXbnJt41IktGG34rKjs9Fo/Pg+RH3YqUgUzZWSFk5yoNnaQpXmI9JVRv7ly9tuCXHGpbwVkudtAnUjVaeZamDp3dnqAnV7K9bsecV3V1sqjcyMGoDRie3S9fSJXGrFRWeLyD5vSPLHtNXFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788926381; c=relaxed/relaxed;
	bh=2IXyS4dcdYBbk52hJjcl6POTvaPWlpDlJcvd2bgPQD8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MqQ8KDB4njnrbR7W/9bB37Iqzj6s8PbxkijzirZhRaC+aBsMXL1WxbEg7sQNKmopC5twAIIawIzsNEoxWRxS8xc3hLYWHL2Rhlx1xYncEN6SjWaoyb6f2eZA0Jcj2DnC6bulu6MlxAVLkmZMGAVcH6aLzCZFM8uCfZmJMLvPOqA2GBVvU/BWryI/fSmTrLDkRmCacfokROYVrZsTGVGel4b5zYf54aIGpXm74RciiMznaN0jEYgsQK/Rvh4suGpAgJyLt4QmiY1YbymFc0EVTiFbmUVCpfcA76XKrTc2ZQu8qLbJSqPpXC5FthOB5OsUaRMH6oQAB6DXQ2ja2EtRSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ROxV0aJI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ROxV0aJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfnBM6JdRz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 13:59:39 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1xhB2300030;
	Wed, 9 Sep 2026 03:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2IXyS4
	dcdYBbk52hJjcl6POTvaPWlpDlJcvd2bgPQD8=; b=ROxV0aJIvB0wo1u01sCtyv
	Q4z0aY0ah3HR4I4vmB34JGREXKNFyV0eTgHW9mpmnzYVr8/2itDYrk4RN4bVCcmc
	9LsoVP8+cd2Zz6qPeSvpjnDvJWdrCJdFz8Yr0Emf4cHPnAsnVtQoarsNu1vq1L2L
	Q+r0JYMJnssJy2V539mSZjhTQ9EQ+MWngGPORTy/nDk89AZzfWGShJsNjCnNDWoI
	prs9CF4ec2BEUxY67s2KQhEtmt0AFKwMhZm+jK0eQLt6lLKsv2Q4EXDucjslmKJL
	IJ9/LiXNRCnZ/kex9zeM5NNnoAhcdy15aDTs/rdQ3iSIh+0sd4X5bKqaB2r3Dxww
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf34t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 03:59:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6893fFNn015289;
	Wed, 9 Sep 2026 03:59:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqg6c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 03:59:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6893xWnJ34996530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 03:59:32 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1934558059;
	Wed,  9 Sep 2026 03:59:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EAC758057;
	Wed,  9 Sep 2026 03:59:30 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.0.173])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 03:59:30 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: =?utf-8?Q?Re=3A_=5Bmainline=5D_powerpc/TM=3A_Unexpected_TM_Bad_Th?=
 =?utf-8?Q?ing_during_core_dump_on_POWER9_=287=2E1=E2=80=91rc1=29?=
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <d18c4a14-c26f-460e-a04f-2998bc4e9e25@linux.ibm.com>
Date: Wed, 9 Sep 2026 09:29:17 +0530
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC72ED6B-156C-4EEB-A32B-2F5629F5AC00@linux.ibm.com>
References: <364996ce-aba2-4213-8d20-7dd481b43fe6@linux.ibm.com>
 <d18c4a14-c26f-460e-a04f-2998bc4e9e25@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OMpjB8Psd7KYoBm6h9h4Ed69GfUq9F5n
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa0d9a5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=5KLPUuaC_9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VnNF1IyMAAAA:8 a=MYg0dNiN2xP4QECReYwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDAzNyBTYWx0ZWRfX0eYyKAanKhk1
 DZqei4Aqa7Uirr9S4fNWSfZkcf899N7pUhoEoRZMDD8RMq0fm8Dr+y+9q1mT4CZqLeV2u8QKbKh
 Jgj1xMicrzk8sCNkGP36sAzenO0N3fs=
X-Proofpoint-ORIG-GUID: OMpjB8Psd7KYoBm6h9h4Ed69GfUq9F5n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDAzNyBTYWx0ZWRfX34FZLi13i9HH
 IIsdqcHbFUl7B0MZ5NLvSCofMvO/FyOvTUKpCNrXVWqZ4GN6x+eCmYRZWVUZaX69GJwxwvwVVmp
 12d8GltfySmU/jQ9mrrbOAbxdFlSC4sPhrHo18OaHmz3UJ4URCod63TA3NoBKBbU7yUnC8EMBGt
 5AdZHMM5g2mKdHcrf0cPstvGImUTqDtUDEtKECfdHMjIUNdK2FMtQH/ZnHgcatBD7G267KVsb06
 Wa7xHBA3bMKF3sIu33eIx75ivO6d9uH+IMv+0/pmdw0ApzKXhTgLuXBmOwE/xvTSU3TwUpjsz8Y
 LnBnkfbues1hkSIiko3qrS5rq8DhvZrdUCEsPeLr55UOrpc2Rr//OdpgCwpCe68QJzT7nriMyli
 qzeiCc1z4ImCP3RgaKyV5nm5UwjtNO9E9RyKldV3gGc59OAAe7kNNktjKvtCClrrcx/L5N1ewhO
 Me8OLMjW+CWhlk8j7Jg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090037



> On 15 May 2026, at 10:59=E2=80=AFAM, Venkat Rao Bagalkote =
<venkat88@linux.ibm.com> wrote:
>=20
>=20
> On 28/04/26 5:48 pm, Venkat Rao Bagalkote wrote:
>> Greetings!!
>>=20
>> IBM CI has reported a kernel crash while running =
selftests/powerpc/signal on a POWER9 pSeries system.
>>=20
>> I attempted to reproduce this issue manually, but was not successful =
so far.
>=20
> I=E2=80=99m now able to reproduce this issue reliably and =
consistently. The reproduction steps are simple:
>=20
> Run selftests/powerpc/signal
>=20

This issue is still present in 7.3-rc2 as well. Please let me know, if =
it=E2=80=99s invalid bug, I will make appropriate changes to my CI set =
up.

This is blocking for me.

Traces:

[12689.799298] Unexpected TM Bad Thing exception at c00000000000dbac =
(msr 0x8000000302a03031) tm_scratch=3D800000010280b033
[12689.799318] Oops: Unrecoverable exception, sig: 6 [#1]
[12689.799323] LE PAGE_SIZE=3D64K MMU=3DHash  SMP NR_CPUS=3D8192 NUMA =
pSeries
[12689.799330] Modules linked in: nvram(E) rpadlpar_io(E) rpaphp(E) =
bonding(E) tls(E) rfkill(E) nft_fib_inet(E) nft_fib_ipv4(E) =
nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E) =
nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) hvcs(E) =
hvcserver(E) pseries_rng(E) sg(E) vmx_crypto(E) drm(E) fuse(E) =
drm_panel_orientation_quirks(E) xfs(E) nvme_tcp(E) nvme_fabrics(E) =
nvme_core(E) sr_mod(E) sd_mod(E) cdrom(E) ibmvscsi(E) ibmveth(E) =
scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_mod(E)
[12689.799397] CPU: 0 UID: 0 PID: 1159004 Comm: sigfuz Tainted: G        =
    E       7.3.0-rc2-next-20260907 #1 PREEMPT=20
[12689.799405] Tainted: [E]=3DUNSIGNED_MODULE
[12689.799408] Hardware name: IBM,8375-42A POWER9 (architected) 0x4e0202 =
0xf000005 of:IBM,FW950.80 (VL950_131) hv:phyp pSeries
[12689.799414] NIP:  c00000000000dbac LR: c0000000008657f0 CTR: =
0000000000000046
[12689.799419] REGS: c00000002e86fd60 TRAP: 0700   Tainted: G            =
E        (7.3.0-rc2-next-20260907)
[12689.799425] MSR:  8000000302a03031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[SE]> =
 CR: 48004840  XER: 00000000
[12689.799444] CFAR: c00000000000da68 IRQMASK: 0=20
[12689.799444] PACATMSCRATCH: 800000010280b033=20
[12689.799444] GPR00: 0000000000000000 c000000050ff7590 c000000001ba8100 =
c0000003ccf6dd00=20
[12689.799444] GPR04: c00000031027dd00 0000000000010000 0000000000000000 =
0000000000002300=20
[12689.799444] GPR08: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[12689.799444] GPR12: 0000000000000000 c0000000030d0000 0000000000000000 =
0000000000000000=20
[12689.799444] GPR16: 0000000000000000 0000000000000000 0000000000000000 =
0000000000000000=20
[12689.799444] GPR20: 0000000000000000 0000000000000000 0000000000000000 =
c000000045beab00=20
[12689.799444] GPR24: 0000000000000000 0000000000000001 c00c000000f33d80 =
0000000010010000=20
[12689.799444] GPR28: c00000004575fe00 c000000050ff7b38 0000000010000000 =
c00c000000c409c0=20
[12689.799507] NIP [c00000000000dbac] =
interrupt_return_srr_kernel+0x15c/0x18c
[12689.799518] LR [c0000000008657f0] dump_user_range+0x100/0x570
[12689.799525] Call Trace:
[12689.799529] [c000000050ff7690] [c0000000008657f0] =
dump_user_range+0x100/0x570
[12689.799536] [c000000050ff7770] [c00000000085aefc] =
elf_core_dump+0x52c/0x5c0
[12689.799545] [c000000050ff7980] [c000000000864a20] =
coredump_write+0xe0/0x410
[12689.799552] [c000000050ff7a10] [c000000000864e10] =
do_coredump.constprop.0+0xc0/0x4e0
[12689.799559] [c000000050ff7af0] [c00000000086558c] =
vfs_coredump+0x35c/0x4c0
[12689.799565] [c000000050ff7c30] [c000000000256808] =
get_signal+0x918/0xad0
[12689.799573] [c000000050ff7d20] [c000000000021ba8] =
do_signal+0x78/0x330
[12689.799582] [c000000050ff7dc0] [c0000000014f6d48] =
irqentry_exit+0x358/0x990
[12689.799589] [c000000050ff7e20] [c00000000002f554] =
program_check_exception+0xd4/0x100
[12689.799596] [c000000050ff7e50] [c000000000009b2c] =
program_check_common_virt+0x3bc/0x3c0
[12689.799604] ---- interrupt: 700 at 0x10001e8c
[12689.799610] NIP:  0000000010001e8c LR: 0000000010001e74 CTR: =
00007fffba290590
[12689.799615] REGS: c000000050ff7e80 TRAP: 0700   Tainted: G            =
E        (7.3.0-rc2-next-20260907)
[12689.799620] MSR:  8000000302a0f033 =
<SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE,TM[SE]>  CR: 240044a0  XER: 00000000
[12689.799640] CFAR: 00007fffba2905bc IRQMASK: 0=20
[12689.799640] PACATMSCRATCH: 800000010280b033=20
[12689.799640] GPR00: 0000000010001e74 00007fffa2fdd3c0 0000000010027f00 =
0000000022bde198=20
[12689.799640] GPR04: 00007fffa2fdd384 00007fffba48004c 00007fffba480090 =
00007fffba480048=20
[12689.799640] GPR08: 00000001457bc331 0000000022bde198 0000000000000000 =
0000000022bde198=20
[12689.799640] GPR12: 00007fffba290590 00007fffa2fe68e0 0000000000000000 =
00007fffa2fdf1e0=20
[12689.799640] GPR16: 0000000000000000 00007fffa2fdf8e0 0000000000000720 =
0000000000000000=20
[12689.799640] GPR20: 0000000000000000 00007fffba580000 000000000080e9e0 =
00007fffa27d0000=20
[12689.799640] GPR24: 0000000000000001 00007ffff129f3a0 0000000000000000 =
00007fffa2fde8f8=20
[12689.799640] GPR28: 000000000000000a 0000000000000000 00000000100201bc =
000000000011af5c=20
[12689.799703] NIP [0000000010001e8c] 0x10001e8c
[12689.799707] LR [0000000010001e74] 0x10001e74
[12689.799711] ---- interrupt: 700
[12689.799714] Code: 7c8903a6 7ca103a6 f8010020 e8410040 e8610048 =
e8810050 e8a10058 40c6001c 7ccff120 e8c10060 e8010030 e8210038 =
<4c000024> 48000000 7ccff120 f92d0080=20
[12689.799736] ---[ end trace 0000000000000000 ]---

Regards,
Venkat.
> Regards,
>=20
> Venkat.
>=20
>>=20
>> Below are the details of the crash as reported by CI.
>>=20
>> Crash Details:
>>=20
>> [ 9798.880148] Unexpected TM Bad Thing exception at c00000000000dbac
>>               (msr 0x8000000302a03031) tm_scratch=3D800000010280b033
>> [ 9798.880160] Oops: Unrecoverable exception, sig: 6 [#1]
>> [ 9798.880165] LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D8192 NUMA =
pSeries
>> [ 9798.880173] Modules linked in: nvram(E) rpadlpar_io(E) rpaphp(E) =
...
>> [ 9798.880233] CPU: 8 UID: 0 PID: 1039530 Comm: sigfuz
>>               Tainted: G            E       7.1.0-rc1 #1 PREEMPT
>> [ 9798.880245] Hardware name: IBM,8375-42A POWER9 (architected)
>>               hv:phyp pSeries
>> [ 9798.880251] NIP:  c00000000000dbac LR: 0000000010001e58
>> [ 9798.880262] MSR:  8000000302a03031 =
<SF,VEC,VSX,FP,ME,IR,DR,LE,TM[SE]>
>>=20
>>=20
>> Call Trace:
>>=20
>>=20
>> NIP [c00000000000dbac] interrupt_return_srr_kernel+0x15c/0x18c
>> Call Trace:
>> tm_reclaim_thread
>> flush_tmregs_to_thread
>> vsr_get
>> regset_get_alloc
>> fill_thread_core_info.isra.0
>> fill_note_info
>> elf_core_dump
>> coredump_write
>> do_coredump
>> vfs_coredump
>> get_signal
>> do_signal
>> do_notify_resume
>> interrupt_exit_user_prepare_main
>> interrupt_exit_user_prepare
>> interrupt_return_srr_user
>>=20
>>=20
>> Please let me know if further details are required.
>>=20
>>=20
>> If you happen to fix this issue, please add below tag.
>>=20
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>>=20
>>=20
>>=20
>> Regards,
>>=20
>> Venkat.
>>=20
>>=20


