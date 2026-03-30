Return-Path: <linuxppc-dev+bounces-19007-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC72FB3CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 10:21:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fknNg6ZNFz2xpt;
	Mon, 30 Mar 2026 21:21:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774866115;
	cv=none; b=YflZU39yUT3Bv3FlE59QtNdtm5noG/tAdug0YMkVkPdQ3XuRti8SGd75LdeB8Zbuuo83cjQ3u5dkn/69wXjKuW9HzpTrNQAcp5ZNQy7P9ImqaSU4U5LnvdhdDpqviqQ3QbEjay13zI46ph7OHlS4ewbOSE3+DeWvbTDs8v+T2YucF8K2vyBi+gGu4pJT6Bon3uoNj4jvjm2vN9H+xu/2DXEn2KEGgQp4jZvcwkfPO/oDUJp7Z837OlPFoT/qC+CnE0jgU8XICCt3DqhbGvw2F9iootmBajji3paJjXf5zXEZ0Oob8LahrwKmzw9z2SATOe4BICaUkYP3HrqlbhPqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774866115; c=relaxed/relaxed;
	bh=Lt+LZHVwRYyvZ2Luv4EtRd1/8NE0P2FLDc/muJErsr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGa8xe8bkWPD0ab795rTVLwFt6du36YV1So0fqbI+FutvrOcrWa3C4jwpiNGstaNsr4PANgWVHiXz1Nbdt8A0KlnwVY8saKAKqAnQPpxZHssG+69Nxt+nqwRs4a1mbKvFmqXePmDNv1aJv+GAwlTk6QbJ4cJ+L5GJr9hYznXAAi0Iq2bd1YC6cjagwwEwjrBNjkTIF+W/SfAm/AVhhUtoJFvA9nZWWNIZMzpNwyHUISWV4TCDcmbo6SY3cvzoMlPpcV1IKw+ttDUHnG4n1gfc8D1HvNl2Wx7rVC87sLHKEtjRBWjsRj1OEA8ALacpfF4dSBvtoYRAh4yPQA8pKh5rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xwogs1Ur; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xwogs1Ur;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fknNf4f4xz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 21:21:53 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAErJB3128138;
	Mon, 30 Mar 2026 10:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lt+LZH
	VwRYyvZ2Luv4EtRd1/8NE0P2FLDc/muJErsr8=; b=Xwogs1Urr56Nc1Cgxw4LAS
	9s7VPPLZH9mmMlQLlqTjlSuZmctUvNEZ4Z0T2taLmQEhMiILoeKBc9OnvjUhlczk
	xc0mfuWCGWSx9iMpCucq0PoE7qlmw63f/SESck8i//sxC0dUfrlmY97NLctJAWdE
	wIp1qUp0wUrqQ6zQS2oGKSt6FYJvgFAaihyhmh9O3w0QNGKLh7VHGROHK+mFAxVW
	feUMV+O+mJZnW3nbM4w1W7YKKWtvCJI7EOZxiVxXJME1J5I+t2293Dhaoi04VjDE
	CPnscw0oJwWHfvI0B4orO0fQjg0Uz/pTyG4PwsyDLJCnNuRLPhsLlReMOFVs3nQg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc62qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 10:21:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62U606Yv013922;
	Mon, 30 Mar 2026 10:21:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkcb11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 10:21:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UALb0M31457556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 10:21:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B62320043;
	Mon, 30 Mar 2026 10:21:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD72420040;
	Mon, 30 Mar 2026 10:21:34 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.123.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 10:21:34 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Sayali Patil <sayalip@linux.ibm.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Donet Tom <donettom@linux.ibm.com>
