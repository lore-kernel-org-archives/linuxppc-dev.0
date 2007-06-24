Return-Path: <clifford@clifford.at>
Received: from phoenix.clifford.at (phoenix.clifford.at [88.198.7.52])
	by ozlabs.org (Postfix) with ESMTP id 2A522DDF01
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jun 2007 06:00:27 +1000 (EST)
Date: Sun, 24 Jun 2007 21:39:32 +0200
From: Clifford Wolf <clifford@clifford.at>
To: linuxppc-embedded@ozlabs.org
Subject: Mem-2-Mem DMA - Generalized API
Message-ID: <20070624193932.GA11797@clifford.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I've sent this mail to lkml some days ago:

http://lkml.org/lkml/2007/6/23/27

and got that answer from Clemens Koller pointing to this mailing list:

http://lkml.org/lkml/2007/6/23/128

short summary:

I'm working on an MPC8349E based project and as some of you might know this
chip has a four channel (bus-) memory-to-memory DMA controller.

Unfortunately the linux kernel is atm lacking a generic interface for such
DMA controllers.

Instead of directly programming the DMA controller in my periphery driver
I'd prefer implementing a generic api/scheduler and would like to discuss
the implementation details. Such an api would make device drivers more
portable and would allow easy sharing of the DMA controller among many
device drivers.

<end of short summary>

imo there should be register/unregister functions for the driver(s)
handling the DMA controller(s) as well as a generic function for submiting
dma transfers.

Since at least the MPC8349E DMA controller has support for scatter/gather
dma modes and can run source/destionation optionally in 8, 16 or 32 fifo
mode this function would have a more complicated interface than memcpy().

The function for submitting dma transfers could be passed a function
pointer (as well a void data pointer for passing metadata) which is
called in interrupt context as soon as the tranfser has been completed.

Clemens pointed out that it could also be of use to additionaly get some
kind of progress notifications so the partial data can already be processed
before the entire dma transfer has been completed.

In addition to the bare-bone 'callback in interrupt context' api I would
also like to have small wrapper which just sleeps until the transfer has
been finished.

I would be very interested in your feedback, thoughts and whishes regarding
such an api to avoid rewrite-cycles later on.

yours,
 - clifford

-- 
"The generation of random numbers is too important to be left to chance."
 - Robert R. Coveyou, Oak Ridge National Laboratory.
