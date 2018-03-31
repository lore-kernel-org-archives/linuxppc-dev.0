Return-Path: <mgreer@animalcreek.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CjSt1Y5FzF1lS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 13:42:37 +1100 (AEDT)
Date: Fri, 30 Mar 2018 19:42:29 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Oliver <oohall@gmail.com>
Cc: Mark Greer <mgreer@animalcreek.com>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc/boot: Remove duplicate typedefs from libfdt_env.h
Message-ID: <20180331024229.GA18304@animalcreek.com>
References: <20180316215443.2807-1-mgreer@animalcreek.com>
 <e710d9d7-232b-6420-96a7-8167dd91b824@c-s.fr>
 <20180319160216.GD9670@animalcreek.com>
 <CAOSf1CFVH+OEkZCN+AYOxb863akkuw44uOENVEi=zf=QVc-UmQ@mail.gmail.com>
 <20180330022250.GA20304@animalcreek.com>
 <20180330022652.GB20304@animalcreek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180330022652.GB20304@animalcreek.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2018 at 07:26:52PM -0700, Mark Greer wrote:
> On Thu, Mar 29, 2018 at 07:22:50PM -0700, Mark Greer wrote:
> > On Tue, Mar 20, 2018 at 10:55:07AM +1100, Oliver wrote:
> 
> > > Yeah that's pretty odd. It might be a bug in your specific version of
> > > GCC since I can't replicate it with this dumb test case:
> > > 
> > > #include <stdio.h>
> > > typedef unsigned int            u32;
> > > 
> > > typedef u32 uint32_t;
> > > typedef u32 uint32_t;
> > > 
> > > int main(void) {
> > >         uint32_t test = 0;
> > >         printf("%u\n", test);
> > >         return 0;
> > > }
> > > 
> > > Does that result in an error?
> > 
> > Hi Oliver.  I'm very sorry for the long delay in responding.
> > 
> > This fail to compile too:
> > 
> > $ cat test.c
> > #include <stdio.h>
> > typedef unsigned int u32;
> > 
> > typedef u32 uint32_t;
> > typedef u32 uint32_t;
> > 
> > int main(void) {
> > 	uint32_t test = 0;
> > 	printf("%u\n", test);
> > 	return 0;
> > }
> > $
> > $ powerpc-linux-gnu-gcc -o test test.c
> > test.c:5:13: error: redefinition of typedef 'uint32_t'
> > test.c:4:13: note: previous declaration of 'uint32_t' was here
> 
> And I meant to add:
> 
> $ powerpc-linux-gnu-gcc --version
> powerpc-linux-gnu-gcc (Sourcery G++ Lite 2010.09-55) 4.5.1
> Copyright (C) 2010 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> So, yeah, its really old.
> 
> I'll get a newer one and test it.

I downloaded this version from denx.de (thank you, Wolfgang):

$ powerpc-linux-gcc --version
powerpc-linux-gcc (GCC) 4.8.2
Copyright (C) 2013 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Its still dated but its the best prebuilt version that I could find easily
available.  With this version, the kernel (ppc6xx_defconfig) built without
issue.

Thanks to all who helped me through this.

To Ben or whoever, I think the original patch is still worth applying even
if it isn't critical.

Thanks,

Mark
--
