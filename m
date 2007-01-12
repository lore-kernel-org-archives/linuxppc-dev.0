Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D87CADDF08
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 21:43:17 +1100 (EST)
Subject: Re: [PATCH 0/4] drivers/ata: add low-level I/O calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20070112102406.6eb9374f@localhost.localdomain>
References: <200701120958.l0C9wICB019343@toshiba.co.jp>
	<20070112102406.6eb9374f@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 21:41:06 +1100
Message-Id: <1168598466.5011.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-12 at 10:24 +0000, Alan wrote:
> On Fri, 12 Jan 2007 19:00:45 +0900
> Akira Iguchi <akira2.iguchi@toshiba.co.jp> wrote:
> 
> > Dear everyone,
> > 
> > This is the patchset (based on 2.6.20-rc4) to add low-level I/O calls
> > which access the taskfile registers. The idea comes from drivers/ide
> > IN*/OUT* calls.
> 
> I think this is the wrong approach. The existing code provides methods
> for things like "read the status", "write a taskfile" and this is the
> style that should be kept.

I agree (Sorry Akira-san for the added work !), I've looked a bit and I
think that what we need is mainly an accessor for the control register
and for the LBA, and an ack for dmdma. It's unclear to me wether the
full taskfile access would be a good way to do the later though, I'm a
bit worried some HW might get upset if not accessing strictly only the
right registers (we all know how "touchy" those IDE controllers can be).

That would give us something like:

 - bmdma_irq_ack
 - dev_ctrl_read/write (unless we want to split that but there are
   quite a few different accesses so maybe not)
 - dev_sig read/write (read/write nsect/lbal, or maybe we want to let
drivers do their own post_reset)

I think that's it, unless I missd something. 'special' drivers can still
replace bmdma_start/stop etc..

That's just a very quick look, I might have missed something.

Ben.
 
