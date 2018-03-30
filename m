Return-Path: <mgreer@animalcreek.com>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40C54h0kVLzF1c2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 13:22:58 +1100 (AEDT)
Date: Thu, 29 Mar 2018 19:22:50 -0700
From: Mark Greer <mgreer@animalcreek.com>
To: Oliver <oohall@gmail.com>
Cc: Mark Greer <mgreer@animalcreek.com>,
 Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] powerpc/boot: Remove duplicate typedefs from libfdt_env.h
Message-ID: <20180330022250.GA20304@animalcreek.com>
References: <20180316215443.2807-1-mgreer@animalcreek.com>
 <e710d9d7-232b-6420-96a7-8167dd91b824@c-s.fr>
 <20180319160216.GD9670@animalcreek.com>
 <CAOSf1CFVH+OEkZCN+AYOxb863akkuw44uOENVEi=zf=QVc-UmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAOSf1CFVH+OEkZCN+AYOxb863akkuw44uOENVEi=zf=QVc-UmQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2018 at 10:55:07AM +1100, Oliver wrote:
> On Tue, Mar 20, 2018 at 3:02 AM, Mark Greer <mgreer@animalcreek.com> wrote:
> > On Mon, Mar 19, 2018 at 09:53:09AM +0100, Christophe LEROY wrote:
> >>
> >>
> >> Le 16/03/2018 à 22:54, Mark Greer a écrit :
> >> >When building a uImage or zImage using ppc6xx_defconfig and some other
> >> >defconfigs, the following error occurs:
> >> >
> >> >   BOOTCC  arch/powerpc/boot/fdt.o
> >> >   In file included from arch/powerpc/boot/fdt.c:51:0:
> >> >   ../arch/powerpc/boot/libfdt_env.h:10:13: error: redefinition of typedef 'uint32_t'
> >> >   ../arch/powerpc/boot/types.h:21:13: note: previous declaration of 'uint32_t' was here
> >> >   ../arch/powerpc/boot/libfdt_env.h:11:13: error: redefinition of typedef 'uint64_t'
> >> >   ../arch/powerpc/boot/types.h:22:13: note: previous declaration of 'uint64_t' was here
> >> >   ../arch/powerpc/boot/Makefile:210: recipe for target 'arch/powerpc/boot/fdt.o' failed
> >> >   make[2]: *** [arch/powerpc/boot/fdt.o] Error 1
> >> >
> >> >The problem is that commit 656ad58ef19e (powerpc/boot: Add OPAL console
> >> >to epapr wrappers) adds typedefs for uint32_t and uint64_t to type.h but
> >> >doesn't remove the pre-existing (and now duplicate) typedefs from
> >> >libfdt_env.h.  Fix the error by removing the duplicat typedefs from
> >> >libfdt_env.h
> >> >
> >> >CC: David Gibson <david@gibson.dropbear.id.au>
> >> >CC: Oliver O'Halloran <oohall@gmail.com>
> >> >Signed-off-by: Mark Greer <mgreer@animalcreek.com>
> >> >---
> >> >Having said all of that, commit 656ad58ef19e (powerpc/boot: Add OPAL
> >> >console to epapr wrappers) went into mainline back in 2016 so, AFAICT,
> >> >this has been broken since then.  That seems unlikely so I must be
> >> >missing something...  Any ideas what that is?
> >>
> >> I just compiled uImage for ppc6xx_defconfig, and I don't get such error.
> >> I looked at what gcc -E outputs, u32 is defined twice but it doesn't seems
> >> to bother GCC.
> >>
> >> What version of GCC do you use ?
> >> I tried with 5.4.0 and 4.6.3, both seems to work.
> >>
> >> Christophe
> >
> > Hi Christophe.
> >
> > That's interesting.  I would expect an error regardless of version.
> >
> > I used an old 4.5.1 gcc that I had laying around (from denx, iirc).
> > I'll find a newer one and try it.
> 
> Yeah that's pretty odd. It might be a bug in your specific version of
> GCC since I can't replicate it with this dumb test case:
> 
> #include <stdio.h>
> typedef unsigned int            u32;
> 
> typedef u32 uint32_t;
> typedef u32 uint32_t;
> 
> int main(void) {
>         uint32_t test = 0;
>         printf("%u\n", test);
>         return 0;
> }
> 
> Does that result in an error?

Hi Oliver.  I'm very sorry for the long delay in responding.

This fail to compile too:

$ cat test.c
#include <stdio.h>
typedef unsigned int u32;

typedef u32 uint32_t;
typedef u32 uint32_t;

int main(void) {
	uint32_t test = 0;
	printf("%u\n", test);
	return 0;
}
$
$ powerpc-linux-gnu-gcc -o test test.c
test.c:5:13: error: redefinition of typedef 'uint32_t'
test.c:4:13: note: previous declaration of 'uint32_t' was here

> > Either way, it seems to me that we should remove the duplicate definitions.
> > Do you agree?
> 
> It wouldn't hurt to remove those definitions from libfdt_env.h. That
> file includes types.h directly anyway so there's not much point in
> them being there.

+1

Mark
--
