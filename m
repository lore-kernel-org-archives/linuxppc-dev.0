Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C5A1DE4F1
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:26:25 +1000 (EST)
Date: Tue, 20 May 2008 15:21:13 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
In-Reply-To: <1211320938.8297.179.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0805201511300.7453@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>  <483344C0.3020703@freescale.com>
	<1211320938.8297.179.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 May 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-05-20 at 16:38 -0500, Scott Wood wrote:
>> It looks like we rely on -fno-strict-aliasing to prevent reordering
>> ordinary memory accesses (such as to DMA descriptors) past the I/O
>> access.  It won't prevent reordering of memory reads around an I/O
>> read,
>> though, which could be a problem if the I/O read result determines
>> the
>> validity of the DMA buffer.  IMHO, a memory clobber would be better.
>
> We probably want a full "memory" clobber then...

As far as I could tell, no other arch has a full memory clobber.  I can see
the argument for changing the Linux model to be stricter and less efficient,
but easier to program for.  Not that I entirely agree with it.

But I don't see a good reason for why powerpc should be different than
everything else.
