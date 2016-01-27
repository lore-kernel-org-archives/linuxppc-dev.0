Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 179781A0174
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 00:45:06 +1100 (AEDT)
Date: Wed, 27 Jan 2016 14:45:02 +0100
From: Torsten Duwe <duwe@lst.de>
To: Alan Modra <amodra@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>,
 Anton Blanchard <anton@samba.org>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
Message-ID: <20160127134502.GC32095@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
 <1453889967.10839.2.camel@ellerman.id.au>
 <20160127125809.GN17028@bubble.grove.modra.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160127125809.GN17028@bubble.grove.modra.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2016 at 11:28:09PM +1030, Alan Modra wrote:
> On Wed, Jan 27, 2016 at 09:19:27PM +1100, Michael Ellerman wrote:
> > 
> > Can we use r11 instead? eg:
> > 
> > _GLOBAL(_mcount)
> > 	mflr	r11
> > 	mtctr	r11
> > 	mtlr	r0
> > 	bctr
> 
> Depends on what you need to support.  As Torsten says, the code to
> call _mcount when -mprofile-kernel is emitted before the prologue of a
> function (similar to -m32), but after the ELFv2 global entry point
> code.  If you trash r11 here you're killing the static chain pointer,
> used by C nested functions or other languages that use a static chain,
> eg. Pascal.  r11 has *not* been saved for ELFv2.

Even if nested functions aren't supported in the Linux kernel(?), I think
it was an earlier version of mcount when r11 usage ruined my day.

> r12 might be a better choice for a temp reg.

Good idea. r12 holds the function entry point and is used to calculate the
new TOC value just _before_ the call. It should be available.
I'll try, thanks for the hint.

	Torsten
