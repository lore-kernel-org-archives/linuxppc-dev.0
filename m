Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s973q5NFBzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 22:43:35 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id y134so162254pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 05:43:35 -0700 (PDT)
Date: Thu, 11 Aug 2016 22:43:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Segher Boessenkool
 <segher@kernel.crashing.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luis R.
 Rodriguez" <mcgrof@kernel.org>, linux-next@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, Fengguang Wu <fengguang.wu@intel.com>, Guenter Roeck
 <linux@roeck-us.net>, Alan Modra <amodra@gmail.com>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Message-ID: <20160811224320.52950a5c@roar.ozlabs.ibm.com>
In-Reply-To: <6481373.xtk4H4bKaE@wuerfel>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <3892328.nUGXIq3MaH@wuerfel>
 <20160803194429.GA14627@gate.crashing.org>
 <6481373.xtk4H4bKaE@wuerfel>
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

On Wed, 03 Aug 2016 22:13:28 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday, August 3, 2016 2:44:29 PM CEST Segher Boessenkool wrote:
> > Hi Arnd,
> > 
> > On Wed, Aug 03, 2016 at 08:52:48PM +0200, Arnd Bergmann wrote:  
> > > From my first look, it seems that all of lib/*.o is now getting linked
> > > into vmlinux, while we traditionally leave out everything from lib/
> > > that is not referenced.
> > > 
> > > I also see a noticeable overhead in link time, the numbers are for
> > > a cache-hot rebuild after a successful allyesconfig build, using a
> > > 24-way Opteron@2.5Ghz, just relinking vmlinux:
> > > 
> > > $ time make skj30 vmlinux # before
> > > real	2m8.092s
> > > user	3m41.008s
> > > sys	0m48.172s
> > > 
> > > $ time make skj30 vmlinux # after
> > > real	4m10.189s
> > > user	5m43.804s
> > > sys	0m52.988s  
> > 
> > Is it better when using rcT instead of rcsT?  
> 
> It seems to be noticeably better for the clean rebuild case, though
> not as good as the original:
> 
> real	3m34.015s
> user	5m7.104s
> sys	0m49.172s
> 
> I've also tried now with my own patch applied as well (linking
> each drivers/*/built-in.o into vmlinux rather than having them
> linked into drivers/built-in.o first), but that makes no
> difference.

I just want to come back to this, because I've subbmitted the thin
archives kbuild patch, I wanted to make sure we're doing okay on
ARM/ARM64. I cross compiled with my laptop.

For ARM64 allyesconfig:

After building then removing all built-in.o then rebuilding vmlinux:
inclink
time make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 vmlinux
real    1m18.977s
user    2m14.512s
sys     0m29.704s

thinarc
time make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8 vmlinux
real    1m18.433s
user    2m6.128s
sys     0m28.372s


Final ld time
inclink
real    0m4.005s
user    0m3.464s
sys     0m0.536s

thinarc
real    0m5.841s
user    0m4.916s
sys     0m0.916s


Build directory size is of course much better (3953MB vs 5519MB).


For ARM, defconfig

After building then removing all built-in.o then rebuilding vmlinux:
inclink
real	0m19.593s
user	0m22.372s
sys	0m6.428s

thinarc
real	0m18.919s
user	0m21.924s
sys	0m6.400s


Final ld time
inclink
real	0m0.378s
user	0m0.304s
sys	0m0.076s

thinarc
real    0m0.894s
user    0m0.684s
sys     0m0.200s

For both cases final link gets slower with thin archives. I guess there is some
per-file overhead but I thought with --whole-archive it should not be that much
slower. Still, overall time for main ar/ld phases comes out about the same in
the end so I don't think it's too much problem. Unless ARM blows up significantly
worse with a bigger config.

Linking with thin archives takes significantly more time in bfd hash lookup code.
I haven't dug much further yet.

Thanks,
Nick
