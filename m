Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D351DE0D1
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 08:24:31 +1000 (EST)
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources on 32 bits archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <480E0A54.9010203@linux.vnet.ibm.com>
References: <20080422012723.BA9F2DE13F@ozlabs.org>
	<480E0A54.9010203@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Wed, 23 Apr 2008 08:21:43 +1000
Message-Id: <1208902903.9640.138.camel@pasglop>
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


On Tue, 2008-04-22 at 17:55 +0200, Christian Ehrhardt wrote:
> I wanted to ask if there are any known workarounds atm that would
> allow me to use my X11 for now?

X is doing a mmap of /dev/mem instead of /dev/fb ?

You can normally map the fb mapping /dev/fb and then map the registers
using /dev/fb at an offset beyond the framebuffer (fix->smem_len).

If X is using /dev/mem instead, then it's being stupid and needs to be
fixed...

Cheers,
Ben.
