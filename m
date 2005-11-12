Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 49A7868741
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Nov 2005 09:20:47 +1100 (EST)
Date: Sat, 12 Nov 2005 23:20:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Michael Buesch <mbuesch@freenet.de>
Message-ID: <20051112222045.GC21448@stusta.de>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<20051112215304.GB21448@stusta.de>
	<200511122257.05552.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200511122257.05552.mbuesch@freenet.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 12, 2005 at 10:57:05PM +0100, Michael Buesch wrote:
> On Saturday 12 November 2005 22:53, you wrote:
> > >   CHK     include/linux/version.h
> > >   CHK     include/linux/compile.h
> > >   CHK     usr/initramfs_list
> > >   GEN     .version
> > >   CHK     include/linux/compile.h
> > >   UPD     include/linux/compile.h
> > >   CC      init/version.o
> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > arch/powerpc/kernel/built-in.o: In function `platform_init':
> > > : undefined reference to `prep_init'
> > > arch/powerpc/kernel/built-in.o:(__ksymtab+0x4d8): undefined reference to `ucSystemType'
> > > arch/powerpc/kernel/built-in.o:(__ksymtab+0x4e0): undefined reference to `_prep_type'
> > > make: *** [.tmp_vmlinux1] Error 1

ucSystemType is a variable that is EXPORT_SYMBOL'ed but never used in 
any way.

_prep_type is a variable that is needlessly EXPORT_SYMBOL'ed.


But prep_init points to the real problem:

CONFIG_PPC_PREP requires code from arch/ppc/platforms/, but this 
directory is never visited.

What is the correct fix?
Migrate the code from arch/ppc/platforms/ to arch/powerpc/platforms/ ?

> > Please send your .config .
> 
> 
> I did this in my first mail:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=113182883102937&q=p5

OK, thanks, I missed this email.

> Greetings Michael.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
