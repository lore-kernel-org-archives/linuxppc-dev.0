Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2C514B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 06:34:13 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5B222DDD0B
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2009 06:34:11 +1000 (EST)
To: John Rigby <jcrigby@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
	<20090606232148.4E0BD832E416@gemini.denx.de>
	<4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
Date: Sun, 07 Jun 2009 22:34:06 +0200
Message-Id: <20090607203406.7C8BC832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <Hong-jun.chen@freecale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear John,

in message <4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com> you wrote:
>
> > The big question seems to be what the RefMan means when talking about
> > the "system clock frequency". Obiously it is NOT  the  CPU  clock  as
...
> > But which one is it?
> 
> My best guess is still that it is ips clock.  I think I stated in a previous
> email ipb, but I meant ips.  5200 has ibp and 5121 has ips.  Have you looked
> at he MII clock on a scope to see how the calculated values compare to
> actual?

Yes, it seems very much as if you were right again.

When using ips/ibp everything makes sense, and works.

Hm... so that means on MPC512x we should use mpc512x_find_ips_freq(),
while on MPC5200 we should use  mpc52xx_find_ipb_freq()  -  but  hey,
apart from the name these two functions are identical.

Grant - how would you like to see this handled? Should we merge these
two code-wise identical functions into one?  What should be the name,
and in which file should we put it?

[We need this clock thing for "drivers/net/fs_enet/mii-fec.c"...]

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Don't think; let the machine do it for you!"        - E. C. Berkeley
