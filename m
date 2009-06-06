Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 41701B70AD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 08:16:22 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7ABC9DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 08:16:21 +1000 (EST)
To: John Rigby <jcrigby@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
Date: Sun, 07 Jun 2009 00:16:18 +0200
Message-Id: <20090606221618.701E0832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear John,

In message <4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com> you wrote:
> 
> I think the fec's parent clock is the ipb clock not the ppc core clock.
> Could that be the problem?

I don't think so.

When debugging, I printed the actual clock frequencies, and they
looked as expected. And "arch/powerpc/platforms/512x/clock.c" has
this:

385 static struct clk fec_clk = {
386         .name = "fec_clk",
387         .flags = CLK_HAS_CTRL,
388         .reg = 0,
389         .bit = 13,
390         .calc = unity_clk_calc,
391         .parent = &ips_clk,
392 };

which looks OK to me.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The human mind  ordinarily  operates  at  only  ten  percent  of  its
capacity. The rest is overhead for the operating system.
