Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id F0EE9DDF07
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 08:25:43 +1000 (EST)
Date: Tue, 3 Jul 2007 17:36:12 -0500
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
Message-ID: <20070703223612.GA27682@lixom.net>
References: <468ABF4A.60001@freescale.com>
	<513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
	<468ACA6F.5010107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <468ACA6F.5010107@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 03, 2007 at 05:15:11PM -0500, Scott Wood wrote:

> How about a CONFIG_NOT_BROKEN_DEVICE_TREE that disables this and other 
> legacy stuff?  If unset, warnings will be printed whenever broken things 
> are detected.  Boards which need proper device tree parsing can select 
> the config option.
> 
> I'd prefer the other way around (CONFIG_BROKEN_DEVICE_TREE), but it'd 
> need to default y at first, and kconfig has no unselect command that I 
> can see...

What's the value add in doing this? The code to handle both cases still
has to be in there (just under ifdef now). Is there actually any harm
in doing case-insensitive matching today, where things break because
there are conflicting properties with different cases?

Device trees will never be perfect, and it's idiotic of the kernel to
expect them to be. Even with the dts files, there are several of them
that have errors in them. There will be more in the future as well.

-Olof
