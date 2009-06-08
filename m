Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 93548B70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 18:19:18 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C96C3DDD01
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jun 2009 18:19:16 +1000 (EST)
To: Wolfgang Grandegger <wg@grandegger.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4A2CC1DE.5040704@grandegger.com>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
	<20090606232148.4E0BD832E416@gemini.denx.de>
	<4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
	<20090607203406.7C8BC832E416@gemini.denx.de>
	<4A2CC1DE.5040704@grandegger.com>
Date: Mon, 08 Jun 2009 10:19:04 +0200
Message-Id: <20090608081904.14265832E416@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <Hong-jun.chen@freecale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Wolfgang,

In message <4A2CC1DE.5040704@grandegger.com> you wrote:
>
> > Hm... so that means on MPC512x we should use mpc512x_find_ips_freq(),
> > while on MPC5200 we should use  mpc52xx_find_ipb_freq()  -  but  hey,
> > apart from the name these two functions are identical.
> > 
> > Grant - how would you like to see this handled? Should we merge these
> > two code-wise identical functions into one?  What should be the name,
> > and in which file should we put it?
> > 
> > [We need this clock thing for "drivers/net/fs_enet/mii-fec.c"...]
> 
> I2C and MSCAN need it as well. What about implementing the more generic
> clk api for the MPC5200 as done for the MPC512x?

> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/platforms/512x/clock.c

Hmmm... I have to admit that I'm biased he. My  primary  interest  at
the  moment is obviously just to get the MPC512x stuff into mainline,
and thus I'm not happy about extending the scope of the isse to other
processors.

>From the technical point of view you are right, but I have to admit
that I don't see which direction we should go from here. If we keep in
mind that the same FEC core is also used in various i.MX platforms (=
ARM processors), we probably cannot come up with a clean, unique
implementation that covers all uses.

That's why I asked Grant how to address this.  I also added Kumar to
the Cc: list - mayby he has some ideas as well?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The day-to-day travails of the IBM programmer are so amusing to  most
of us who are fortunate enough never to have been one - like watching
Charlie Chaplin trying to cook a shoe.
