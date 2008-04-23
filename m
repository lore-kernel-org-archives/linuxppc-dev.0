Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5FB61DDFC5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 19:57:21 +1000 (EST)
Date: Wed, 23 Apr 2008 02:57:21 -0700 (PDT)
Message-Id: <20080423.025721.50367920.davem@davemloft.net>
To: michel@tungstengraphics.com
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3] radeonfb: Fix 64 bits
	resources on 32 bits archs
From: David Miller <davem@davemloft.net>
In-Reply-To: <1208943127.5632.324.camel@thor.sulgenrain.local>
References: <480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
	<1208943127.5632.324.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linux-fbdev-devel@lists.sourceforge.net, hollisb@us.ibm.com,
	adaplas@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michel D=E4nzer <michel@tungstengraphics.com>
Date: Wed, 23 Apr 2008 11:32:07 +0200

> On Wed, 2008-04-23 at 08:21 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
> > > I wanted to ask if there are any known workarounds atm that would=

> > > allow me to use my X11 for now?
> > =

> > X is doing a mmap of /dev/mem instead of /dev/fb ?
> > =

> > You can normally map the fb mapping /dev/fb and then map the regist=
ers
> > using /dev/fb at an offset beyond the framebuffer (fix->smem_len).
> > =

> > If X is using /dev/mem instead, then it's being stupid and needs to=
 be
> > fixed...
> =

> It's up to the driver, and again, the current radeon driver doesn't u=
se
> radeonfb at all anymore...

The only portable thing is for X to use the PCI sysfs mmap() stuff,
which current Xorg servers using libpciaccess do.

I know because I'm typing this from a sparc64 using a Radeon
with current Xorg :-)
