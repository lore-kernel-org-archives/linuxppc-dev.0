Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 980A8B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 07:49:36 +1100 (EST)
Message-ID: <1332362958.2982.41.camel@pasglop>
Subject: Re: Problem with framebuffer mmap on platforms with large addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 22 Mar 2012 07:49:18 +1100
In-Reply-To: <4F6A2FEC.6040003@gmx.de>
References: <CALT56yO05UBY6=KqK94=_sC4hd3ranj5J5CXOAo5hSjVAdkgkA@mail.gmail.com>
 <1332031585.3105.197.camel@pasglop>
 <CALT56yOaxfWYwxvBDbo9dpWo9y37dO0iGge4x6kciZp1oXXHVw@mail.gmail.com>
 <1332103797.3105.202.camel@pasglop>
 <CALT56yPjkPQOaXW4Eg8c-S4+a4Omou_YYacqrsCoTAYeXO0XkA@mail.gmail.com>
 <4F6A2FEC.6040003@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 Tony Breeds <tbreeds@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-03-21 at 19:45 +0000, Florian Tobias Schandinat wrote:
> I finally found where we started to discuss this issue, for reference
> "sm501fb.c: support mmap on PPC440SPe/PPC440EPx" back in May 2010.
> 
> The thing I don't remember is why we consider exporting the physical
> address to userspace desirable (or even necessary). Fixing the generic
> mmap would be trivial without breaking or adding any userspace ABI, I
> think. Just adding those things to fb_info and adjusting fb_mmap
> should
> do the trick, shouldn't it?

For historical reasons, things like X or directfb used it. Modern X
drivers shouldn't any more, but heh...

Cheers,
Ben.
