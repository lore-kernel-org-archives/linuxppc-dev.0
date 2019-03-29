Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83BBC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 01:43:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414C32183F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 01:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414C32183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WLwD2cXYzDqXX
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 12:43:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=orcon.net.nz
 (client-ip=60.234.4.44; helo=smtp-3.orcon.net.nz;
 envelope-from=mcree@orcon.net.nz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=orcon.net.nz
Received: from smtp-3.orcon.net.nz (smtp-3.orcon.net.nz [60.234.4.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WLtL1gF7zDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 12:41:28 +1100 (AEDT)
Received: from [121.99.228.40] (port=52747 helo=tower)
 by smtp-3.orcon.net.nz with esmtpa (Exim 4.86_2)
 (envelope-from <mcree@orcon.net.nz>)
 id 1h9xfo-0004N3-24; Sat, 30 Mar 2019 09:00:20 +1300
Date: Sat, 30 Mar 2019 09:00:15 +1300
From: Michael Cree <mcree@orcon.net.nz>
To: George Spelvin <lkml@sdf.org>
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc, and
 alpha?
Message-ID: <20190329200015.ujmjrvn6ta67h74j@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
 George Spelvin <lkml@sdf.org>, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <201903291307.x2TD772v013534@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903291307.x2TD772v013534@sdf.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
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

On Fri, Mar 29, 2019 at 01:07:07PM +0000, George Spelvin wrote:
> I was working on some scaling code that can benefit from 64x64->128-bit
> multiplies.  GCC supports an __int128 type on processors with hardware
> support (including z/Arch and MIPS64), but the support was broken on
> early compilers, so it's gated behind CONFIG_ARCH_SUPPORTS_INT128.
[snip] 
> I don't have easy access to an Alpha cross-compiler to test, but
> as it has UMULH, I suspect it would work, too.

On Debian/Ubuntu it is just a matter of:
apt-get install gcc-alpha-linux-gnu

> Or this handwritten Alpha code:
> 1:
> 	bsr	$26, get_random_u64
> 	mulq	$0, $9, $1	# $9 is range
> 	cmpult	$1, $10, $1	# $10 is lim
> 	bne	$1, 1b
> 	umulh	$0, $9, $0

The compiler produces:

$L2:
	ldq $27,get_random_u64($29)		!literal!2
	jsr $26,($27),get_random_u64		!lituse_jsr!2
	ldah $29,0($26)		!gpdisp!3
	mulq $0,$9,$1
	lda $29,0($29)		!gpdisp!3
	umulh $0,$9,$0
	cmpule $10,$1,$1
	beq $1,$L2

It does move the umulh inside the loop but that seems sensible since
the use of unlikely() implies that the loop is unlikely to be taken
so on average it would be a good bet to start the calculation of
umulh earlier since it has a few cycles latency to get the result,
and it is pipelined so it can be calculated in the shadow of the
mulq instruction on the same execution unit.  On the older CPUs
(before EV6 which are not out-of-order execution) having the umulh
inside the loop may be a net gain.

Cheers,
Michael.
