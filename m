Return-Path: <VONBOEHN@de.ibm.com>
In-Reply-To: <247666.12345.qm@web33104.mail.mud.yahoo.com>
References: <OF2260963C.4B69232D-ONC125746E.0032489D-C125746E.003FD09E@de.ibm.com>
	<247666.12345.qm@web33104.mail.mud.yahoo.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: sanjay3000@yahoo.com
Message-ID: <OFD65B3B6C.9A2E5A1E-ONC1257471.002B578F-C1257471.002ECE46@de.ibm.com>
From: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Date: Mon, 23 Jun 2008 10:30:56 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sanya,

> I have no idea how important unaligned or uncacheable
> copy perf is for Cell Linux. My experience is from Mac
> OS X for PPC, where we used dcbz in a general-purpose
> memcpy but were forced to pull that optimization because
> of the detrimental perf effect on important applications.

Interesting points.
Can you help me to understand where the negative effect of DCBZ does come
from?


> I may be missing something, but I don't see how Cell's microcoded shift
is much of a factor here.
> The problem is that the dcbz will generate the alignment exception
> regardless of whether the data is actually unaligned or not.
> Once you're on that code path, performance can't be good, can it?

In which case will DCBZ create an aligned exception?

If you want to see result on Cell then here are the values you can expect
on 1 CPU:
On Cell the copy using the Shift-xform achives max 800 MB/sec.
The copy using a single byte loop achieves 800 MB/sec as well.

A unaligned copy using unrolled doublewords and cache prefetch achieves
about 2500 MB/sec.
The aligned case using unrolled doublewords and cache prefetch achieves
about 7000 MB/sec.


What hurts performance a lot on CELL (and on XBOX 360) are two things:
a) The first level cache latency, and the memory and 2nd level cache
latency.
Cell has a first level cache latency of 4.
Cell has a second level cache latency of 40.
Cell has a memory latency of 400.

To avoid the 1st level cache latency you need to have 4 instruction
distance between your load and usage/store of the data.
Therefore a straight copy needs to be written like this.

.Loop:
  ld      r9, 0x08(r4)
  ld      r7, 0x10(r4)
  ld      r8, 0x18(r4)
  ldu     r0, 0x20(r4)
  std     r9, 0x08(r6)  // 4 instructions distance from load
  std     r7, 0x10(r6)
  std     r8, 0x18(r6)
  stdu    r0, 0x20(r6)
bdnz    .Lloop2



b) A major pain in the back is the that the shift instruction is
microcoded.
While the SHIFT X-Form needs one clock on other PPC architectures, it needs
11 clocks on CELL.
An addition to taking 11 clocks for this running it thread, the microcoded
instruction will freeze the second thread.
Using microcoded instructions in a work loop will really drain the
performance on CELL.


I think if you want to use the same copy for uncacheable memory and maybe
for another PPC platform
then a good compromise will be to use the cache prefetch version for the
aligned case and to use a old SHIFT part for the unaligned case.
This way you will get max performance for aligned copies and good result
for the unaligned case.



                                                                           
             Sanjay Patel                                                  
             <sanjay3000@yahoo                                             
             .com>                                                      To 
                                       Gunnar von                          
             20/06/2008 19:46          Boehn/Germany/Contr/IBM@IBMDE       
                                                                        cc 
                                       Arnd Bergmann <arnd@arndb.de>,      
             Please respond to         cbe-oss-dev@ozlabs.org, Michael     
             sanjay3000@yahoo.         Ellerman <ellerman@au1.ibm.com>,    
                    com                linuxppc-dev@ozlabs.org, Mark       
                                       Nelson <markn@au1.ibm.com>          
                                                                   Subject 
                                       Re: [RFC 1/3] powerpc:              
                                       __copy_tofrom_user tweaked for Cell 
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





--- On Fri, 6/20/08, Gunnar von Boehn <VONBOEHN@de.ibm.com> wrote:
> How important is best performance for the unaligned copy
> to/from uncacheable memory?
> The challenge of the CELL chip is that X-form of the shift
> instructions are microcoded.
> The shifts are needed to implement a copy that reads and
> writes always aligned.

Hi Gunnar,

I have no idea how important unaligned or uncacheable copy perf is for Cell
Linux. My experience is from Mac OS X for PPC, where we used dcbz in a
general-purpose memcpy but were forced to pull that optimization because of
the detrimental perf effect on important applications.

I may be missing something, but I don't see how Cell's microcoded shift is
much of a factor here. The problem is that the dcbz will generate the
alignment exception regardless of whether the data is actually unaligned or
not. Once you're on that code path, performance can't be good, can it?

--Sanjay
