Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D4606A683
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cMsox2mj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZsgh42Bsz2xl0;
	Thu, 26 Nov 2026 21:08:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795687696;
	cv=none; b=XTjswejQuqNk7+XNfUn5gYAnvw07qxqctn2uYcGap181g9bnrSGXy1nu2Ar0/JnGOhXWNDZLiLvlYgP3rf8H6j2GBRNDRcxXijCwoJaRj3OlP9z88BeSkx43T/6tq6M22CQMp16JqGnvfIiExxSVJkwGCUlpFEJBHmBvQfs5MY0oRGrmcVOchHRchiT+rOcxS1OQ0oLA8nZjZ9/jhsciSPUB4Fx6mk/hzh3830XNGUjtXLn6iAZSEKoKTErmxVkgYzA9MVhYzOBzT5L3iwA2vNmYFghM+rfMfXgPEeJXoGDFcvVKNtMchExdADdLCfvHdY3TPfw96NRHbjEtFyNUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795687696; c=relaxed/relaxed;
	bh=5DE9KiBsP6FrPCJVMztu4TBXp7n5xjCqZezBXPrJnqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsDgg5dxhCP/SV/ak5LtPSfRwok43AjlXk6f50oXw0KFjsnoHM++x4/Q4CKIJujiEQ4uotAC3mNo3P0ufSOoXIIp3M4zCBWVncMzn0Zdox9rEaPFnmqaep2SR0bEkrqD7Y7MqBlXqaTywntkBb3ooFBe2k9iyiM07hYOoC3mOHdHFTdDwXrHGQQUh/gZd0eizbuTs14l8y9lTPlpTcfv0Hx7yaKc5+0N2IB1YTSyaPIpUxMR+6NYS+cv1d989Tv5AJG4jNTBpeqS3Nmq5mJfKAY3DIHFfiv+4w1kiL65RgtecMLHLhfqnzimHPQzaNh+pd9Zfh2bQ3LtUmGM7jPYrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cMsox2mj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cMsox2mj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZsgf5yw5z2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 21:08:14 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Ybjj3658885;
	Thu, 26 Nov 2026 10:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5DE9Ki
	BsP6FrPCJVMztu4TBXp7n5xjCqZezBXPrJnqI=; b=cMsox2mjCvGemk0tIMfm5X
	lkjr0H+Hu7n3glufMAuqdjyq9Pc8MQ93BY1aFhMGDQBS/xxiI094otSPAmBTuBjh
	/SZI5rLHZh5HA5IIFdVl6P5k6bypZuMVd9amnfuo9Nl3K5n1N/q7gRsj5I7N9pIA
	u7oOs7odGy1QRLMNLD32Tk93o3in+UsQQzhRBPK6487IhqpZ4+Ix47gg38rpj16V
	rdccQiWJaKrTU1y2SLhZ8IOUv99kl/BEMFNDCw+vf7qqxY6X7uODomnAIkGNkcIu
	QB95O/bBMGEeuXrL5KT2UBJDAHEy6yOTthXZoEIeyrjaG4tbaJsYhEWeOGQN5ADQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvg8pn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 10:07:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JOI72009665;
	Thu, 26 Nov 2026 10:07:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuy0w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 10:07:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQA7RUX47186304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 10:07:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D57DD2005A;
	Thu, 26 Nov 2026 10:07:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 638982004F;
	Thu, 26 Nov 2026 10:07:27 +0000 (GMT)
Received: from localhost (unknown [9.123.13.41])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 10:07:27 +0000 (GMT)
Date: Thu, 26 Nov 2026 15:37:26 +0530
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: linuxppc-dev@lists.ozlabs.org,
        Jeevitha Palanisamy <jeevitha@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>, SJ Park <sj@kernel.org>,
        Usama Arif <usama.arif@linux.dev>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 0/3] powerpc: Implement cmpxchg128()
