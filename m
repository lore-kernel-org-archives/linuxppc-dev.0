Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40SccM5V6hzF1Rs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Apr 2018 12:48:51 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id m7-v6so6204442plt.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 19:48:51 -0700 (PDT)
Date: Sat, 21 Apr 2018 12:48:38 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
 linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 4/4] powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be
 selected
Message-ID: <20180421124838.5facd0f7@roar.ozlabs.ibm.com>
In-Reply-To: <CA+7wUsyWu3eweWjwfFoS5FD5yb3OxjLV4-XyErcNA4fJGPCf8Q@mail.gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
 <20180420073414.23169-5-npiggin@gmail.com>
 <CA+7wUswuyn+YgNe732rQAzVmgDBohTMEqwsd76nQ_CH5h7Y5WA@mail.gmail.com>
 <20180420204104.6e22b136@roar.ozlabs.ibm.com>
 <CA+7wUsyWu3eweWjwfFoS5FD5yb3OxjLV4-XyErcNA4fJGPCf8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 20 Apr 2018 22:08:27 +0200
Mathieu Malaterre <malat@debian.org> wrote:

> On Fri, Apr 20, 2018 at 12:41 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Fri, 20 Apr 2018 12:00:49 +0200
> > Mathieu Malaterre <malat@debian.org> wrote:
> >  
> >> On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> > This requires further changes to linker script to KEEP some tables
> >> > and wildcard compiler generated sections into the right place. This
> >> > includes pp32 modifications from Christophe Leroy.
> >> >
> >> > When compiling powernv_defconfig with this option:
> >> >
> >> > text       data      bss       dec        filename
> >> > 11827621   4810490   1341080   17979191   vmlinux
> >> > 11752437   4598858   1338776   17690071   vmlinux.dcde
> >> >
> >> > Resulting kernel is almost 400kB smaller (and still boots).
> >> >
> >> > [ppc32 numbers here]  
> >>
> >> ^^^
> >>
> >> Do you want somebody else to provide those numbers ?  
> >
> > If you have a booting kernel, yes some more numbers would be good.  
> 
> I've used /boot/config-4.15.0-2-powerpc from my current debian
> package. Rebuild master with and without option, boot ok, load/unload
> module ok.
> 
> $ size nick/vmlinux.with*
>    text    data     bss     dec     hex filename
> 7386425 2364370 1425432 11176227 aa8923 nick/vmlinux.with
> 7461457 2475122 1428064 11364643 ad6923 nick/vmlinux.without
> 
> This is not clear why with option the size of kernel is slightly bigger:
> 
> $ du -sk nick/vmlinux.with*
> 124488 nick/vmlinux.with
> 124004 nick/vmlinux.without

Not sure. readelf -S vmlinux may show something.

To really get lots of detail, you can add to the top level Makefile:

LDFLAGS_vmlinux += -M

Then it will print the link map for you and other details. Actually
it will output several times because we link vmlinux 2-3 times, so
just take the last one. There is a lot of data there.
