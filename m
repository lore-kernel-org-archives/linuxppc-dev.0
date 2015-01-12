Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 816F41A064E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 04:59:40 +1100 (AEDT)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YAjH9-0000x7-9S
 for linuxppc-dev@lists.ozlabs.org; Mon, 12 Jan 2015 17:59:39 +0000
Date: Mon, 12 Jan 2015 09:59:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: linux-next: Tree for Jan 12 (build failures: m68k, ppc)
Message-ID: <20150112175920.GC19868@roeck-us.net>
References: <20150112180322.003b44f2@canb.auug.org.au>
 <20150112162438.GA18723@roeck-us.net>
 <CAMuHMdUYEe=L=H75AOYVjinRSW=okRJNrNJVy-bY1gshdVrO7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUYEe=L=H75AOYVjinRSW=okRJNrNJVy-bY1gshdVrO7Q@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Clark <robdclark@gmail.com>, Linux-Next <linux-next@vger.kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2015 at 05:27:08PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 12, 2015 at 5:24 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Mon, Jan 12, 2015 at 06:03:22PM +1100, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20150109:
> >>
> >> The usb-gadget-fixes tree gained a conflict against the usb.current tree.
> >>
> >> The net-next tree gained a build failure for which I reverted a commit.
> >>
> >> The pinctrl tree gained a build failure so I used the version from
> >> next-20150109.
> >>
> >> The akpm tree lost a few patches that turned up elsewhere.
> >>
> >> Non-merge commits (relative to Linus' tree): 2202
> >>  2272 files changed, 69868 insertions(+), 38441 deletions(-)
> >>
> >
> > Build failures, seen since next-20150109:
> >         m68k:allmodconfig
> >         powerpc:ppc6xx_defconfig
> >
> > Due to:
> >         ERROR: "__get_user_bad" [drivers/gpu/drm/drm.ko] undefined!
> >         make[1]: *** [__modpost] Error 1
> >
> > Caused by commit d34f20d6e2f (drm: Atomic modeset ioctl).
> 
> Yeah, it needs a get_user() that supports 64-bit data.
> 
Hi Geert,

I assume you mean m68k, where 64 bit support for get_user has been disabled.

The problem on powerpc is different though: __get_user_nocheck()
and __get_user_check() use
	unsigned long __gu_val;
followed by
	__get_user_size(__gu_val, __gu_addr, (size), __gu_err);

__get_user_size() fails in
	if (size > sizeof(x))
		 (x) = __get_user_bad();

Presumably "unsigned long" is 32 bit on 32 bit powerpc, not 64 bit.

Overall, the explicit 64-bit use of get_user() seems to be quite unusual.

Thanks,
Guenter
