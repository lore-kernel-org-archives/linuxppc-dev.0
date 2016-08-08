Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s72qX4r1lzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 13:25:44 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id ez1so23153821pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Aug 2016 20:25:43 -0700 (PDT)
Date: Mon, 8 Aug 2016 13:25:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher
 Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Message-ID: <20160808132532.3ce8c0b6@roar.ozlabs.ibm.com>
In-Reply-To: <20160806201045.GA25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
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

On Sat, 6 Aug 2016 22:10:45 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Nicholas.
> 
> On Fri, Aug 05, 2016 at 10:11:59PM +1000, Nicholas Piggin wrote:
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > ld -r is an incremental link used to create built-in.o files in build
> > subdirectories. It produces relocatable object files containing all
> > its input files, and these are are then pulled together and relocated
> > in the final link. Aside from the bloat, this constrains the final
> > link relocations, which has bitten large powerpc builds with
> > unresolvable relocations in the final link.
> > 
> > Alan Modra has recommended the kernel use thin archives for linking.
> > This is an alternative and means that the linker has more information
> > available to it when it links the kernel.
> > 
> > This patch enables a config option architectures can select,  
> If we want to do this, then I suggest to make the logic reverse.
> Architectures that for some reasons cannot use this should
> have the possibility to avoid it. But let it be enabled by default.

I was thinking the build matrix (architectures x build options x toolchains)
is a bit too large to switch it for everybody. I've far from even tested it
for a fraction of powerpc builds. I would prefer arch maintainers to switch
it themselves, but I do hope we can move everybody and just remove the old
method within a few releases.

But I'm happy to go with whatever arch and kbuild maintainers prefer, so I
appreciate any discussion on it.

Thanks,
Nick
