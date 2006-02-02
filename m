Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6173868A30
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 04:16:49 +1100 (EST)
Date: Thu, 2 Feb 2006 09:16:46 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
Subject: Re: Yosemite/440EP why are readl()/ioread32()
	setuptoreadlittle-endian?
Message-ID: <20060202171646.GD12810@gate.ebshome.net>
References: <35786B99AB3FDC45A8215724617919736D921E@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35786B99AB3FDC45A8215724617919736D921E@gbrwgceumf01.eu.xerox.net>
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

On Thu, Feb 02, 2006 at 11:26:22AM -0000, Jenkins, Clive wrote:
> Regardless of what standards or hardware might exist, I would be
> happy if Linux provided alternatives to readl()... that converted
> between big-endian and cpu-endian, so that I could write in my
> driver, for example:
> 
> static inline my_readl(...)
> {
> #if (my interconnect is PCI or other little-endian)
>     return(readl(...));
> #else
>     return(readl_be(...));
> #endif
> }
> 
> That must make my driver more portable in future circumstances

Huh?

If you re-read this thread, you'll notice that I was responding to 
e-mail where original poster did NOT want to do exactly this in his 
driver. But you are suggesting what we were discussing on how to  
_avoid_. I'm really confused, what is your point?

What I was talking, in short, that if we _really_ want generic non-PCI 
accessors, we need something similar to the way IDE layer defines its 
I/O operations - bunch of per-bus/device function pointers which can 
be overridden depending on arch, bus and the way peripheral is wired.

-- 
Eugene
