Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id 201D8DDDED
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:16:08 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.27-git7 compile error (ppc)
Date: Sat, 25 Oct 2008 00:54:05 +0200
References: <1224265634.15582.3.camel@badari-desktop>
	<1224267073.15582.8.camel@badari-desktop>
	<FEFFA236-AA3B-49F1-AED2-E42950B87BD7@kernel.crashing.org>
In-Reply-To: <FEFFA236-AA3B-49F1-AED2-E42950B87BD7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810250054.05849.rjw@sisk.pl>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Badari Pulavarty <pbadari@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday, 17 of October 2008, Kumar Gala wrote:
> 
> On Oct 17, 2008, at 1:11 PM, Badari Pulavarty wrote:
> 
> > On Fri, 2008-10-17 at 10:47 -0700, Badari Pulavarty wrote:
> >> Hi,
> >>
> >> I get this following compile error on my ppc box.
> >>
> >> Let me know if its a known issue. Otherwise, I can figure out
> >> whats happening.
> >>
> >> Thanks,
> >> Badari
> >
> > This is due to recent changes to move phys_add_t definition from
> > arch/powerpc/include/asm/types.h to include/linux/types.h.
> >
> > arch/powerpc/include/asm/page.h needs phys_addr_t for
> > CONFIG_RELOCATABLE. Needs fixing..
> >
> > Thanks,
> > Badari
> >
> >>
> >>  CC      arch/powerpc/mm/slb.o
> >> In file included from /usr/src/linux-2.6.27/arch/powerpc/include/ 
> >> asm/mmu-hash64.h:16,
> >>                 from /usr/src/linux-2.6.27/arch/powerpc/include/asm/ 
> >> mmu.h:7,
> >>                 from /usr/src/linux-2.6.27/arch/powerpc/include/asm/ 
> >> pgtable.h:7,
> >>                 from arch/powerpc/mm/slb.c:19:
> >> /usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:76: error:  
> >> parse error before "memstart_addr"
> >> /usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:76: warning:  
> >> type defaults to `int' in declaration of `memstart_addr'
> >> /usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:76: warning:  
> >> data definition has no type or storage class
> >> /usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:77: error:  
> >> parse error before "kernstart_addr"
> >> /usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:77: warning:  
> >> type defaults to `int' in declaration of `kernstart_addr'
> >> /usr/src/linux-2.6.27/arch/powerpc/include/asm/page.h:77: warning:  
> >> data definition has no type or storage class
> >>  AS      arch/powerpc/lib/string.o
> >>  CC      arch/powerpc/lib/alloc.o
> >>  CALL    arch/powerpc/kernel/systbl_chk.sh
> >>  CC      arch/powerpc/kernel/sysfs.o
> >> make[1]: *** [arch/powerpc/mm/slb.o] Error 1
> >> make: *** [arch/powerpc/mm] Error 2
> >> make: *** Waiting for unfinished jobs....
> 
> I've got a patch that seems to address this for me building w/ 
> CONFIG_RELOCATABLE on ppc32/85xx.

Has that been fixed in 2.6.27 and/or current mainline?

Rafael
