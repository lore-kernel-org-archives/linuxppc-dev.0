Return-Path: <SRS0=UVon=TW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D50BC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 20:10:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80D321019
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 May 2019 20:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80D321019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 458Nzf6S8jzDqSl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 May 2019 06:10:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=neutral (mailfrom) smtp.mailfrom=iki.fi
 (client-ip=62.142.5.107; helo=emh01.mail.saunalahti.fi;
 envelope-from=aaro.koskinen@iki.fi; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=iki.fi
Received: from emh01.mail.saunalahti.fi (emh01.mail.saunalahti.fi
 [62.142.5.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458Nvr5SPczDqRp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2019 06:07:17 +1000 (AEST)
Received: from darkstar.musicnaut.iki.fi (85-76-4-80-nat.elisa-mobile.fi
 [85.76.4.80])
 by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 8EC1020030;
 Wed, 22 May 2019 23:07:11 +0300 (EEST)
Date: Wed, 22 May 2019 23:07:11 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [BISECTED] kexec regression on PowerBook G4
Message-ID: <20190522200711.GA456@darkstar.musicnaut.iki.fi>
References: <20190521221859.GC3621@darkstar.musicnaut.iki.fi>
 <90f3557b-400b-60b5-9ff8-d5605adeee79@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90f3557b-400b-60b5-9ff8-d5605adeee79@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Wed, May 22, 2019 at 08:14:23AM +0200, Christophe Leroy wrote:
> Le 22/05/2019 à 00:18, Aaro Koskinen a écrit :
> >I was trying to upgrade from v5.0 -> v5.1 on PowerBook G4, but when trying
> >to kexec a kernel the system gets stuck (no errors seen on the console).
> 
> Do you mean you are trying to kexec a v5.1 kernel from a v5.0 kernel, or do
> you have a working v5.1 kernel, but kexec doesn't work with it ?

To summarize, my system's boot goes like this:

Open Firmware -> kernel A (small due to OF limit) -> (kexec) -> kernel B (big)

First both A & B were at v5.0 ==> boot works.
Then I upgraded B to v5.1 ==> boot works.
Then I upgraded A to v5.1 ==> boot fails.

So the issue must be in A. So after bisecting I got the following result:

	Kernel A with commit 93c4a162b014 ==> fails
	Kernel A with commit 93c4a162b014^1 ==> works

n >Bisected to: 93c4a162b014 ("powerpc/6xx: Store PGDIR physical address
> >in a SPRG"). This commit doesn't revert cleanly anymore but I tested
> >that the one before works OK.
> 
> Not sure that's the problem. There was a problem with that commit, but it
> was fixed by 4622a2d43101 ("powerpc/6xx: fix setup and use of
> SPRN_SPRG_PGDIR for hash32").
> You probably hit some commit between those two during bisect, that's likely
> the reason why you ended here.
> 
> Can you restart your bisect from 4622a2d43101 ?

This is not a good commit to start with, as it already gives "kernel
tried to execute exec protected page..." after the "Bye!" message.

> If you have CONFIG_SMP, maybe you should also consider taking 397d2300b08c
> ("powerpc/32s: fix flush_hash_pages() on SMP"). Stable 5.1.4 includes it.

This is UP computer and CONFIG_SMP is not set.

> >With current Linus HEAD (9c7db5004280), it gets a bit further but still
> >doesn't work: now I get an error on the console after kexec "Starting
> >new kernel! ... Bye!":
> >
> >	kernel tried to execute exec-protected page (...) - exploit attempt?
> 
> Interesting.
> 
> Do you have CONFIG_STRICT_KERNEL_RWX=y in your .config ? If so, can you
> retry without it ?

I don't set that option.

A.
