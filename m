Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 128A9DDDE9
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 23:21:29 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/7] [POWERPC] Get rid of conditional includes of board
	specific setup
Date: Sat, 19 Jan 2008 13:21:18 +0100
References: <4790B891.3050106@scram.de>
In-Reply-To: <4790B891.3050106@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801191321.19320.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 January 2008, Jochen Friedrich wrote:
> Directly include mpc885ads.h from mpc885ads_setup.c. Now we can get rid
> of the arch dependent includes in mpc8xx.h.

Ah, very nice. How close are we to enabling an 8xx multiplatform
build after this?

> =A0#ifdef CONFIG_8xx
> =A0
> =A0extern void mpc8xx_restart(char *cmd);
> @@ -18,22 +20,9 @@ extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
> =A0extern void mpc8xx_pics_init(void);
> =A0extern unsigned int mpc8xx_get_irq(void);

>=20
>  #ifdef CONFIG_PCMCIA_M8XX
>  extern struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops;
>  #endif
=20
> =A0#endif /* CONFIG_8xx */
> =A0#endif /* __CONFIG_8xx_DEFS */

You can also kill the #ifdef CONFIG_8xx  and the #ifdef CONFIG_PCMCIA_M8XX,
there is no point hiding extern declarations behind an #ifdef, but it
has the disadvantage of causing unnecessary rebuilds if the configuration
symbols change.

	Arnd <><
