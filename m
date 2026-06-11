Return-Path: <linuxppc-dev+bounces-22515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ECBCD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 17:41:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbqhT0cnnz3bqh;
	Fri, 12 Jun 2026 03:41:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781199705;
	cv=none; b=QBCkM9rDTkTGSAjSlBnBJuHUSHoxYcCWDlcg/AtEdaTDZVvj0JEbUUNCw0ctQJXkaus4fHCVOqMFHXepo6XnDeTttFnKTfUExmlRU/x7bFixGAG4bqHlNdWinTXL79BOZwSMx1ZQwxAV+NcVs71OKrgoWXsHOxs5Htj5xonELyckS3JG3OvWVPaQaFwNfiWZgEzrU6UUNT5r73WXnm23DiUBlyUxUWG9fxh6ZLYTYZcPdaasN72lIZ6Sf98KZ42eYaeAhzQL04woblddexNpGhvwnMJ9bdLgMlJB+FCKeOPGuod9ehJGdihDfgx3yW2tWsk2Qm4ApqLlsbal2gXNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781199705; c=relaxed/relaxed;
	bh=5LY6Y/13bHPBekH6tW4tqlz2F35W+MGiIqWnvari4gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+LmZDQZ+/sd1+bA0TF0UcNHZTzL34zyRZuwtHHXVq4TtWJEYtEeiac0ZQHayAlg9wy9dUf8r6Qcji+Kw/EOh5FSU7QEtuHED/0BYyqckLSj657wevmw9zB8FDBnBUbj+MVXVUSoRog8N615yQMjwLQqO3npgRhmcZwrLMrax7A1hX0Xij9pUV9xeBC3fLYh/fXRR8D0rqyncKHIjgqL3fDC3zlgXZDjw+5g52fg/M75DlbxRx7yz8A+c3NmN74K6vEwpcVR3WNY+7WXRgwNEaD4dtm1T9nmNOApO/gDbDbaMhpe5Fe92KT4OXxHcm8a35TLhgTreEE9qe1Jhe0gNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mFbT4hMp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mFbT4hMp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbqhS03FWz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 03:41:43 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65BCmjsC1741923;
	Thu, 11 Jun 2026 17:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5LY6Y/13bHPBekH6tW4tqlz2F35W+M
	GiIqWnvari4gE=; b=mFbT4hMpB2bb+wXboX9w0cWd7ioysOqDZbSyscM6jnBVIO
	ZAyl7nlaqvy+KXK3HeZh3203IBL0L+Zj6jFTzLttcXQM8UWDQqVAf7TQ8MLE5jt0
	AIbjK5dzK72PnubkQ9NcRmNx+aTLjyNRjxIH7T1sPI8yUM5r21qI2JkCjAFxOr5o
	ddc599LBBu2nDLAfkk5/0j+NTI/1nxI2XTWqE0krN9jRCPNJb7jRdrZVK3B/yVTz
	7NJwJsZJzjWWzjw54WHvIRyDfkyc98VyJwIzOvOls1WtKo51HyinRzUGvOovSDCE
	Tm7SDyQ1bJtVfrBk8uOQFXk9Bv5Ig7l2uOqiaG3A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8bmyw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 17:41:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BHYfmk001481;
	Thu, 11 Jun 2026 17:41:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a4907-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 17:41:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BHevRg48103902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 17:40:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E732004B;
	Thu, 11 Jun 2026 17:40:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6EA120040;
	Thu, 11 Jun 2026 17:40:47 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.28.214])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 11 Jun 2026 17:40:47 +0000 (GMT)
Date: Thu, 11 Jun 2026 23:10:44 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org, nsc@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, jpoimboe@kernel.org, ojeda@kernel.org,
        masahiroy@kernel.org, lossin@kernel.org, tamird@kernel.org,
        thomas.weissschuh@linutronix.de, rostedt@goodmis.org,
        ihor.solodrai@linux.dev, thuth@redhat.com, pmladek@suse.com,
        aliceryhl@google.com, elver@google.com, kees@kernel.org,
        legion@kernel.org, ardb@kernel.org, yuxuan.zuo@outlook.com,
        alexghiti@rivosinc.com, alexandre.chartre@oracle.com, bp@alien8.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, shivangu@linux.ibm.com
Subject: Re: [PATCH v1 0/6] objtool: Fixup alternate feature relative
 addresses
