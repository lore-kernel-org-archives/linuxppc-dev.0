Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id E4F9B2BF0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Dec 2004 23:45:25 +1100 (EST)
Message-ID: <1103029484.41bee4ecb5397@webmail.televes.com:443>
Date: Tue, 14 Dec 2004 14:04:44 +0100
From: alebas@televes.com
To: Tom Rini <trini@kernel.crashing.org>
References: <1102586055.41b820c776f7f@webmail.televes.com:443>
	<20041213223841.GW18825@smtp.west.cox.net>
In-Reply-To: <20041213223841.GW18825@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Tom Rini <trini@kernel.crashing.org> wrote:

> It's not a "dummy" VGA console, it's a "dummy" console.  IIRC, this is
> selected with CONFIG_VT (or is it CONFIG_VT_CONSOLE?).  IIRC, the real
> problem is that when you have dummy console, it steals the console even
> if you would have had console on some sort of serial port.
>
> The bottom line is that if you don't have some sort of video device,
> just disable CONFIG_VT.
>

Thanks. Finally your clue guided me to the problem. All those configs
(CONFIG_VT, CONFIG_VT_CONSOLE, CONFIG_DUMMY_CONSOLE, etc) defaults to Y
when CONFIG_EMBEDDED is not set. I was working with this option unset
(accidentally), so this was the problem.

Alex

P.S. CONFIG_DUMMY_CONSOLE is selected only if CONFIG_VGA_CONSOLE is
not set. That's why I had called it "dummy vga console". sorry about
the confusion.
