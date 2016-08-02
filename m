Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3rhR0HtMzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 08:38:30 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: powerpc allyesconfig / allmodconfig linux-next next-20160729 -
 next-20160729 build failures
Date: Wed, 03 Aug 2016 00:34:29 +0200
Message-ID: <1675797.qYisZ5OKTp@wuerfel>
In-Reply-To: <20160802220243.GK3296@wotan.suse.de>
References: <CAB=NE6U18jv89pxqAeZY8eTj44mq90kyXGaQO-108+ZMTyxQiQ@mail.gmail.com>
 <20160802215839.GA7383@roeck-us.net> <20160802220243.GK3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, August 3, 2016 12:02:43 AM CEST Luis R. Rodriguez wrote:
> On Tue, Aug 02, 2016 at 02:58:39PM -0700, Guenter Roeck wrote:
> > On Tue, Aug 02, 2016 at 01:07:09PM -0700, Luis R. Rodriguez wrote:
> > > Are linux-next builds being tested for powerpc with allyesconfig and
> > > allmodconfig ? I have some changes I'm making and while debugging my
> > > build issues I decided to give a clean build a shot and see linux-next
> > > next-20160729 up to next-20160729 all have build failures without my
> > > changes. I get:
> > > 
> > > /opt/gcc-4.9.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
> > > drivers/built-in.o: .opd is not a regular array of opd entries
> > >   MODPOST vmlinux.o
> > >   GEN     .version
> > >   CHK     include/generated/compile.h
> > >   UPD     include/generated/compile.h
> > >   CC      init/version.o
> > >   LD      init/built-in.o
> > > /opt/gcc-4.9.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
> > > drivers/built-in.o: .opd is not a regular array of opd entries
> > > drivers/built-in.o: In function `.ipw2100_up':
> > > ipw2100.c:(.text+0x1ff9c90): relocation truncated to fit:
> > 
> > "relocation truncated to fit"  errors are typical for ppc:allyesconfig.
> 
> Thanks for the confirmation. For how long is it known this is broken?
> Does anyone care and fix these ? Or is this best effort?

We used to have the same thing on ARM, but it's (mostly) fixed now.
In case of ARM, the solution was to ensure that all sections that
have long jumps or targets of long jumps are marked as executable
in the ELF headers, so the linker can insert trampolines.

The one remaining problem at the moment is related to recursive
linking of the drivers/ directory, which has .text section that
is larger than 32MB by itself. There is a patch to solve this by
linking each drivers/*/built-in.o object directly into vmlinux,
but that is a rather drastic change.

	Arnd
