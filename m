Return-Path: <bwarren@qstreams.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id DF3A767B6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 08:11:03 +1100 (EST)
Subject: Re: Compact Flash - lost interrupt
From: Ben Warren <bwarren@qstreams.com>
To: Muruga Ganapathy <gmuruga@gdatech.com>
In-Reply-To: <200611300310.kAU3Awg07084@sierra.gdatech.com>
References: <200611300310.kAU3Awg07084@sierra.gdatech.com>
Content-Type: text/plain
Date: Thu, 30 Nov 2006 16:11:00 -0500
Message-Id: <1164921060.31193.127.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-29 at 19:10 -0800, Muruga Ganapathy wrote:
> The error message might be due to the wrong/improper configuration of 
> interrupt and its attributes like whether it is level/edge sensitive.
> 
> G.Muruganandam
> 

Thanks Ganapathy.  Turns out it was a hardware problem.  In True IDE
mode the CF interrupt signal is active high, which explains why
sometimes the interrupt was detected (albeit not at the right time).  We
missed that in the Toshiba document, and unfortunately it doesn't look
like the polarity of IRQ lines is configurable on this CPU.  Alas,
another white wire.

regards,
Ben
