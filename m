Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85E561A2BE5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 02:58:17 +1000 (AEST)
Date: Sun, 13 Sep 2015 17:57:59 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: Build regressions/improvements in v4.3-rc1
Message-ID: <20150913165758.GE21084@n2100.arm.linux.org.uk>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
 <20150913151926.GA19850@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150913151926.GA19850@roeck-us.net>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 13, 2015 at 08:19:26AM -0700, Guenter Roeck wrote:
> arm:rpc_defconfig:
> 
> fs/fat/dir.c: In function 'fat_ioctl_filldir':
> fs/fat/dir.c:752:43: internal compiler error: Max. number of generated reload insns per insn is achieved (90)

Not much can be done about that - gcc people aren't interested in fixing
ARMv3 compiler support anymore, although this is still buildable with
older compilers.  I don't see any point in removing the platform just
because GCC has decided to break itself.

> arm64:allmodconfig:
> 
> drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ‘__asmeq’
> drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ‘secure_flush_area’
> drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ‘outer_inv_range’
> drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ‘__asmeq’
> drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ‘__asmeq’

This file shouldn't be built on ARM64, and there's a fix in the pipeline
which obviously didn't make -rc1 for it.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
