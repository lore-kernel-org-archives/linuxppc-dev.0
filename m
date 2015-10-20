Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (down.free-electrons.com
 [37.187.137.238])
 by lists.ozlabs.org (Postfix) with ESMTP id CFE691A0295
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 02:16:50 +1100 (AEDT)
Date: Tue, 20 Oct 2015 17:10:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-soc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-msm@vger.kernel.org, Andy Gross <agross@codeaurora.org>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
 linux-mediatek@lists.infradead.org,
 Anton Blanchard <anton@samba.org>, linux-serial@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 David Brown <davidb@codeaurora.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Message-ID: <20151020151052.GI3421@piout.net>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/10/2015 at 18:21:13 -0400, Paul Gortmaker wrote :
> The one common thread here for all the patches is that we also
> scrap the .remove functions which would only be used for module
> unload (impossible) and driver unbind.  For the drivers here, there
> doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
> PCI ethernet driver where one port is unbound and passed through to
> a kvm guest or similar).  Hence we just explicitly disallow any
> driver unbind operations to help prevent root from doing something
> illogical to the machine that they could have done previously.
> 
> We've already done this for drivers/tty/serial/mpsc.c previously.
> 
> Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.
> 

So, how does this actually build test atmel_serial?

A proper solution would be to actually make it a tristate and allow
building as a module. I think it currently fails because of
console_initcall() but that is certainly fixable.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
