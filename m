Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB8C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 11:31:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A0E218AC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 11:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sdf.org header.i=@sdf.org header.b="SnUyKcvl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A0E218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Wbyw1zNGzDqWt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 22:31:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sdf.org
 (client-ip=205.166.94.20; helo=mx.sdf.org; envelope-from=lkml@sdf.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sdf.org header.i=@sdf.org header.b="SnUyKcvl"; 
 dkim-atps=neutral
Received: from mx.sdf.org (ol.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WbwQ2q3XzDqTq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 22:29:10 +1100 (AEDT)
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2UBSL8e016039
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO); 
 Sat, 30 Mar 2019 11:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdf.org; s=default;
 t=1553945307; bh=nVu/b1uPV4aWkWUAZcsDgJh1gNvQ2T92e3ooWC3xgKE=;
 h=Date:From:To:Subject:Cc:In-Reply-To:References;
 b=SnUyKcvlI1bo0ONozGyxLlztlOfdSHMnMs4lCp2FH6F9eNwJQOji8k4FtW/JrxaAJ
 1Ayyllfs0VZnL0rTwqnMvR4P+v+GPWv+Jh09+QeCw4ndyWA0X8RRYv6m+0m9ufBoEd
 Al6bq7IcGYkO8inyjOTChnGPTsJ2q6HyOotkLGZI=
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id x2UBSLNH017484;
 Sat, 30 Mar 2019 11:28:21 GMT
Date: Sat, 30 Mar 2019 11:28:21 GMT
From: George Spelvin <lkml@sdf.org>
Message-Id: <201903301128.x2UBSLNH017484@sdf.org>
To: lkml@sdf.org, segher@kernel.crashing.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc,
 and alpha?
In-Reply-To: <20190329202557.GL3969@gate.crashing.org>
References: <201903291307.x2TD772v013534@sdf.org>,
 <20190329202557.GL3969@gate.crashing.org>
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
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

General update:

I've since found the reason for the GCC version check.
It's not *broken* support (apologies for impugning GCC),
but *inefficient* support via a muditi3 helper function.

The version check is the version which added in-line code generation.
For example, s390 support was added in March of 2017 and is part
of the 7.1 release.

I hvave to do some digging through gcc version history to
find when it was added to various architectures.
(And MIPS64v6 support is still lacking in gcc 9.)


On Fri, 29 Mar 2019 at 15:25:58 -0500, Segher Boessenkool wrote:
> On Fri, Mar 29, 2019 at 01:07:07PM +0000, George Spelvin wrote:
>> I don't have easy access to an Alpha cross-compiler to test, but
>> as it has UMULH, I suspect it would work, too.
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

Thanks for the pointer; I have a working Alpha cross-compiler now.
 
>> u64 get_random_u64(void);
>> u64 get_random_max64(u64 range, u64 lim)
>> {
>> 	unsigned __int128 prod;
>> 	do {
>> 		prod = (unsigned __int128)get_random_u64() * range;
>> 	} while (unlikely((u64)prod < lim));
>> 	return prod >> 64;
>> }
> 
>> MIPS:
>> .L7:
>> 	jal	get_random_u64
>> 	nop
>> 	dmultu $2,$17
>> 	mflo	$3
>> 	sltu	$4,$3,$16
>> 	bne	$4,$0,.L7
>> 	mfhi	$2
>> 
>> PowerPC:
>> .L9:
>> 	bl get_random_u64
>> 	nop
>> 	mulld 9,3,31
>> 	mulhdu 3,3,31
>> 	cmpld 7,30,9
>> 	bgt 7,.L9
>>
>> I like that the MIPS code leaves the high half of the product in
>> the hi register until it tests the low half; I wish PowerPC would
>> similarly move the mulhdu *after* the loop,

> The MIPS code has the multiplication inside the loop as well, and even
> the mfhi I think: MIPS has delay slots.

Yes, it's in the delay slot, which is fine (the branch is unlikely,
after all).  But it does the compare (sltu) before accessing %hi, which
is good as %hi often has a longer latency than %lo.  (On out-of-order
cores, of course, none of this matters.)

> GCC treats the int128 as one register until it has expanded to RTL, and it
> does not do such loop optimisations after that, apparently.
> 
> File a PR please?  https://gcc.gnu.org/bugzilla/

Er...  about what?  The fact that the PowerPC code is not
>> PowerPC:
>> .L9:
>> 	bl get_random_u64
>> 	nop
>> 	mulld 9,3,31
>> 	cmpld 7,30,9
>> 	bgt 7,.L9
>> 	mulhdu 3,3,31

I'm not sure quite how to explain it in gcc-ese.
