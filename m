Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5BFJ2cKnzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:52:51 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
 John Youn <johnyoun@synopsys.com>, Gregory Herrero <gregory.herrero@intel.com>,
 linux-mips@linux-mips.org, a.seppala@gmail.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>, gregkh@linuxfoundation.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] usb: dwc2: fix regression on big-endian PowerPC/ARM
 systems
Date: Thu, 12 May 2016 13:52:17 +0200
Message-ID: <2597884.52Dcpckj86@wuerfel>
In-Reply-To: <87y47fcxhs.fsf@linux.intel.com>
References: <1463050104-2788693-1-git-send-email-arnd@arndb.de>
 <2809110.sWekaCNVxS@wuerfel> <87y47fcxhs.fsf@linux.intel.com>
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

On Thursday 12 May 2016 14:43:43 Felipe Balbi wrote:
> >> How many more drivers will we have to 'fix' like this ?
> >
> > Endianess problems will keep coming up, and we have hundreds or thousands
> > of drivers that are written with a particular design in mind that could
> > be wrong as soon as someone chooses to build an SoC that does things
> > differently. Once that happens, we'll fix them.
> >
> > Also, Christian has already posted a better version of the patch
> > that fixes this driver in an architecture independent way, but we still
> > need a workaround for the stable backports.
> 
> hmmm, at least dwc3 (also from SNPS) has a couple bits where we can
> choose endianess for registers and DMA descriptors. John, do we have the
> same for dwc2 ? Wouldn't that be a better way to solve the problem ?

Yes, I think that would be the best solution (provided it works correctly).

My understanding is that the descriptors don't need to change
for the particular MIPS machine, only the registers do. If we have
another machine that requires the descriptor endianess to be flipped
from the default, we probably need a DT property or platform_data
flag to encode that.

We can do the register endianess detection from Christian's patch to
flip it around if necessary, and then revert back to the previous
state of always using readl/writel.

	Arnd
