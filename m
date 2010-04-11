Return-Path: <bgat@billgatliff.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 59BC5B7D0C
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Apr 2010 11:30:19 +1000 (EST)
Received: by gwb11 with SMTP id 11so1934354gwb.15
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Apr 2010 18:30:17 -0700 (PDT)
Message-ID: <4BC12673.2090602@billgatliff.com>
Date: Sat, 10 Apr 2010 20:31:31 -0500
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: A better way to sequence driver initialization?
References: <4BBF7E9C.80604@billgatliff.com>
	<1270889597.6865.107.camel@pasglop>
	<4BC07EAD.9020307@billgatliff.com>
	<20100410233909.GA16099@linux-sh.org>
In-Reply-To: <20100410233909.GA16099@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-embedded <linux-embedded@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mundt wrote:
>
> In cases where you can specifically note that dependencies, doing so will
> save you a world of pain. Despite that, it's simply not possible to do
> this as a free-for-all. Devices or busses that can tolerate multi-threaded
> probing need to be converted over one at a time, but even then you still
> need the dependency tracking for those that depend on link order today.
>   

Right now I'm thinking mostly about GPIO devices which need to register
before things like gpio-leds can use them.  Sometimes the GPIO expansion
chip of interest is on i2c, other times it's spi, and still others it's
a platform or USB device.  Linking the gpio-led driver late helps that
specific situation.

But what about when I want to use a pin on a GPIO expansion device as
the card-detect for an MMC slot?  Or, as I've just recently noticed in
one hardware platform I'm working on, using a pin on a SPI GPIO expander
as a chip-select for another SPI device, but through gpiolib? 
Eventually, the dependencies don't become circular but changing the link
order will break some and fix others.  Ugh.

Definitely, a free-for-all isn't going to work.  But I don't think that
having every driver do its own kthread_run() is a solution, either. 
I'll keep tinkering.  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
