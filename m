Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 5254967C0D
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 16:56:35 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Recently removed io accessors
References: <873b9twnbb.fsf@sleipner.barco.com>
	<1160697861.4792.177.camel@localhost.localdomain>
Date: Fri, 13 Oct 2006 08:56:34 +0200
In-Reply-To: <1160697861.4792.177.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Fri, 13 Oct 2006 10:04:21 +1000")
Message-ID: <87iriovh3x.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "BH" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

Hi,

>> Any chance of getting them back or should I implement a (slower)
>> loop myself before submitting the patch?

BH> Well, a "packet buffer" should have no endian. When streaming in
BH> our out a fifo, you basically stream bytes that happen to come out
BH> 2 at a time.  So unless somebody wired the hardware backward, you
BH> should do no swapping when using the fifo.

I agree in principle, but the issue gets complicated by the fact that
the chip works in chunks of 32bit, but the 911{5..7} chips only have a
16bit interface to lower costs, and that the chip has a builtin endian
swap feature (which works for all direct registers, but apparently not
for the packet buffers).

The memory controller automatically translates a 32bit access to two
16 bit accesses.

You could be right that the hw people screwed something up, but that
doesn't help much once there's units in the field :/

-- 
Bye, Peter Korsgaard
