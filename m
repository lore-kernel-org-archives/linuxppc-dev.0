Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 323902C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 15:39:40 +1100 (EST)
Message-ID: <1386218366.21910.16.camel@pasglop>
Subject: Re: [PATCH] powerpc: fix xmon disassembler for little-endian
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Date: Thu, 05 Dec 2013 15:39:26 +1100
In-Reply-To: <529F31F8.6040302@linux.vnet.ibm.com>
References: <1385975412-25869-1-git-send-email-felix@linux.vnet.ibm.com>
 <529C9397.9050704@gmail.com> <529F31F8.6040302@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Tom Musta <tommusta@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-12-04 at 14:45 +0100, Philippe Bergheaud wrote:

> >>+#ifdef __LITTLE_ENDIAN__
> >>+#define GETWORD(v)	(((v)[3] << 24) + ((v)[2] << 16) + ((v)[1] << 8) + (v)[0])
> >>+#else
> >> #define GETWORD(v)	(((v)[0] << 24) + ((v)[1] << 16) + ((v)[2] << 8) + (v)[3])
> >>+#endif
> >> 
> >> #define isxdigit(c)	(('0' <= (c) && (c) <= '9') \
> >> 			 || ('a' <= (c) && (c) <= 'f') \
> >>
> > 
> > 
> > Philippe:  Wouldn't it be better to just do a 32-bit load and let the endianness be worked out
> > by the hardware?  i.e.
> > 
> > #define GETWORD(v) (*(u32 *)v)
> Yes, your alternative is better.
> Wouldn't it narrow the scope of the macro to aligned words on POWER7?
> I think that all references to GETWORD operate on aligned words anyway.

Well, xmon has to be robust ... as long as you are *certain* that even
with crap entry state it won't try to access unaligned boundaries then
go for it but we aren't looking at performance here.

Cheers,
Ben.
