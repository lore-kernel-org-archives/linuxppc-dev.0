Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 63102DDF24
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 00:35:18 +1000 (EST)
Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1181912593.30670.374.camel@gentoo-jocke.transmode.se>
References: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
	<1181807671.30670.358.camel@gentoo-jocke.transmode.se>
	<4671321E.9000204@ThePTRGroup.com>  <467145BC.1020800@freescale.com>
	<1181912593.30670.374.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 16:35:15 +0200
Message-Id: <1181918115.30670.378.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Chuck Meade <chuck@ThePTRGroup.com>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-15 at 15:03 +0200, Joakim Tjernlund wrote:
> On Thu, 2007-06-14 at 21:42 +0800, Li Yang wrote:
> > Here is the patch to remove internal fragment when doing
> > aligned allocation.
> > 
> > The patch change to add the fragments back into the free list,
> > instead of allocate the whole trunk of space with internal
> > fragment.
> > ---
> 
> This gives me:
> MURAM alloc, start:400, size:200(512), align:8(8)
> MURAM alloc, start:600, size:208(520), align:8(8)
> MURAM alloc, start:880, size:80(128), align:80(128)
> MURAM alloc, start:900, size:1a0(416), align:100(256)
> MURAM alloc, start:aa0, size:40(64), align:20(32)
> MURAM alloc, start:b00, size:100(256), align:100(256)
> MURAM alloc, start:c00, size:a0(160), align:100(256)
> MURAM alloc, start:cc0, size:c(12), align:40(64)
> MURAM alloc, start:cd0, size:30(48), align:8(8)
> MURAM alloc, start:d00, size:80(128), align:80(128)
> MURAM alloc, start:d80, size:80(128), align:80(128)
> MURAM alloc, start:e00, size:80(128), align:80(128)
> MURAM alloc, start:e80, size:80(128), align:80(128)
> MURAM alloc, start:f00, size:40(64), align:40(64)
> MURAM alloc, start:f40, size:40(64), align:40(64)
> MURAM alloc, start:f80, size:40(64), align:40(64)
> MURAM alloc, start:fc0, size:40(64), align:40(64)
> MURAM alloc, start:1000, size:5d(93), align:4(4)

BTW, this last alloc looks a bit off, size if 93 bytes.

 Jocke
