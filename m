Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D5DF6B70C4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 04:31:56 +1000 (EST)
Received: from mail-gx0-f216.google.com (mail-gx0-f216.google.com
	[209.85.217.216]) by ozlabs.org (Postfix) with ESMTP id 19AA6DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Jul 2009 04:31:55 +1000 (EST)
Received: by gxk12 with SMTP id 12so1876485gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 11:31:53 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20090717175138.97CB2832E416@gemini.denx.de>
References: <1247833628-15952-2-git-send-email-wd@denx.de>
	<1247835545-18650-1-git-send-email-wd@denx.de>
	<fa686aa40907170745h6c5fae6bia0cff0926c93393c@mail.gmail.com>
	<20090717175138.97CB2832E416@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 17 Jul 2009 12:31:33 -0600
Message-ID: <fa686aa40907171131u79bf4bcdi66ad516c83919c99@mail.gmail.com>
Subject: Re: [PATCH 2/2 v4] MPC52xx FEC: be more conservative when setting
	MII_SPEED register
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2009 at 11:51 AM, Wolfgang Denk<wd@denx.de> wrote:
> Dear Grant Likely,
>
> In message <fa686aa40907170745h6c5fae6bia0cff0926c93393c@mail.gmail.com> =
you wrote:
>>
>> > =A0drivers/net/fec_mpc52xx.c =A0 =A0 | =A0 25 ++++++++++++++++++++++--=
-
>> > =A0drivers/net/fec_mpc52xx_phy.c | =A0 23 ++++++++++++++++++++---
>>
>> Blech. =A0now this block of duplicated code I don't like. =A0This is all
>> one device, so surely the mdio speed can be calculated once and used
>> for both drivers.... let me think about this for a bit. =A0'course this
>> problem is all rolled up in the nastiness of having two drivers
>> working on the same device. =A0I suspect is was a mistake to split up
>> all the powerpc ethernet drivers into separate of_platform drivers.
>
> If you like, I can re-introduce the mpc5xxx_get_mii_speed() I unrolled
> upon your request (with or without re-using it for the MPC512x case).

No, there's a deeper issues here.  I'm bothered that the mac driver is
impacting the mdio driver.  I'd like to find a way for this whole
thing to be handled cleaner, and not have two different drivers
calculate it.

g.

>
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, =A0 =A0 MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> What is mind? =A0No matter. =A0What is matter? =A0Never mind.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0-- Thomas Hewitt Key, 1799-1875
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
