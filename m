Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6542DB70C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 00:37:39 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id B4E7CDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 00:37:37 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1551575ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Jun 2009 07:37:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090607203406.7C8BC832E416@gemini.denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
	<20090606232148.4E0BD832E416@gemini.denx.de>
	<4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com>
	<20090607203406.7C8BC832E416@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 8 Jun 2009 08:37:16 -0600
Message-ID: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
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

On Sun, Jun 7, 2009 at 2:34 PM, Wolfgang Denk<wd@denx.de> wrote:
> Dear John,
>
> in message <4b73d43f0906061708o763409d0u10a344dfc30e32c1@mail.gmail.com> =
you wrote:
>>
>> > The big question seems to be what the RefMan means when talking about
>> > the "system clock frequency". Obiously it is NOT =A0the =A0CPU =A0cloc=
k =A0as
> ...
>> > But which one is it?
>>
>> My best guess is still that it is ips clock. =A0I think I stated in a pr=
evious
>> email ipb, but I meant ips. =A05200 has ibp and 5121 has ips. =A0Have yo=
u looked
>> at he MII clock on a scope to see how the calculated values compare to
>> actual?
>
> Yes, it seems very much as if you were right again.
>
> When using ips/ibp everything makes sense, and works.
>
> Hm... so that means on MPC512x we should use mpc512x_find_ips_freq(),
> while on MPC5200 we should use =A0mpc52xx_find_ipb_freq() =A0- =A0but =A0=
hey,
> apart from the name these two functions are identical.
>
> Grant - how would you like to see this handled? Should we merge these
> two code-wise identical functions into one? =A0What should be the name,
> and in which file should we put it?

If you want to merge them... Seeing as the function just walks up the
parent nodes looking for the "bus-frequency" property; how about
"mpc5xxx_get_bus_frequency()"?  It should go somewhere in
arch/powerpc/sysdev/

Alternately, it is a pretty trivial function; 52xx and 512x could both
have their own versions of it.  Whichever makes the most sense to you
(I haven't personally looked at the device driver impact).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
