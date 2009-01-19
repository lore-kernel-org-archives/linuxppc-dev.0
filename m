Return-Path: <paubert@iram.es>
Date: Mon, 19 Jan 2009 11:03:47 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Floating point exceptions with MPC5200
Message-ID: <20090119100347.GA27655@iram.es>
References: <497448F4.7080806@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <497448F4.7080806@grandegger.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 19, 2009 at 10:33:40AM +0100, Wolfgang Grandegger wrote:
> Hello,
> 
> I want to provoke a "floating point exception" by doing a division by 0.
> The expection does come as expected on my x86 PC:
> 
>   $ ./divby0
>   Floating point exception
> 
> but not on my MPC5200 board. Any idea why? I think the processor can
> handle all floating-point exceptions. I'm using Linux 2.6.28 and the
> ELDK v4.2.

No, the PPC continue happily after performing an _integer_ division by zero.
It is in the architecture specification AFAIR and allowed by C and other 
language definitions. 

This is not exactly a floating point exception per se: it has a different
vector on x86, that the Linux kernel remaps to a floating point exception,
although numeric exception would be more correct. PPC implements all 
standard IEEE754 floating point exceptions (you have to enable them 
with fesetenv() or something equivalent, but it's the same on all 
architectures).

Even the C++ headers acknowledge this, see for example: 
/usr/include/c++/4.3/powerpc-linux-gnu/bits/cpu_defines.h
(or a similar file on your system, note that older versions
of GCC got it wrong, but I can't remember when it was fixed).

	Gabriel
