Return-Path: <SRS0=rJbe=SC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DC1C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 00:32:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20C12146F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 00:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20C12146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WxHs0r4gzDqS0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 11:32:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WxG54sCtzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 11:30:36 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2V0UPpp012433;
 Sat, 30 Mar 2019 19:30:26 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2V0UNYa012432;
 Sat, 30 Mar 2019 19:30:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 30 Mar 2019 19:30:21 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: George Spelvin <lkml@sdf.org>
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc,
 and alpha?
Message-ID: <20190331003020.GO3969@gate.crashing.org>
References: <20190330084346.GA3801@osiris>
 <201903301030.x2UAUNOg026448@sdf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903301030.x2UAUNOg026448@sdf.org>
User-Agent: Mutt/1.4.2.3i
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
Cc: linux-s390@vger.kernel.org, linux-alpha@vger.kernel.org,
 heiko.carstens@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 30, 2019 at 10:30:23AM +0000, George Spelvin wrote:
> For s390, that was added on 24 March 2017 by
> https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=246457
> which is part of GCC 7.
> 
> It also only applies to TARGET_ARCH12, which I am guessing
> corresponds to HAVE_MARCH_ZEC12_FEATURES.

zEC12 is arch10, while z14 is arch12.  See
https://sourceware.org/binutils/docs-2.32/as/s390-Options.html#s390-Options
for example; it lists the correspondences, and states "The processor names
starting with arch refer to the edition number in the Principle of
Operations manual.  They can be used as alternate processor names and have
been added for compatibility with the IBM XL compiler."

Newer GCC does not use the somewhat confusing TARGET_ARCH12 name anymore;
see https://gcc.gnu.org/r264796 .


Segher
