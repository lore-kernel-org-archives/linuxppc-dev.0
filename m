Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 3FB832BE83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 09:38:48 +1100 (EST)
Date: Mon, 13 Dec 2004 15:38:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: alebas@televes.com
Message-ID: <20041213223841.GW18825@smtp.west.cox.net>
References: <1102586055.41b820c776f7f@webmail.televes.com:443>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1102586055.41b820c776f7f@webmail.televes.com:443>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CONFIG_DUMMY_CONSOLE question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Dec 09, 2004 at 10:54:15AM +0100, alebas@televes.com wrote:

> Hi all,
> 
> Checking console initialization on mpc8272ads board,
> I have seen that the CONFIG_DUMMY_CONSOLE config
> parameter is allways set in root .config file, regardless
> of its value on my arch/ppc/configs/ads8272_defconfig file.
> 
> This parameter drives to the VGA dummy console being
> compiled and included in the vmlinux binary, and started
> as default console for the board (which must be changed
> with console boot arg).
> 
> Does anyone knows if this parameter is a must in any kernel
> 2.6 configuration? And why? Can it be removed, as my board
> doesn't use VGA at all? How? (I have tried several options)

It's not a "dummy" VGA console, it's a "dummy" console.  IIRC, this is
selected with CONFIG_VT (or is it CONFIG_VT_CONSOLE?).  IIRC, the real
problem is that when you have dummy console, it steals the console even
if you would have had console on some sort of serial port.

The bottom line is that if you don't have some sort of video device,
just disable CONFIG_VT.

-- 
Tom Rini
http://gate.crashing.org/~trini/
