Date: Fri, 7 Apr 2000 14:09:29 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: zzh <david-1z@263.net>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: about memory bandwidth
In-Reply-To: <38EDBA6F.06842@mta2>
Message-ID: <Pine.HPX.4.10.10004071406370.23926-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 7 Apr 2000, zzh wrote:

>
>
> Hi,How to measure the 60x bus bandwidth.I write a program to write
> to sdram in a tight loop,every iteration ,i write 8 words,
> it takes about 36 seconds to finish 32M iterations with i-cache
> enabled and d-cache disenabled.With d-cache enabled and flushing
>  cache in every iteration,it takes about 16 seconds.This is below
> what i speculated.What is the possible reason?I program the sdram
> machine to enable burst mode.                            4/7/2000

This is very dependant on the processor and on the exact instructions you
use. If you flush the cache (dcbf), then before the next write can proceed
the processor has to reload a whole cache line.

Which means that you have at least 2 bus cycles per iteration: the one
from the flush and another one to read again. Plus the fact that you might
need a sync which may also go the bus.

What do you want to measure exatcly ?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
