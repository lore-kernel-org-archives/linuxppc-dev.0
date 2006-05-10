Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD6D4679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 21:11:51 +1000 (EST)
Date: Wed, 10 May 2006 12:11:41 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Viable PPC platform?
Message-Id: <20060510121141.0a866b8f.ajz@cambridgebroadband.com>
In-Reply-To: <20060509171520.GA10886@gate.ebshome.net>
References: <e3q9gu$vq8$1@sea.gmane.org>
	<20060509174101.389c67c0.ajz@cambridgebroadband.com>
	<20060509171520.GA10886@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org, gd.smth@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 9 May 2006 10:15:20 -0700
Eugene Surovegin <ebs@ebshome.net> wrote:

> On Tue, May 09, 2006 at 05:41:01PM +0100, Alex Zeffertt wrote:
> > On Tue, 09 May 2006 10:38:19 -0400
> > geneSmith <gd.smth@gmail.com> wrote:
> > 
> > > I have a ppc405gpr system with 64M ram and 4Meg flash in a
> > > AM29LV320. Is this a viable platform for linux? Can a filesystem
> > > (JFFS2?) be put this flash type?
> > > 
> > 
> > I would create an initrd and put every file that doesn't need
> > to be changed persistently into it instead of JFFS2.
> 
> After many years of doing embedded Linux stuff I still don't 
> understand why people are so fond of initrd.
> 
> For temporary stuff - tempfs is much better and flexible. For r/o 
> stuff - just make separate MTD partition (cramfs, squashfs) and
> mount it directly as root. Both options will waste significantly
> less memory.
> 

Okay, let me qualify my answer.  It depends on whether you need to
make persistent changes to the filesystem in flash.  If so, and given
that your flash is only 4MB, I would recommend moving files to
somewhere else, e.g. an initrd, because if when a JFFS2 FS is
approaching full, you often find that writes to flash hang
while JFFS2 searches for blocks to use as a scratchpad.  This has been
my experience anyway.

If you don't need to make persistent changes to files, then I'm sure
cramfs in flash as a rootfs would work well, with a tmpfs partition
mounted on /tmp and /var.

Alex
