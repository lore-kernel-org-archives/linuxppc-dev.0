Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 13:10:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DE02075E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="klCrQccB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DE02075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W2Ct66lrzDqVx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 00:10:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sdf.org
 (client-ip=205.166.94.20; helo=mx.sdf.org; envelope-from=lkml@sdf.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sdf.org header.i=@sdf.org header.b="klCrQccB"; 
 dkim-atps=neutral
Received: from mx.sdf.org (mx.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W28B0LwkzDqML
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 00:07:20 +1100 (AEDT)
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2TD77wr023453
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO); 
 Fri, 29 Mar 2019 13:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
 t=1553864836; bh=8YRwR3yMd0d+KmTP83jP1DXcBrFHiIf3wDMXMVarqIg=;
 h=Date:From:To:Subject:Cc;
 b=klCrQccBZVcPalDQLRFRayly6cD1dUqGarewpeB34eaWc77ouPgOCvRcbx5dExYxc
 hY3iqJYoorpRzRXEoR3u4RacU8Y4kiUFqpQVtS6zoDpdHWzftW66TQKLyiACKNT7FA
 l6ykZiSaA8QOJtU/AiGYb5g+EFp6WoLlO5ID1cEc=
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id x2TD772v013534;
 Fri, 29 Mar 2019 13:07:07 GMT
Date: Fri, 29 Mar 2019 13:07:07 GMT
From: George Spelvin <lkml@sdf.org>
Message-Id: <201903291307.x2TD772v013534@sdf.org>
To: linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and alpha?
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
Cc: lkml@sdf.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(Cross-posted in case there are generic issues; please trim if
discussion wanders into single-architecture details.)

I was working on some scaling code that can benefit from 64x64->128-bit
multiplies.  GCC supports an __int128 type on processors with hardware
support (including z/Arch and MIPS64), but the support was broken on
early compilers, so it's gated behind CONFIG_ARCH_SUPPORTS_INT128.

Currently, of the ten 64-bit architectures Linux supports, that's
only enabled on x86, ARM, and RISC-V.

SPARC and HP-PA don't have support.

But that leaves Alpha, Mips, PowerPC, and S/390x.

Current mips64, powerpc64, and s390x gcc seems to generate sensible code
for mul_u64_u64_shr() in <linux/math64.h> if I cross-compile them.

I don't have easy access to an Alpha cross-compiler to test, but
as it has UMULH, I suspect it would work, too.

Is there a reason it hasn't been enabled on these platforms?

There might be a MIPS64r6 issue, since r6 changed from DMULTU
writing the lo and hi registers to DMULU/DMUHU, and gcc 8.3, at
least, doesn't know how to generate inline code for the latter.

(Note that users *also* check __INT128__, which is defined if GCC
claims to support __int128, so you don't have to worry about 32-bit
compiles or ancient compilers.  It only has to be conditional on
*broken* support.)


FWIW, the code I'm working on has this inner loop:
(https://arxiv.org/abs/1805.10941 for details)

u64 get_random_u64(void);
u64 get_random_max64(u64 range, u64 lim)
{
	unsigned __int128 prod;
	do {
		prod = (unsigned __int128)get_random_u64() * range;
	} while (unlikely((u64)prod < lim));
	return prod >> 64;
}

Which turns into these inner loops:
MIPS:
.L7:
	jal	get_random_u64
	nop
	dmultu $2,$17
	mflo	$3
	sltu	$4,$3,$16
	bne	$4,$0,.L7
	mfhi	$2

PowerPC:
.L9:
	bl get_random_u64
	nop
	mulld 9,3,31
	mulhdu 3,3,31
	cmpld 7,30,9
	bgt 7,.L9

s/390:
.L13:
	brasl	%r14,get_random_u64@PLT
	lgr	%r5,%r2
	mlgr	%r4,%r10
	lgr	%r2,%r4
	clgr	%r11,%r5
	jh	.L13

I like that the MIPS code leaves the high half of the product in
the hi register until it tests the low half; I wish PowerPC would
similarly move the mulhdu *after* the loop, like the following
hypothetical MIPS R6 code:

.L7:
	balc	get_random_u64
	dmulu	$3, $2, $17
	sltu	$3, $3, $16
	bnezc	$3, .L7
	dmuhu	$2, $2, $17

Or this handwritten Alpha code:
1:
	bsr	$26, get_random_u64
	mulq	$0, $9, $1	# $9 is range
	cmpult	$1, $10, $1	# $10 is lim
	bne	$1, 1b
	umulh	$0, $9, $0
