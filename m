Return-Path: <lsorense@csclub.uwaterloo.ca>
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca
 [129.97.134.17])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8C7G2NkszDv07
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 02:43:38 +1100 (AEDT)
Date: Wed, 2 Nov 2016 11:36:00 -0400
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mathieu Malaterre <malat@debian.org>, linux-fbdev@vger.kernel.org,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix loading of module radeonfb on PowerMac
Message-ID: <20161102153600.GL1465@csclub.uwaterloo.ca>
References: <1475928540-19647-1-git-send-email-malat@debian.org>
 <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fbf3b5a3-efd9-0f85-c4fe-ae34ae1862b7@ti.com>
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 02, 2016 at 10:28:55AM +0200, Tomi Valkeinen wrote:
> On 08/10/16 15:09, Mathieu Malaterre wrote:
> > When the linux kernel is build with (typical kernel ship with Debian
> > installer):
> > 
> > CONFIG_FB_OF=y
> > CONFIG_VT_HW_CONSOLE_BINDING=y
> > CONFIG_FB_RADEON=m
> > 
> > The offb driver takes precedence over module radeonfb. It is then
> > impossible to load the module, error reported is:
> > 
> > [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> > [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000000-0x9fffffff pref]
> > [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> > [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
> > 
> > This patch reproduce the behavior of the module radeon, so as to make it
> > possible to load radeonfb when offb is first loaded.
> > 
> > It should be noticed that `offb_destroy` is never called which explain the
> > need to skip error detection on the radeon side.
> 
> Why is that? It sounds rather bad if two drivers claim the same resources.

My understanding from reading through the console code is that you only
call destroy when the driver isn't in use anymore, and that doesn't
happen until something else takes over the console, which can't happen
until the new driver is active, which can't happen because the resources
are already claimed by the old driver.

PCs might be able to drop back to text console, but powerpc doesn't have
one of those so offb stays active until something else takes over the
console job it seems.

The radeon driver doesn't reserve resources, it just uses them.
This seems to be the case of quite a few drivers.

-- 
Len Sorensen
