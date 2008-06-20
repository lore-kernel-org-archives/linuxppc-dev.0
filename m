Return-Path: <VONBOEHN@de.ibm.com>
In-Reply-To: <973448.15152.qm@web33101.mail.mud.yahoo.com>
References: <OF3C6636F6.52E3D242-ONC125746D.005214B0-C125746D.0053FABE@de.ibm.com>
	<973448.15152.qm@web33101.mail.mud.yahoo.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
To: sanjay3000@yahoo.com
Message-ID: <OF2260963C.4B69232D-ONC125746E.0032489D-C125746E.003FD09E@de.ibm.com>
From: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Date: Fri, 20 Jun 2008 13:36:45 +0200
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

Hi Sanjay,

> I suppose it would still function correctly via the handler, but horribly
slowly.

How important is best performance for the unaligned copy to/from
uncacheable memory?
The challenge of the CELL chip is that X-form of the shift instructions are
microcoded.
The shifts are needed to implement a copy that reads and writes always
aligned.
There is of course the option to not use the X-form of the shift but to
write several copy routines
using immediate shift instructions and to pick the matching copy routine.
This option would of course highly increase the code size of the memcopy
routine.


Kind regards

Gunnar



                                                                           
             Sanjay Patel                                                  
             <sanjay3000@yahoo                                             
             .com>                                                      To 
                                       Arnd Bergmann <arnd@arndb.de>,      
             19/06/2008 18:13          Gunnar von                          
                                       Boehn/Germany/Contr/IBM@IBMDE       
                                                                        cc 
             Please respond to         Mark Nelson <markn@au1.ibm.com>,    
             sanjay3000@yahoo.         linuxppc-dev@ozlabs.org, Michael    
                    com                Ellerman <ellerman@au1.ibm.com>,    
                                       cbe-oss-dev@ozlabs.org              
                                                                   Subject 
                                       Re: [RFC 1/3] powerpc:              
                                       __copy_tofrom_user tweaked for Cell 
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           







--- On Thu, 6/19/08, Gunnar von Boehn <VONBOEHN@de.ibm.com> wrote:

> You are right the main copy2user requires that the SRC is
> cacheable.
> IMHO because of the exception on load, the routine should
> fallback to the
> byte copy loop.
>
> Arnd, could you verify that it works on localstore?

Since the main loops use 'dcbz', the destination must also be cacheable.
IIRC, if the destination is write-through or cache-inhibited, the 'dcbz'
will cause an alignment exception. I suppose it would still function
correctly via the handler, but horribly slowly.

--Sanjay
