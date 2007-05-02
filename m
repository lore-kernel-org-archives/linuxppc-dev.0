Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10459DDF88
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 02:04:15 +1000 (EST)
Message-ID: <4638B673.4090504@freescale.com>
Date: Wed, 02 May 2007 11:04:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] gianfar: Add I/O barriers when touching buffer descriptor
	ownership.
References: <20070501165542.GA31285@ld0162-tx32.am.freescale.net>
	<65f0b79871a670eb595cca7d78e2f4e9@kernel.crashing.org>
In-Reply-To: <65f0b79871a670eb595cca7d78e2f4e9@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> The hardware must not see that is given ownership of a buffer until it is
>> completely written, and when the driver receives ownership of a buffer,
>> it must ensure that any other reads to the buffer reflect its final
>> state.  Thus, I/O barriers are added where required.
>>
>> Without this patch, I have observed GCC reordering the setting of
>> bdp->length and bdp->status in gfar_new_skb.
> 
> 
> The :::"memory" in the barriers you used prevent GCC
> from reordering accesses around the barriers.

Sure... it was just an example to point out that it's actually 
happening, rather than a theoretical concern.

> AFAICS you need stronger barriers though; {w,r,}mb(),
> to prevent _any_ reordering of those memory accesses,
> not just the compiler-generated ones.

My impression was that the eieio used by iobarrier would be sufficient 
for that, as we're not trying to synchronize between accesses to 
different types of memory.  Is sync really required here?

-Scott
