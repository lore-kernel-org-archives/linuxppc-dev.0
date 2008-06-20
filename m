Return-Path: <VONBOEHN@de.ibm.com>
In-Reply-To: <18523.1109.809247.646816@cargo.ozlabs.ibm.com>
References: <200806191753.59599.markn@au1.ibm.com>	<200806191643.59037.arnd@arndb.de>	<OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
	<18523.1109.809247.646816@cargo.ozlabs.ibm.com>
Subject: Re: [Cbe-oss-dev] [RFC 1/3] powerpc: __copy_tofrom_user tweaked
	for	Cell
To: Paul Mackerras <paulus@samba.org>
Message-ID: <OF6887AC47.6DDF03ED-ONC125746E.005A9A67-C125746E.005C3AC1@de.ibm.com>
From: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Date: Fri, 20 Jun 2008 18:47:07 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <ellerman@au1.ibm.com>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Of course, I can only speak for the test result that I got on our
platforms.
We did test on PS3, QS21 single/dual, QS22 single/dual, and JS21

The performance of the old Linux routine and the new routine is about the
same for copies of less than 128 Bytes.
At 512 byte the new routine is about 100% faster than the old one. (on QS
21)
At 1500 Byte size, which is a typical ethernet frame size, the new routine
is over 3 times faster than the old one.  (on QS21)

We could NOT see a performance decrease for small copies.
We saw that for copies of 512 byte and more the performance increase is
significant.


>However, it's very rare to transfer large amounts of data over
>loopback, unless you're running a benchmark like iperf or netperf.

Please mind that this test was done as its a simple way to show how much
less work the CPU needs to do to handle network traffic.
All network traffic goes to copy2user - all network traffic can now be done
with much less CPU power wasted for copying the data.

Don't you agree that network traffic or IO in general with packages over
500 Byte, is not a rare case?


Cheers
Gunnar




                                                                           
             Paul Mackerras                                                
             <paulus@samba.org                                             
             >                                                          To 
                                       Gunnar von                          
             20/06/2008 03:13          Boehn/Germany/Contr/IBM@IBMDE       
                                                                        cc 
                                       Arnd Bergmann <arnd@arndb.de>,      
                                       linuxppc-dev@ozlabs.org, Michael    
                                       Ellerman <ellerman@au1.ibm.com>,    
                                       cbe-oss-dev@ozlabs.org              
                                                                   Subject 
                                       Re: [Cbe-oss-dev] [RFC 1/3]         
                                       powerpc: __copy_tofrom_user tweaked 
                                       for  Cell                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




Gunnar von Boehn writes:

> The "regular" code was much slower for the normal case and has a special
> version for the 4K optimized case.

That's a slightly inaccurate view...

The reason for having the two cases is that when I profiled the
distribution of sizes and alignments of memory copies in the kernel,
the result was that almost all copies (something like 99%, IIRC) were
either 128 bytes or less, or else a whole page at a page-aligned
address.

Thus we get the best performance by having a simple copy routine with
minimal setup overhead for the small copy case, plus an aggressively
optimized page copy routine.  Spending time setting up for a
multi-cacheline copy that's not a whole page is just going to hurt the
small copy case without providing any real benefit.

Transferring data over loopback is possibly an exception to that.
However, it's very rare to transfer large amounts of data over
loopback, unless you're running a benchmark like iperf or netperf. :-/

Paul.
