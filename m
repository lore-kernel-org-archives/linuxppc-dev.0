Return-Path: <wg@grandegger.com>
Received: from web10.manitu.net (web10.manitu.net [217.11.48.110])
	by ozlabs.org (Postfix) with ESMTP id CB1B9679EA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 19:55:16 +1100 (EST)
Date: Tue, 14 Mar 2006 09:34:20 +0100
Message-Id: <200603140834.k2E8YKj08997@web10.manitu.net>
From: "Wolfgang Grandegger" <wg@grandegger.com>
To: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: Stable Linux kernel 2.6 for MPC8XX
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



> On Friday 10 March 2006 16:33, Wolfgang Denk wrote:
> > > I believe most of those observations and measurements are not valid
> > > anymore. Kernel 2.6 for 8xx has come a long way since this article was
> > > written. It might have been true back then, but it surely isn't
anymore.
> >
> > So did you actually run any benchmarks? Specilations on what might be
> > or should be are not really helpful.
> 
> Of course I did. Otherwise I wouldn't say this.
> 
> Here's some benchmark data from nbench (sorry didn't try lmbench yet):
> 
> The same ELDK (version 3.1.1) for both kernels, running on exactly the
same 
> board (MPC852T 100MHz, with 32Mbyte SDRAM and 32Mbyte Flash running
from NFS 
> root). I removed some FPU benchmarks, as they are pretty meaningless
for this 
> board and take an ethernity otherwise.
> 
> Results for Kernel 2.4.25 (Denx CVS from around sept-oct or so, 2005):
> 
> TEST                : Iterations/sec.  : Old Index   : New Index
>                     :                  : Pentium 90* : AMD K6/233*
> --------------------:------------------:-------------:------------
> NUMERIC SORT        :          30.438  :       0.78  :       0.26
> STRING SORT         :          1.5842  :       0.71  :       0.11
> BITFIELD            :      7.9506e+06  :       1.36  :       0.28
> FP EMULATION        :           3.258  :       1.56  :       0.36
> IDEA                :          108.89  :       1.67  :       0.49
> HUFFMAN             :          26.281  :       0.73  :       0.23
> LU DECOMPOSITION    :         0.32765  :       0.02  :       0.01
> ==========================ORIGINAL BYTEMARK
RESULTS==========================
> INTEGER INDEX       : 1.052
> FLOATING-POINT INDEX: 0.257
> 
> 
> Now the results for 2.6.14 (Denx git released 2.6.14):
> 
> TEST                : Iterations/sec.  : Old Index   : New Index
>                     :                  : Pentium 90* : AMD K6/233*
> --------------------:------------------:-------------:------------
> NUMERIC SORT        :          32.654  :       0.84  :       0.28
> STRING SORT         :          1.7408  :       0.78  :       0.12
> BITFIELD            :      8.3466e+06  :       1.43  :       0.30
> FP EMULATION        :           3.506  :       1.68  :       0.39
> IDEA                :           115.3  :       1.76  :       0.52
> HUFFMAN             :          27.855  :       0.77  :       0.25
> LU DECOMPOSITION    :         0.35932  :       0.02  :       0.01
> ==========================ORIGINAL BYTEMARK
RESULTS==========================
> INTEGER INDEX       : 1.115
> FLOATING-POINT INDEX: 0.265
> 
> 
> I don't know why, but while everyone still says 2.6 is slower, I am 
> consistently getting results that seem to prove the opposite. Why?
> Is the TLB/cache stuff better optimized for 8xx in 2.6?
> IMHO it is quite a difference.

Could you please provide more information on the kernel configuration
e.g. the .config files and the size of the kernel images? 

Thanks.

Wolfgang.


> Btw, I also wrote different small "speed-measurement" tools (to measure 
> loop-speed, memory throughput for different block sizes, etc...) and
they all 
> show aproximately the same increase.
> I was careful to strip both kernels of all unnecessary drivers and
features 
> that could hamper performance. If you wish I could try to dig up the
.config 
> files for you, but I am not sure I'll find them anymore (I did this when 
> 2.6.14 was just released).
> 
> Greetings,
> 
> -- 
> David Jander
> Protonic Holland.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
