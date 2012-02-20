Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79735B6F98
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2012 07:30:40 +1100 (EST)
Message-ID: <4F42AD63.7050907@freescale.com>
Date: Mon, 20 Feb 2012 14:30:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
 <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
 <1329513033.3980.1.camel@pasglop> <4F3EDC35.5070904@freescale.com>
 <4F3EF72C.2090305@freescale.com> <1329531557.3980.16.camel@pasglop>
In-Reply-To: <1329531557.3980.16.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Timur Tabi <b04825@freescale.com>, Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 08:19 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2012-02-17 at 18:56 -0600, Scott Wood wrote:
>> Yes, or maybe make it "default y", and/or require an "I know what I'm
>> doing" option to be set for it to be unset if a board otherwise wants it.
>>
>> The ability to turn it off is potentially useful for any board, since
>> the address map is determined by boot software which can be changed, but
>> we shouldn't make it too easy to fail to select it for boards that
>> normally require it.
> 
> Don't we have CONFIG_EMBEDDED to make that sort of option visible ?

OK, so:

config WANT_PHYS_64BIT
select PHYS_64BIT if !EMBEDDED

config PHYS_64BIT
default y if WANT_PHYS_64BIT

...and "select WANT_PHYS_64BIT" on boards that normally have 36-bit
address maps?

What about 86xx?  It looks like PHYS_64BIT can't be enabled if it's
sharing a kernel image with 82xx or 83xx (why these specific SoCs but
not 603 in general?).

-Scott
