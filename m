Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AD0D0DE002
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 19:42:49 +1000 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH 1/3] radeonfb: Fix 64 bits
	resources on 32 bits archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
In-Reply-To: <1208943127.5632.324.camel@thor.sulgenrain.local>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
	<1208902903.9640.138.camel@pasglop>
	<1208943127.5632.324.camel@thor.sulgenrain.local>
Content-Type: text/plain; charset=utf-8
Date: Wed, 23 Apr 2008 19:40:33 +1000
Message-Id: <1208943633.9060.26.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net,
	Hollis Blanchard <hollisb@us.ibm.com>, adaplas@gmail.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, Detlev Zundel <dzu@denx.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-23 at 11:32 +0200, Michel Dänzer wrote:
> > X is doing a mmap of /dev/mem instead of /dev/fb ?
> > 
> > You can normally map the fb mapping /dev/fb and then map the
> registers
> > using /dev/fb at an offset beyond the framebuffer (fix->smem_len).
> > 
> > If X is using /dev/mem instead, then it's being stupid and needs to
> be
> > fixed...
> 
> It's up to the driver, and again, the current radeon driver doesn't
> use
> radeonfb at all anymore...

Right. And I'm happy to go fix what remains, don't get me wrong here :-)
We all know how stupid legacy code can be !

I'll try to get some patches to expose a new version of the structure
sometimes in the upcoming week or two (we'll see what time permits) and
then see about fixing X drivers that need fixing, though hopefully with
pci-rework being upstream now, that shouldn't be many.

The main issue is directfb. I hope they'll catch up with the new ioctls.

Ben.
