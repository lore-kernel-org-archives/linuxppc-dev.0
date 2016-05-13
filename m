Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5rmy0ydwzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 23:49:04 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: John Youn <John.Youn@synopsys.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Felipe Balbi <balbi@ti.com>, Douglas Anderson <dianders@chromium.org>,
 Gregory Herrero <gregory.herrero@intel.com>,
 Mian Yousaf Kaukab <yousaf.kaukab@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] usb: dwc2: fix regression on big-endian PowerPC/ARM
 systems
Date: Fri, 13 May 2016 15:48:14 +0200
Message-ID: <5706100.G8QoS78uJd@wuerfel>
In-Reply-To: <573574F2.8010901@synopsys.com>
References: <1463086588-2393828-1-git-send-email-arnd@arndb.de>
 <573574F2.8010901@synopsys.com>
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

On Thursday 12 May 2016 23:32:18 John Youn wrote:
> 
> Hi Arnd,
> 
> The capitalization issue is still there in this patch.
> 
> There's also a few checkpatch issues.

Fixed now, thanks. I'll send a v4 in a bit.

> And should the barrier be moved after the write like it says in the
> comment? That seems to have been removed since earlier versions of
> the patch.

I've clarified the comment, so we refer to the __raw_writel
not the writel. It's also possible that this was just another
bug in the patch that broke powerpc, but I don't know anything
about MIPS barrier semantics, so I prefer not to touch that.

	Arnd
