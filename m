Return-Path: <wg@grandegger.com>
Message-ID: <49746D98.9080300@grandegger.com>
Date: Mon, 19 Jan 2009 13:10:00 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Floating point exceptions with MPC5200
References: <497448F4.7080806@grandegger.com> <20090119100347.GA27655@iram.es>
In-Reply-To: <20090119100347.GA27655@iram.es>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert wrote:
> On Mon, Jan 19, 2009 at 10:33:40AM +0100, Wolfgang Grandegger wrote:
>> Hello,
>>
>> I want to provoke a "floating point exception" by doing a division by 0.
>> The expection does come as expected on my x86 PC:
>>
>>   $ ./divby0
>>   Floating point exception
>>
>> but not on my MPC5200 board. Any idea why? I think the processor can
>> handle all floating-point exceptions. I'm using Linux 2.6.28 and the
>> ELDK v4.2.
> 
> No, the PPC continue happily after performing an _integer_ division by zero.
> It is in the architecture specification AFAIR and allowed by C and other 
> language definitions. 
> 
> This is not exactly a floating point exception per se: it has a different
> vector on x86, that the Linux kernel remaps to a floating point exception,
> although numeric exception would be more correct. PPC implements all 
> standard IEEE754 floating point exceptions (you have to enable them 
> with fesetenv() or something equivalent, but it's the same on all 
> architectures).
> 
> Even the C++ headers acknowledge this, see for example: 
> /usr/include/c++/4.3/powerpc-linux-gnu/bits/cpu_defines.h
> (or a similar file on your system, note that older versions
> of GCC got it wrong, but I can't remember when it was fixed).

I get the "Floating point exception" signal when I explicitly enable
them with fesetenv() as you suggested:

  $ cat divby0.c
  #include <stdio.h>
  #define __USE_GNU
  #include <fenv.h>

  int main(int argc, char* argv[])
  {
      double fa = 10., fb = 0., fc;
      int ia = 10, ib = 0, ic;

      printf("excepts=%#x\n", fegetexcept());
      fesetenv(FE_NOMASK_ENV);
      printf("excepts=%#x\n", fegetexcept());

      ic = ia / ib;
      printf("ic=%d\n", ic);

      fc = fa / fb;
      printf("c=%f\n", fc);

      return 0;
  }

  $ ./divby0
  excepts=0
  excepts=0x3e000000
  ic=0
  Floating point exception

See "man fesetenv" for further information. On the x86 PC, I even get a
SIGFPE signal for the integer division by 0.

Thanks for the quick help.

Wolfgang.