Message-ID: <airxFpcQE7kQ5qLK@shivang.upadyay>
References: <20260505084628.17940-1-sv@linux.ibm.com>
 <20260505114050.GW3126523@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505114050.GW3126523@noisy.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Xfa5Co55 c=1 sm=1 tr=0 ts=6a2af32f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=voM4FWlXAAAA:8
 a=pGLkceISAAAA:8 a=VQAFIG5AJ55ret5aWFUA:9 a=CjuIK1q_8ugA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE3NyBTYWx0ZWRfX7bxoSE+N7m9N
 qrVFc9J4bJsyoR+UUV5Iv/YOYdxhp2rfYtjEMW4d1sOVEXmIe84bdEVnosGlV6qmFXAAAv1iyxq
 XSf1VspSpzwyjfbAjOTHNkTvZcM1oI7+jRrEa/mW4JFzBum+2nc5sZO8pkzYkowyj47735iRcKb
 XoRMPjTmlD/Ho9WwUn7JvzrRCYyQNeA6BNtIjkkCr/u9BooEfmWoLcGFynoSw4SV1BiIvXoy41m
 UgEB5kpKYom6Kb+FCuxGzatgdXxV2KchVO8QMwwXzoKVG7/wgfJ3Iix0v5WmAvh5TSQe4Fh44We
 k1j5wlMUaLlKuagBtU4rlSqgW+XWshHforqRr69Cp00HK5DY4dZ15gamjK9a9T6fa2BD1miJtJf
 ZdYS5VI6Xjb59HCbCGzWrYtee1ffLrfxTtIeX7eCl/91LT4wpPFE7/CDoAvAVx+l4mTTdObNezS
 V2n7Zdduqm+gjTbjT+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE3NyBTYWx0ZWRfXxJWfbXdbB7r9
 rb1UTfRgwmyF0eaIOklBYemeQ3vSCUvLNcq/CXiGxdAK9EEveEinths416A05QAT9QduOoeU+zU
 cOPFRst0+zL5cl8hVoqsgI0Nrsabt18=
X-Proofpoint-ORIG-GUID: 2i9MmL2Gbyt48Nw4JZSkte9JgJ-VXBs5
X-Proofpoint-GUID: L8HjNQPSLLI-3yDX8EVsag5cFCH-QFec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_03,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110177

On Tue, May 05, 2026 at 01:40:50PM +0200, Peter Zijlstra wrote:
> On Tue, May 05, 2026 at 02:16:22PM +0530, Sathvika Vasireddy wrote:
> > This patch series implements build-time fixup of alternate feature
> > relative addresses for powerpc.
> > 
> > Previously, Nicholas Piggin proposed a build-time solution using a
> > custom PowerPC tool [1], which provided the foundation for this approach.
> > The current implementation leverages objtool's existing ELF parsing
> > infrastructure to do the same.
> > 
> > This patchset applies atop powerpc/merge branch.
> > 
> > [1] Original PowerPC tool approach:
> >     http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170521010130.13552-1-npiggin@gmail.com/
> > 
> > Testing:
> > Build and Boot tested on ppc64le, ppc64be, and ppc32be configs.
> > 
> > Sathvika Vasireddy (6):
> >   objtool/powerpc: Add build-time fixup of alternate feature branch
> >     targets
> >   objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
> >   objtool: Fix "can't find starting instruction" warnings on vmlinux
> >   objtool/powerpc: Skip jump destination analysis and unnanotated
> >     intra-function call warnings for --ftr-fixup
> >   kbuild: Add objtool integration for PowerPC feature fixups
> >   powerpc: Enable build-time feature fixup processing by default
> 
> Ooh, so 2/3 are because you're not running objtool on vmlinux.o, but
> you're running it later in the link stage?
> 
> AFAICT ELF_F_LAYOUT should not hurt the normal objtool run, but it
> shouldn't be needed either, because we run much earlier, before sections
> are placed.
> 
> And that also explains why you're the first to have trouble with 'can't
> find starting instruction'. vmlinux.o will have unplaced sections that
> are all relative 0.
> 
> Hmm... perhaps this ftr fixup should be its own command, like klp. Not
> munged into check thing. Josh?

Hi Peter,

As the original author for the patch series will not be working on this
feature anymore, I'd like to take over and move this feature forward.

Your point about only using objtool at object stage, makes sense.
Would you prefer if I rework this as a saperate tool then?

Regards
~Shivang

