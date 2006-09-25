Return-Path: <msm@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D20EE67BC1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 03:21:03 +1000 (EST)
Subject: Re: How to move from /ppc/ to /powerpc/
From: Matthew McClintock <msm@freescale.com>
To: Fredrik Roubert <roubert@df.lth.se>
In-Reply-To: <20060925171754.GB21204@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
	<20060921160808.GB4828@igloo.df.lth.se>
	<1159202991.5485.0.camel@localhost>
	<20060925171754.GB21204@igloo.df.lth.se>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 12:20:51 -0500
Message-Id: <1159204851.5485.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-25 at 19:17 +0200, Fredrik Roubert wrote:
> On Mon 25 Sep 18:49 CEST 2006, Matthew McClintock wrote:
> 
> > It looks like you already have your chosen node in your DTS file. With
> > my u-boot patches the appropriate chosen node is added to the flat tree
> > based off the u-boot environment.
> 
> Ah, that's true, in ft_setup(), I didn't see that. Thanks! (I'd been
> thinking about how the command line should be passed from U-Boot, but
> decided to postpone that investigation until I solved the serial console
> problem.)
> 
> However, the code in ft_setup() doesn't assign "linux,stdout-path", so
> if I remove the chosen node from my DTS, then I get no print-out on the
> serial console at all. (But the rest of the system appears to run fine
> and I can log in using SSH.) Can this be a clue to someone as to what
> could be the problem with my serial console?
> 

>From u-boot/common/ft_build.c:

#ifdef OF_STDOUT_PATH
        ft_prop_str(&cxt, "linux,stdout-path", OF_STDOUT_PATH);
#endif

There is a define for adding that to the /chosen node. Add this to your
u-boot include file and the console should show up.

Good Luck.

-Matthew
