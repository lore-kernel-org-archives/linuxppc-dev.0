Return-Path: <snakebyte@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 848BADDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 19:56:29 +1100 (EST)
Date: Fri, 23 Jan 2009 09:56:21 +0100
From: Eric Sesterhenn <snakebyte@gmx.de>
To: Phillip Lougher <phil.lougher@gmail.com>
Subject: Re: Warning and BUG with btrfs and corrupted image
Message-ID: <20090123085620.GA12650@alice>
References: <20090113142147.GE16333@alice>
	<1231857643.29164.28.camel@think.oraclecorp.com>
	<20090113144307.GF16333@alice> <20090118174035.GG1944@ucw.cz>
	<20090120063150.GC5854@alice>
	<1232457065.15042.2.camel@think.oraclecorp.com>
	<20090120165131.GB21339@alice>
	<cce9e37e0901211815l2195858cob6e68ac8ad93e679@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <cce9e37e0901211815l2195858cob6e68ac8ad93e679@mail.gmail.com>
Cc: Tom Rini <trini@kernel.crashing.org>, chris@zankel.net,
	=?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>,
	linuxppc-dev@ozlabs.org, rpurdie@rpsys.net, linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Phillip Lougher (phil.lougher@gmail.com) wrote:
> On Tue, Jan 20, 2009 at 4:51 PM, Eric Sesterhenn <snakebyte@gmx.de> wrote:
> 
> > I already tested squashfs. One issue is basically a problem with
> > the zlib-api for which i just posted a patch here
> > http://marc.info/?t=123212807300003&r=1&w=2
> >
> 
> Thanks for testing Squashfs.  I've not ignored your emails, but I've
> been busy job hunting, and so have not had time to look into this
> until now.

no problem, made me take a closer look at the issue :-) Hope you were
successfull

> I hardened Squashfs against fsfuzzer back in November 2006 (remember
> the month of kernel bugs, or MOKB, which highlighted a number of
> issues with Squashfs).  Your testing has thrown up a regression that I
> inadvertently  put in last month!

Thats why I do the fsfuzzer tests for every kernel i test :-)

will you do the "wheter" -> "whether" change for the other patch locally
and push it or do you want me to send a changed version?

> > The other is an overwritten redzone (also reported in this thread
> > http://marc.info/?l=linux-fsdevel&m=123212794425497&w=2)
> > Looks like a length parameter is passed to squashfs_read_data
> > which is bigger than ((msblk->block_size >> msblk->devblksize_log2) +
> > 1), so the kcalloced buffer gets overwritten later.
> 
> As part of the mainlining effort I changed Squashfs to allocate
> buffers in 4K page sizes rather than use vmalloced large buffers.   As
> far as zlib goes, it means zlib_inflate now decompresses into a
> sequence of 4K buffers rather than one large buffer.   What this means
> is zlib_inflate is called repeatedly moving to the next 4K page
> whenever zlib_inflate asks for another buffer (stream.avail_out == 0).
> 
> Your testing have thrown up the case where zlib_inflate is asking for
> too many output buffers, i.e. it has returned with Z_OK,
> stream.avail_in !=0 (more input data to be processed), and
> stream.avail_out == 0 (I'd like another output buffer).  but it has
> consumed all the output buffers.  This isn't checked (the code assumes
> zlib will do the right thing on corrupt data and bomb out).  My guess
> is either zlib_inflate is getting confused with corrupt data, or
> fsfuzzer gets lucky sometimes and corrupts the filesystem to point to
> another valid but larger compressed block (i.e. in your test
> filesystems the 4K datablock is being corrupted to point to an 8K
> metadata block).
> 
> This ultimately leads to an oops in zlib_inflate where it has been
> passed a bogus or NULL steam.next_out pointer.
> 
> I'll create a patch and send it to you if you're happy to test it.

Sure, just throw it in my direction.

Greetings, Eric
