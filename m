Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9742DB70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 09:21:55 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id C7774DDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 09:21:53 +1000 (EST)
To: John Rigby <jcrigby@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 05/04] *** NOT FOR RELEASE *** HACK *** Work around MII
	clock issue ***
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-6-git-send-email-wd@denx.de>
	<4b73d43f0905071909v6e6e8b2el9eb6d4a1b9038f45@mail.gmail.com>
	<20090606221618.701E0832E416@gemini.denx.de>
	<4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com>
Date: Sun, 07 Jun 2009 01:21:48 +0200
Message-Id: <20090606232148.4E0BD832E416@gemini.denx.de>
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

in message <4b73d43f0906061527p7ca1b301ybcfc576870a168d5@mail.gmail.com> you wrote:
>
> I noticed the latest BSP from Freescale has this patch:
> 
> From: Chen Hongjun <Hong-jun.chen@freecale.com>
> Date: Thu, 16 Apr 2009 20:22:52 +0800
> Subject: [PATCH] Fixed FEC bug for bluestone board.
> 
> Signed-off-by: Chen Hongjun <Hong-jun.chen@freecale.com>
> ---
>  drivers/net/fs_enet/mii-fec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
> index 13a7d66..53d01a8 100644
> --- a/drivers/net/fs_enet/mii-fec.c
> +++ b/drivers/net/fs_enet/mii-fec.c
> @@ -208,7 +208,7 @@ static int __devinit fs_enet_mdio_probe(struct of_device
> *ofdev,
>         if (!fec->fecp)
>                 goto out_fec;
> 
> -       fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
> +       fec->mii_speed = ((((ppc_proc_freq + 4999999) / 2500000) / 2) & 0x3F) << 1;

Heh. So we now have 3 versions:

mainline:

	fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;

Freescale:

	fec->mii_speed = ((((ppc_proc_freq + 4999999) / 2500000) / 2) & 0x3F) << 1;

we:
	fec->mii_speed = (((ppc_proc_freq / 1000000) / 30) + 1) << 1;


So what does this give:

ppc_proc_freq			mii_speed
	    mainline		freescale	    we
--------------------------------------------------
 50 MHz	    0x14 -> 2.5 MHz	0x14 -> 2.5 MHz	    0x04 -> 12.50 MHz
100 MHz	    0x28 -> 2.5 MHz	0x28 -> 2.5 MHz	    0x08 -> 12.50 MHz
150 MHz	    0x3C -> 2.5 MHz	0x3C -> 2.5 MHz	    0x0C -> 12.50 MHz
200 MHz	    0x50 -> 2.5 MHz	0x50 -> 2.5 MHz	    0x0E -> 14.29 MHz
250 MHz	    0x64 -> 2.5 MHz	0x64 -> 2.5 MHz	    0x12 -> 13.89 MHz
300 MHz	    0x78 -> 2.5 MHz	0x78 -> 2.5 MHz	    0x16 -> 13.36 MHz
316.8 MHz   0x80 -> 2.475 MHz	0x00 -> MDC off	    0x16 -> 14.40 MHz
350 MHz	    0x8C -> 2.5 MHz	0x0C -> 29.17 MHz   0x18 -> 14.58 MHz
400 MHz	    0xA0 -> 2.5 MHz	0x20 -> 12.50 MHz   0x1C -> 14.29 MHz
450 MHz	    0xB3 -> 2.5 MHz	0x34 -> 8.654 MHz   0x20 -> 14.06 MHz
500 MHz	    0xC8 -> 2.5 MHz	0x48 -> 6.944 MHz   0x22 -> 14.71 MHz

So - the mainline version and what we have don't take into account
that MII_SPEED uses only bit 25...30, i.e. it must fit into the range
from (1 << 1) ... (3F << 1).

The Freescale code tries to address this, but just clipping the data
is incorrect as we can see above.

The funny thing is that the RefMan says:

        "...MDC frequency of 1/(mii_speed*2) of the system clock
        frequency"

	"To be compliant with the IEEE MII specification, the MII_SPEED
	field must be programmed with a value that provides an MDC
	frequency of less than or equal to 2.5 MHz."

The big question seems to be what the RefMan means when talking about
the "system clock frequency". Obiously it is NOT  the  CPU  clock  as
code variants above assume. The examples in "Table 17-24. Programming
Examples  for  MII_SPEED Register" list "system clock frequencies" of
25, 33, 40 and 50  MHz  -  which  also  indiocates  that  some  other
frequency might be referenced here.

But which one is it?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Today's robots are very primitive, capable of understanding  only  a
few  simple  instructions  such  as 'go left', 'go right', and 'build
car'."                                                  - John Sladek
