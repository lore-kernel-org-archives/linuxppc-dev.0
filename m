Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E537B1A2BE5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 01:19:35 +1000 (AEST)
Date: Sun, 13 Sep 2015 08:19:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Build regressions/improvements in v4.3-rc1
Message-ID: <20150913151926.GA19850@roeck-us.net>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 13, 2015 at 11:03:51AM +0200, Geert Uytterhoeven wrote:
> On Sun, Sep 13, 2015 at 11:01 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.3-rc1[1] compared to v4.2[2].
> >
[ ... ]

> 
> >   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error: 'last_sc' may be used uninitialized in this function [-Werror=uninitialized]:  => 1094:31
> 
> powerpc-allyesconfig, powerpc-randconfig, powerpc-allmodconfig
> 

I think that only affects powerpc-randconfig.

Also:

alpha:allmodconfig:

drivers/video/fbdev/aty/atyfb_base.c: In function 'atyfb_setup_generic':
drivers/video/fbdev/aty/atyfb_base.c:3447:2: error: implicit declaration of function 'ioremap_uc'

arm:rpc_defconfig:

fs/fat/dir.c: In function 'fat_ioctl_filldir':
fs/fat/dir.c:752:43: internal compiler error: Max. number of generated reload insns per insn is achieved (90)

[ gcc 4.9.1, 4.9.2 ]

arm64:allmodconfig:

drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ‘__asmeq’
drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ‘secure_flush_area’
drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ‘outer_inv_range’
drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ‘__asmeq’
drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ‘__asmeq’

h8300:edosk2674_defconfig, h8300:h8s-sim_defconfig:

drivers/clk/h8300/clk-h8s2678.c: In function ‘h8s2678_pll_clk_setup’:
drivers/clk/h8300/clk-h8s2678.c:99:14: error: implicit declaration of function ‘kzalloc’
drivers/clk/h8300/clk-h8s2678.c:138:2: error: implicit declaration of function ‘kfree’

Guenter
