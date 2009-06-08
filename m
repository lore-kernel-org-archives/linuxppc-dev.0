Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 65CA0B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 00:39:35 +1000 (EST)
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id A2A3EDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 00:39:34 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1585457qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Jun 2009 07:39:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090608081904.14265832E416@gemini.denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
	<20090606232148.4E0BD832E416@gemini.denx.de>
	<4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
	<20090607203406.7C8BC832E416@gemini.denx.de>
	<4A2CC1DE.5040704@grandegger.com>
	<20090608081904.14265832E416@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 8 Jun 2009 08:39:12 -0600
Message-ID: <fa686aa40906080739w6c9a763cmc38371726e97a12@mail.gmail.com>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Chen Hongjun <Hong-jun.chen@freecale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 8, 2009 at 2:19 AM, Wolfgang Denk<wd@denx.de> wrote:
> Dear Wolfgang,
>
> In message <4A2CC1DE.5040704@grandegger.com> you wrote:
>>
>> > Hm... so that means on MPC512x we should use mpc512x_find_ips_freq(),
>> > while on MPC5200 we should use =A0mpc52xx_find_ipb_freq() =A0- =A0but =
=A0hey,
>> > apart from the name these two functions are identical.
>> >
>> > Grant - how would you like to see this handled? Should we merge these
>> > two code-wise identical functions into one? =A0What should be the name=
,
>> > and in which file should we put it?
>> >
>> > [We need this clock thing for "drivers/net/fs_enet/mii-fec.c"...]
>>
>> I2C and MSCAN need it as well. What about implementing the more generic
>> clk api for the MPC5200 as done for the MPC512x?
>
>> http://lxr.linux.no/linux+v2.6.29/arch/powerpc/platforms/512x/clock.c
>
> Hmmm... I have to admit that I'm biased he. My =A0primary =A0interest =A0=
at
> the =A0moment is obviously just to get the MPC512x stuff into mainline,
> and thus I'm not happy about extending the scope of the isse to other
> processors.
>
> From the technical point of view you are right, but I have to admit
> that I don't see which direction we should go from here. If we keep in
> mind that the same FEC core is also used in various i.MX platforms (=3D
> ARM processors), we probably cannot come up with a clean, unique
> implementation that covers all uses.
>
> That's why I asked Grant how to address this. =A0I also added Kumar to
> the Cc: list - mayby he has some ideas as well?

I say use the simple approach to get it merged;  It can always be changed l=
ater.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
