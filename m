Return-Path: <tcminyard@gmail.com>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com
 [IPv6:2607:f8b0:4003:c06::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4A10B1A025B
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 01:15:16 +1100 (AEDT)
Received: by mail-oi0-f46.google.com with SMTP id g201so792190oib.19
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Nov 2014 06:15:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Message-ID: <545B826F.7050501@acm.org>
Date: Thu, 06 Nov 2014 08:15:11 -0600
From: Corey Minyard <minyard@acm.org>
Reply-To: minyard@acm.org
MIME-Version: 1.0
To: Jeremy Kerr <jk@ozlabs.org>,
 openipmi-developer@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/2] Add IPMI support for powernv powerpc machines
References: <1415245107.292153.444216242273.0.gpush@pablo>
In-Reply-To: <1415245107.292153.444216242273.0.gpush@pablo>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2014 09:38 PM, Jeremy Kerr wrote:
> This series adds IPMI driver and arch glue for OPAL-firmware-based
> powernv machines. The first change exposes the firmware's IPMI API, and
> the second adds an actual driver.
>
> IPMI folks: the IPMI driver could do with a little review, as it's not a
> conventional BT/KCS/SMI SI, in that the low-level send/recv interface
> will handle the entire message at once.

Handling the entire message at once should be fine, as that's what this
driver level is designed to do for the message handler.  That part all
looks correct.  The code itself looks good, but I have a couple of
high-level comments.

The driver at this level can receive more than one message to handle at
a time, so it needs some sort of queue.  This is to allow multiple users
and to allow the message handler to send its own commands while other
commands are going on.  You might argue that the queuing should be done
in ipmi_msghandler, and you would probably be right.  I'll look at doing
that.  If that is the case, then your NULL check for current message
should probably be a BUG_ON().

Do you need to handle any BMC flags?  Particularly incoming events?


> Corey & Michael: if this is acceptable, it may be mergable as two
> separate patches - one for the IPMI subsystem, one for the powernv
> platform.  However, we'd need to preserve their order: patch 2/2 depends
> on 1/2, which provides the structure & function definitions. This'll
> break the build if only 2/2 is in the tree, and CONFIG_IPMI_POWERNV is
> set.
>
> Alternatively, they could be merged by one maintainer, pending an ack
> from the other.

I'm fine either way.

Thanks,

-corey

> Comments / queries / etc welcome.
>
> Cheers,
>
>
> Jeremy
>
> ---
> Jeremy Kerr (2):
>       powerpc/powernv: Add OPAL IPMI interface
>       drivers/char/ipmi: Add powernv IPMI driver
>
