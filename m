Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzcJc2FW2zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 20:06:23 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org,
 mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com,
 linux-alpha@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com,
 linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 00/16] genrtc removal
Date: Tue, 03 May 2016 12:05:34 +0200
Message-ID: <3351574.jQ0612lD2O@wuerfel>
In-Reply-To: <20160503072418.GA2335@piout.net>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <20160503072418.GA2335@piout.net>
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

On Tuesday 03 May 2016 09:24:18 Alexandre Belloni wrote:
> Hi Arnd,
> 
> I see you didn't copy Greg on that series (that may explain his
> confusion on the previous patch), do you expect me to take it
> through the RTC tree? That is fine but I'd like some acks from him.

Yes, that was a mistake. I dropped Greg from one Cc list in v2 when
I split up the RTC changes into the part that was for drivers/rtc
and the other one for Greg's char-misc tree. Then I reused the first
Cc list when I sent a combined series for v3 again. I'll fix that
when I post v4. There are only very small changes in there that
I still need to pick up, so hopefully that will be the last version.

It would be nice if you could take it through your tree then.

	Arnd

> On 28/04/2016 at 00:34:14 +0200, Arnd Bergmann wrote :
> > I ended up stuffing the two patch series into one, as they are now
> > more dependent on one another. This now thoroughly removes the
> > genrtc driver including the asm/rtc.h headers it uses. For all
> > architectures that still have a meaningful asm/rtc.h, this goes
> > through two stages:
> > 
> > 1) make the rtc-generic implementation independent of asm/rtc.h
> > 2) remove the asm/rtc.h header and disallow the gen_rtc driver
> > 
> > As the last step, the driver itself gets removed.
> > 
> > 	Arnd
> > 
> >  arch/alpha/include/asm/rtc.h          |   1 -
> >  arch/alpha/kernel/core_marvel.c       |   1 -
> >  arch/alpha/kernel/rtc.c               |   6 +-
> >  arch/frv/include/asm/mc146818rtc.h    |  16 -
> >  arch/h8300/include/asm/mc146818rtc.h  |   9 -
> >  arch/ia64/include/asm/mc146818rtc.h   |  10 -
> >  arch/m68k/amiga/config.c              |   1 -
> >  arch/m68k/apollo/config.c             |   1 -
> >  arch/m68k/bvme6000/config.c           |   1 -
> >  arch/m68k/hp300/config.c              |   2 +-
> >  arch/m68k/include/asm/rtc.h           |  79 -----
> >  arch/m68k/kernel/time.c               |  49 +++-
> >  arch/m68k/mac/config.c                |   3 +-
> >  arch/m68k/mac/misc.c                  |   1 -
> >  arch/m68k/mvme147/config.c            |   1 -
> >  arch/m68k/mvme16x/config.c            |   1 -
> >  arch/m68k/q40/config.c                |   2 +-
> >  arch/m68k/sun3/config.c               |   1 -
> >  arch/m68k/sun3/intersil.c             |   2 +-
> >  arch/m68k/sun3x/time.c                |   2 +-
> >  arch/mips/sni/time.c                  |   1 -
> >  arch/mn10300/include/asm/rtc.h        |   2 -
> >  arch/mn10300/kernel/rtc.c             |   2 +-
> >  arch/parisc/include/asm/mc146818rtc.h |   9 -
> >  arch/parisc/include/asm/rtc.h         | 131 ---------
> >  arch/parisc/kernel/time.c             |  36 ++-
> >  arch/powerpc/include/asm/rtc.h        |  78 -----
> >  arch/powerpc/kernel/time.c            |  29 +-
> >  arch/powerpc/platforms/Kconfig        |  11 +
> >  arch/powerpc/platforms/ps3/time.c     |   2 +-
> >  arch/sh/include/asm/mc146818rtc.h     |   7 -
> >  arch/sh/include/asm/rtc.h             |  11 -
> >  arch/sh/kernel/time.c                 |  32 +-
> >  arch/x86/include/asm/mc146818rtc.h    |   1 -
> >  arch/x86/include/asm/rtc.h            |   1 -
> >  arch/x86/kernel/hpet.c                |   3 +-
> >  arch/x86/kernel/rtc.c                 |   3 +-
> >  arch/x86/platform/efi/efi.c           |   1 -
> >  drivers/acpi/acpi_cmos_rtc.c          |   2 +-
> >  drivers/base/power/trace.c            |   6 +-
> >  drivers/char/Kconfig                  |  26 --
> >  drivers/char/Makefile                 |   1 -
> >  drivers/char/genrtc.c                 | 539 ----------------------------------
> >  drivers/rtc/rtc-cmos.c                |  12 +-
> >  drivers/rtc/rtc-generic.c             |  36 +--
> >  drivers/rtc/rtc-mrst.c                |   2 +-
> >  include/asm-generic/rtc.h             | 247 ----------------
> >  include/linux/mc146818rtc.h           | 194 ++++++++++++
> >  48 files changed, 358 insertions(+), 1256 deletions(-)
> > 
> >  [PATCH v3 01/16] rtc: cmos: remove empty asm/mc146818rtc.h files
> >  [PATCH v3 02/16] rtc: cmos: move mc146818rtc code out of
> >  [PATCH v3 03/16] char/genrtc: x86: remove remnants of asm/rtc.h
> >  [PATCH v3 04/16] rtc: sh: provide rtc_class_ops directly
> >  [PATCH v3 05/16] char/genrtc: remove alpha support
> >  [PATCH v3 06/16] char/genrtc: remove mn10300 support
> >  [PATCH v3 07/16] rtc: parisc: provide rtc_class_ops directly
> >  [PATCH v3 08/16] char/genrtc: remove parisc support
> >  [PATCH v3 09/16] rtc: m68k: provide rtc_class_ops directly
> >  [PATCH v3 10/16] rtc: m68k: provide ioctl for q40
> >  [PATCH v3 11/16] char/genrtc: remove m68k support
> >  [PATCH v3 12/16] rtc: powerpc: provide rtc_class_ops directly
> >  [PATCH v3 13/16] char/genrtc: remove powerpc support
> >  [PATCH v3 14/16] rtc: generic: remove get_rtc_time/set_rtc_time
> >  [PATCH v3 15/16] char/genrtc: remove asm-generic/rtc.h from mips
> >  [PATCH v3 16/16] char/genrtc: remove the rest of the driver
> 
> 
