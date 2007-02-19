Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B6B22DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:12:26 +1100 (EST)
Subject: Re: [RFC 3/3] zImage: Exception vector support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45D9BC29.5020507@am.sony.com>
References: <45D7A914.4040000@am.sony.com>
	<20070218014043.GD1038@crusty.rchland.ibm.com>
	<45D9BC29.5020507@am.sony.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 06:55:04 +1100
Message-Id: <1171914904.18571.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-19 at 07:03 -0800, Geoff Levand wrote:
> Josh Boyer wrote:
> > On Sat, Feb 17, 2007 at 05:17:08PM -0800, Geoff Levand wrote:
> >> Add SMP exception vector support to the powerpc zImage bootwrapper.  For
> >> platforms which have entry points in the vector table.  This implements
> >> SMP entry via the system reset vector.
> >> 
> >> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> >> 
> >> ---
> >>  arch/powerpc/boot/head.S       |   96 +++++++++++++++++++++++++++++++++++++++++
> >>  arch/powerpc/boot/zImage.lds.S |    2 
> > 
> > This one seems pretty PS3 specific, and there's no makefile entry to actually
> > compile it...  Could we name it head_ps3.S or something similar?
> > 
> > Or am I misunderstanding the code and it's really generic to most SMP
> > machines (which would make a case to arguably call it head_smp.S).
> 
> No, its not platform specific nor SMP specific, it should work
> with all SMP and UP platforms that need this kind of support.

Well, all platforms that are multithread at least... the thread number
testing won't do any good on 970 for example :-)

Ben.