Subject: Re: [PATCH v2 00/10] Misc powerpc selftests kernel fixes and cleanups
Date: Mon, 30 Mar 2026 15:51:33 +0530
Message-ID: <177486592392.635640.10563030944274503248.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773078178.git.ritesh.list@gmail.com>
References: <cover.1773078178.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ca4eb6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=cAO182S-RiwLWElRIdYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VdMOagMTSY5UriE-SmhETB2Q1HRV-ri4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4MSBTYWx0ZWRfX9Ou8hvh9LVKl
 RzK3EymAnjN+ycAHqkGVqmDouUYwojOHpvb45vCB9il8bFp1EdXxjMCV1D1tvG2OuZYBTntp0Op
 E0xwLNGo9YY0mASV0lH5y653A8hbgTpyMlssXhTCqXOI9suRYirGMqaYNUZwTgcXrVP8e4NYSsY
 1vp02eN5p3FIdXxv+BqJmDVviyhWybDfY30Z94A2u3buLd4Bz7K0IM7/5L2lcPYg5IUFNnKO7nW
 lewjIb/KeTyAEtq1lw217+mOAh2waCNNEWRJgJg16FgM6/1NxDFhYqxq+q2xNyLEBzq03nNV9ra
 mIjbbSXf9g47aNU5BmAwhXJGd5e1y6GUWKv2xTFuC0sKSTZkyihEodFoZrHFGBNY9r27Lku9AOU
 UFRr4lfDTh+TVXj5ZLqEtZjqXqhjATMiQpHZNTHmaXielJmtqBOYHlI0+ZXqhEC17EB+tZtjNn3
 eJb+sNtDSevj2rEaiBg==
X-Proofpoint-ORIG-GUID: rh01sBIhBimQ6jImy53K3_1jmvlUZ3q5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300081

On Mon, 09 Mar 2026 23:44:23 +0530, Ritesh Harjani (IBM) wrote:
> v1->v2:
> 
> - dropped debug_vm_pgtable patch which adds a testcase to simulate the
>   failure scenario. Since it belongs to linux-mm, I will send that out
>   separately.
> - Modified Patch-2 in this series to also cover PMD device migration
>   entry (in addition to PMD THP migration entry). Hence dropped the
>   previous RB tag.
> - Added a new Patch-3 to fix another selftests WARNING.
> - Fixed commit subject of Patch-10.
> - Changed subject pre-fix of few patches to be consistent with others
>   (powerpc/64s)
> - Added RB tags
> 
> [...]

Applied to powerpc/next.

[01/10] powerpc/pgtable-frag: Fix bad page state in pte_frag_destroy
        https://git.kernel.org/powerpc/c/fda4d71651f71c44b35829d13f3c8bf920032f77
[02/10] powerpc/64s: Fix unmap race with PMD migration entries
        https://git.kernel.org/powerpc/c/bbcbf045d6c778e82b47a35fc8728387708e9a3d
[03/10] powerpc/64s: Fix _HPAGE_CHG_MASK to include _PAGE_SPECIAL bit
        https://git.kernel.org/powerpc/c/68b1fa0ed5c84769e4e60d58f6a5af37e7273b51
[04/10] powerpc/64s/tlbflush-radix: Remove unused radix__flush_tlb_pwc()
        https://git.kernel.org/powerpc/c/4a342f3e6f6848c816a661d8d7b10c75430598cf
[05/10] powerpc/64s: Move serialize_against_pte_lookup() to hash_pgtable.c
        https://git.kernel.org/powerpc/c/bf7c1497d2568ff803a0b0fc6728a1c06d11bf6e
[06/10] powerpc/64s: Kill the unused argument of exit_lazy_flush_tlb
        https://git.kernel.org/powerpc/c/4894e2fb7b9a25cef843ee2c3b2ac49fd808647d
[07/10] powerpc/64s: Rename tlbie_va_lpid to tlbie_va_pid_lpid
        https://git.kernel.org/powerpc/c/7bcfba20e946ec160fd72c3a0b4cf6e3e845d629
[08/10] powerpc/64s: Rename tlbie_lpid_va to tlbie_va_lpid
        https://git.kernel.org/powerpc/c/f074059c7a4d4b93914eee404391dcdb0fd60aa6
[09/10] powerpc/64s: Make use of H_RPTI_TYPE_ALL macro
        https://git.kernel.org/powerpc/c/24eb6378408fc125eacc4ad498d120ecf7becc35
[10/10] powerpc: Print MMU_FTRS_POSSIBLE & MMU_FTRS_ALWAYS at startup
        https://git.kernel.org/powerpc/c/07791ff060dd3aa270cc03861f2599d81a77b97f

cheers

