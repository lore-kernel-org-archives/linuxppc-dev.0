Return-Path: <tpiepho@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19DC7DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 08:06:03 +1000 (EST)
Date: Tue, 20 May 2008 15:00:45 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
In-Reply-To: <1211318219.8297.177.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0805201425250.7453@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop>
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
> On Tue, 2008-05-20 at 13:40 -0700, Trent Piepho wrote:
>> There was some discussion on a Freescale list if the powerpc I/O accessors
>> should be strictly ordered w.r.t.  normal memory.  Currently they are not.  It
>> does not appear as if any other architecture's I/O accessors are strictly
>> ordered in this manner.  memory-barriers.txt explicitly states that the I/O
>> space (inb, outw, etc.) are NOT strictly ordered w.r.t. normal memory
>> accesses and it's implied the other I/O accessors (e.g., writel) are the same.
>>
>> However, it is somewhat harder to program for this model, and there are almost
>> certainly a number of drivers using coherent DMA which have subtle bugs because
>> the do not include the necessary barriers.
>>
>> But clearly and change to this would be a subject for a different patch.
>
> The current accessors should provide all the necessary ordering
> guarantees...

Depends on what you define as "necessary".  It's seem clear that I/O accessors
_no not_ need to be strictly ordered with respect to normal memory accesses,
by what's defined in memory-barriers.txt.  So if by "necessary" you mean what
the Linux standard for I/O accessors requires (and what other archs provide),
then yes, they have the necessary ordering guarantees.

But, if you want them to be strictly ordered w.r.t to normal memory, that's
not the case.

For example, in something like:

u32 *dmabuf = kmalloc(...);
...
dmabuf[0] = 1;
out_be32(&regs->dmactl, DMA_SEND_BUFFER);
dmabuf[0] = 2;
out_be32(&regs->dmactl, DMA_SEND_BUFFER);

gcc might decide to optimize this code to:

out_be32(&regs->dmactl, DMA_SEND_BUFFER);
out_be32(&regs->dmactl, DMA_SEND_BUFFER);
dmabuf[0] = 2;

gcc will often not do this optimization, because there might be aliasing
between "&regs->dmact" and "dmabuf", but it _can_ do it.  gcc can't optimize
the two identical out_be32's into one, or re-order them if they were to
different registers, but it can move the normal memory accesses around them.

Here's a quick hack I stuck in a driver to test.  compile with -save-temps and
check the resulting asm.  gcc will do the optimization I described above.

static void __iomem *baz = (void*)0x1234;
static struct bar {
     u32 bar[256];
} bar;

void foo(void) {
     bar.bar[0] = 44;
     out_be32(baz+100, 200);
     bar.bar[0] = 45;
     out_be32(baz+101, 201);
}
