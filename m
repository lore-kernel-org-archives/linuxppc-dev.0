Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D1B6B7CA0
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jan 2010 07:06:50 +1100 (EST)
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location
	of autoconf.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
References: <20100112022150.GE12666@kryten>
	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>
	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Jan 2010 07:02:43 +1100
Message-ID: <1263412963.724.223.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-01-13 at 12:54 -0600, Kumar Gala wrote:

> > 
> > BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
> > -BOOTCFLAGS	+= -include include/linux/autoconf.h -Iarch/powerpc/include
> > -BOOTCFLAGS	+= -Iinclude
> > +BOOTCFLAGS	+= -include include/generated/autoconf.h
> > +BOOTCFLAGS	+= -I$(srctree)/arch/powerpc/include -I$(srctree)/include
> > 
> > DTS_FLAGS	?= -p 1024
> > 
> 
> Ack, this works for me (seeing as -rc4 doesn't generate uImages w/o it :)
> 

I sent a different patch to Linus yesterday for that.

Cheers,
Ben.
