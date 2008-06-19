Return-Path: <VONBOEHN@de.ibm.com>
In-Reply-To: <200806191643.59037.arnd@arndb.de>
References: <200806191753.59599.markn@au1.ibm.com>
	<200806191643.59037.arnd@arndb.de>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
From: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Date: Thu, 19 Jun 2008 17:17:02 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

> You don't have a page wise user copy,
> which the regular code has.

The new code does not need two version IMHO.
The "regular" code was much slower for the normal case and has a special
version for the 4K optimized case.
The new code is equally good in both cases, so adding an extra 4K routine
is will increase the code size for very minor gain. I'm not sure if its
worth it.

Benchmark result on QS22 for good aligned copy
Old-code : 1300 MB/sec
Old-code 4k Special case: 2600 MB/sec
New code : 4000 MB/sec (always)


> You don't align the source to word size, only the target.
> Does this get handled correctly when the source
> is a noncacheable mapping, e.g.

The problem is that on CELL the required shift instructions
for SRC alignment are microcoded, in other words really slow.
You are right the main copy2user requires that the SRC is cacheable.
IMHO because of the exception on load, the routine should fallback to the
byte copy loop.

Arnd, could you verify that it works on localstore?


Cheers
Gunnar





                                                                           
             Arnd Bergmann                                                 
             <arnd@arndb.de>                                               
                                                                        To 
             19/06/2008 16:43          linuxppc-dev@ozlabs.org             
                                                                        cc 
                                       Mark Nelson <markn@au1.ibm.com>,    
                                       cbe-oss-dev@ozlabs.org, Gunnar von  
                                       Boehn/Germany/Contr/IBM@IBMDE,      
                                       Michael Ellerman                    
                                       <ellerman@au1.ibm.com>              
                                                                   Subject 
                                       Re: [RFC 1/3] powerpc:              
                                       __copy_tofrom_user tweaked for Cell 
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Thursday 19 June 2008, Mark Nelson wrote:

>  * __copy_tofrom_user routine optimized for CELL-BE-PPC

A few things I noticed:

* You don't have a page wise user copy, which the regular code
has. This is probably not so noticable in iperf, but should
have a significant impact on lmbench and on a number of file
system tests that copy large amounts of data. Have you checked
that the loop around cache lines is just as fast?

* You don't align the source to word size, only the target.
Does this get handled correctly when the source is a noncacheable
mapping, e.g. an unaligned copy_from_user where the source points
to a physical local store mapping of an SPU? I don't think we
need to optimize this case for performance, but I'm not sure
if it would crash. AFAIR, unaligned loads from noncacheable storage
give you an alignment exception that you need to handle, right?

* The naming of the labels (with just numbers) is rather confusing,
it would be good to have something better, but I must admit that
I don't have a good idea either.

* The trick of using the condition code in cr7 for the last bytes
is really cute, but are the four branches actually better than a
single computed branch into the middle of 15 byte wise copies?

             Arnd <><
