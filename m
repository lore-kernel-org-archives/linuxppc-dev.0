Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F7851A030F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 11:20:44 +1100 (AEDT)
Date: Tue, 20 Oct 2015 20:20:07 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <linux-soc@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-arm-msm@vger.kernel.org>, Andy Gross <agross@codeaurora.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 <linux-kernel@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>,
 <linux-mediatek@lists.infradead.org>, Anton Blanchard
 <anton@samba.org>, <linux-serial@vger.kernel.org>, Jiri Slaby
 <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, David Brown
 <davidb@codeaurora.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Message-ID: <20151021002007.GA4588@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
 <20151020151052.GI3421@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20151020151052.GI3421@piout.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 20/10/2015 (Tue 17:10) Alexandre Belloni wrote:

> On 18/10/2015 at 18:21:13 -0400, Paul Gortmaker wrote :
> > The one common thread here for all the patches is that we also
> > scrap the .remove functions which would only be used for module
> > unload (impossible) and driver unbind.  For the drivers here, there
> > doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
> > PCI ethernet driver where one port is unbound and passed through to
> > a kvm guest or similar).  Hence we just explicitly disallow any
> > driver unbind operations to help prevent root from doing something
> > illogical to the machine that they could have done previously.
> > 
> > We've already done this for drivers/tty/serial/mpsc.c previously.
> > 
> > Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.
> > 
> 
> So, how does this actually build test atmel_serial?

Not sure why this should be a surprise;  I build test it exactly like this:

paul@builder-02:~/git/linux-head$ echo $ARCH
arm64
paul@builder-02:~/git/linux-head$ echo $CROSS_COMPILE 
aarch64-linux-gnu-
paul@builder-02:~/git/linux-head$ make O=../arm-build/  drivers/tty/serial/atmel_serial.o
make[1]: Entering directory '/home/paul/git/arm-build'
arch/arm64/Makefile:25: LSE atomics not supported by binutils
  CHK     include/config/kernel.release
  Using /home/paul/git/linux-head as source for kernel
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h

[...]

  HOSTCC  scripts/sign-file
  HOSTCC  scripts/extract-cert
  CC      drivers/tty/serial/atmel_serial.o
make[1]: Leaving directory '/home/paul/git/arm-build'
paul@builder-02:~/git/linux-head$ 

It did build; no warning/error.  Would you call it an invalid build test?

> 
> A proper solution would be to actually make it a tristate and allow
> building as a module. I think it currently fails because of
> console_initcall() but that is certainly fixable.

Well, as per other threads on this topic, if people want to extend
the functionality to support tristate, then great.  But please do
not confuse that with existing functionality which is clearly non
modular in this case.

Thanks,
Paul.
--

> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