Message-ID: <awgEDGUirL3eE80f@li-398ad3cc-28e7-11b2-a85c-e030a5b10d54.ibm.com>
References: <20261125174035.1412724-1-nysal@linux.ibm.com>
 <CAKwvOdkW5+xUCg-8Qp=1wJkNFXAJZTmTDuxBi6hKDuiNxUYiDQ@mail.gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkW5+xUCg-8Qp=1wJkNFXAJZTmTDuxBi6hKDuiNxUYiDQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b0804e5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=wIIxnnOJFXxf7qCosYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzOSBTYWx0ZWRfX36IBp5iScab5
 n0O8b/kDo01xwZQLKoqx+Bsiwdl27FPX64QJNZWsTPqKlWgWPmyz7qyAzAVvJm0OwxcWmiFTB2m
 PxEzOIqntBGkTswYAnI4LOjb1X8Ny40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzOSBTYWx0ZWRfX7y99Dj/a3+KU
 oLrmuR+0WWG5MoAn8aAR1I27FPrpljFFVgT3W/prmqU3INDCc+N3Rnne4LHlkpTp5zg+Daqjfm0
 lq4Gdq9hcCXIcQM+Hnp12di3uS/Smv1EenS0kEEt6+BOnF8BmukDgi3KHHZrzs8wV1gMr5ocGEP
 xlC4pgHPskSPCBRS2tEdCRJxJQ+AUqbBSMxmGTnQFA0PNjGgTvarncT5Bc69Q+b5JoTYIdLAaxr
 2ptxGQQeyh9tDAUfjpoTj4Z3Uh7qEH+xMXTZOx9ICjc+udG90qt8gPTOkowJkbLSbwpfFwslk+D
 0zvCnBVQyr/14YDnBVg3ln6vRcRoDeGTF93qHWVEEcrtyutClLUvrXtfKjoUoNgRPLm26ZRBt0t
 4vGCE4CSVXEpq+3l2B27imy5GZRElNkf0Jxt9GveuZNy5rEZFNThH5bO6AYPrOo649T1JWRvQtb
 HlYEF2+pKeZIMHnOB8w==
X-Proofpoint-ORIG-GUID: o_xagCYTFb4pOvtotJn25G8mkOyWOhm2
X-Proofpoint-GUID: 4KfsvU7kZDaIldcS3M8Uq9wNV4sK5BuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260039
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 09:51:30AM -0800, Nick Desaulniers wrote:
> On Wed, Nov 25, 2026 at 9:41 AM Nysal Jan K.A. <nysal@linux.ibm.com> wrote:
> >
> > This series adds arch_cmpxchg128() and arch_cmpxchg128_local() for
> > little-endian POWER8 and later, using lqarx/stqcx. This enables
> > HAVE_CMPXCHG_DOUBLE and HAVE_ALIGNED_STRUCT_PAGE, which gives us:
> >
> > * SLUB's lockless __update_freelist_fast() path (avoiding slab_lock()).
> > * kmalloc_nolock(), without which BPF task-local storage creation fails
> >   with -ENOMEM, and the selftests task_local_data_race and
> >   struct_ops_assoc (timer subtests) fail. BPF Arena kfuncs were changed
> >   to be callable from any context. kmalloc_nolock() replaced kvcalloc()
> >   in the arena allocation paths because kvcalloc() may sleep and take
> >   ordinary allocator locks, while kmalloc_nolock() can run in NMI or
> >   non-sleepable contexts.
> >
> > The lqarx and stqcx. instructions require the 128-bit operand to reside in
> > a consecutive even/odd register pair. In the Power ISA, the operand uses
> > big-endian register layout where the most significant and least
> > significant 64 bits are in the even and odd registers respectively.
> > Until now this could not be expressed in inline asm without hard
> > register constraints [1].
> >
> > GCC now supports this through the PTI mode attribute [2,3] for PowerPC
> > and it will be available in the upcoming GCC 17 release. Backports have
> > landed in the GCC 14, 15 and 16 branches. GCC 16.2 is the first release
> > which has PTI mode support. For older GCC releases and clang there is a
> > fallback implementation with hard register constraints.
> 
> Is there a feature request in llvm's bug tracker? If so, can you link
> to it? If not, can you please file one, then link to it?
> https://github.com/llvm/llvm-project/issues

I've opened one now and will add the link in v2 - https://github.com/llvm/llvm-project/issues/246292

Thanks
--Nysal

