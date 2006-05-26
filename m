Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id 957C367B1F
	for <linuxppc-dev@ozlabs.org>; Sat, 27 May 2006 02:07:10 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0512.wanadoo.fr (SMTP Server) with ESMTP id 141941C00231
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 18:07:08 +0200 (CEST)
Date: Fri, 26 May 2006 18:01:56 +0200
To: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH/2.6.17-rc4 10/10] bugs fix for marvell SATA on powerp c pl
	atform
Message-ID: <20060526160156.GA11778@powerlinux.fr>
References: <9FCDBA58F226D911B202000BDBAD46730626DE6E@zch01exm40.ap.freescale.net>
	<1147935734.17679.93.camel@localhost.localdomain>
	<446C9219.4080300@pobox.com> <446CDE26.8090504@rtr.ca>
	<20060526083931.GA23938@powerlinux.fr> <4476E964.90509@rtr.ca>
	<20060526114245.GA32330@powerlinux.fr>
	<44770065.8070907@rtr.ca> <20060526141535.GA7084@powerlinux.fr>
	<447722FF.9020202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <447722FF.9020202@rtr.ca>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Alexandre.Bounine@tundra.com, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 26, 2006 at 11:47:11AM -0400, Mark Lord wrote:
> Sven Luther wrote:
> >On Fri, May 26, 2006 at 09:19:33AM -0400, Mark Lord wrote:
> >>Sven Luther wrote:
> >>>Ok. can i use this tree with a 2.6.16 base ?
> >>Not as-is.  Here (attached) is a patch for 2.6.16.17+ that updates
> >>the sata_mv driver to the latest source.  Completely untested,
> >>but it does compile.
> >>
> >>I will hopefully test it later today, but in the meanwhile, have a go at 
> >>it.
> >
> >And here is attached my dmesg output. The last bit of mv_host_intr was 
> >when i
> >tried to access the partition table of the disk with parted.
> 
> I don't see anything particularly bad in that dmesg output,
> apart from all of the debug output --> did you enable that,
> or was it "on" by default?

Ah, yes, i enabled it on Jeff's suggestion.

> It finds one SATA drive, with no *known* partition table format.

Well, it is a blank disk indeed, so this is no suprise.

> Can you access the disk?  Eg.  hexdump -C /dev/sda

Trying to partition the disk with parted yielded the last set of debug
messages, and a : 

Error: Unable to open /dev/sda - unrecognized disk label.

The same when trying to write a partition table to it, and naturally, there is
no partition afterward.

hexdump yielded only the debugmessages and nothing else.

> Meanwhile, I just booted 2.6.17-rc5-git1 (latest kernel.org) on my Mac G3
> box here, and sata_mv seems to be behaving for me (thus far).

Mmm, this is a G3, while i have a G4. The G4 does some I/O reordering, which
we don't have with a G3, so this may be the cause. 

Do you have a mac version of the board, with a forth/OF bios in it ? Or a
normal PC card, which is thus uninitialized ? 

Friendly,

Sven Luther
