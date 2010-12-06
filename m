Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 14C8AB6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 18:30:46 +1100 (EST)
Date: Mon, 06 Dec 2010 08:30:37 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/2] powerpc, 5200: add defconfig for charon board
In-reply-to: <20101204211734.GD671@pengutronix.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Message-id: <4CFC911D.4070306@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <1291450914-22485-1-git-send-email-hs@denx.de>
	<20101204211734.GD671@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Wolfram,

Wolfram Sang wrote:
> On Sat, Dec 04, 2010 at 09:21:54AM +0100, Heiko Schocher wrote:
> 
> There shall be only one mpc5200-defconfig. Does the genric one work with your
> board?

Just tried, mpc5200_defconfig works for me, but...

... I miss there the LM81 and RTC DS1374 support ... and in another
patchset from me, I add SM501 support for this board ... also
for example, I don;t need CONFIG_FB_RADEON*, CONFIG_SPI* defines

Hmm.. I understand that maintaining the board_defconfigs is a nightmare.
Just a fast thought (I am not a kconfig expert):

As there is a mpc5200_defconfig, couldn;t we get rid of the board
defconfig(s), and add instead a possibility to store only the changes
against the mpc5200_defconfig in a file? That would save a lot of unneeded
lines, and maintaining would be easier as common 5200 config options
are stored in mpc5200_defconfig ... and a "make board_settings" would do:

- call "make mpc5200_defconfig"
- process differences stored in "board_settings"
  (something like menuconfig, just not interactive)

(we could generalize that approach, because I think, all defconfigs
 are not easy to maintain, if we say first line is always the defconfig
 we call, following lines are options different to that ...)

Example for the charon board "charon_settings" file:

call mpc5200_defconfig	// call "make mpc5200_defconfig"
enable SENSORS_LM80	// call something like "make menuconfig -e SENSORS_LM80"
disable FB_RADEON	// call something like "make menuconfig -d FB_RADEON"
disable SPI
disable RTC_DRV_DS1307
enable RTC_DRV_DS1374
...

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
