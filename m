Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from moskovskaya.fh-wedel.de (mail.fh-wedel.de [213.39.232.198])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5AA986834F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 05:53:03 +1000 (EST)
Date: Mon, 19 Sep 2005 21:07:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050919190727.GA32650@wohnheim.fh-wedel.de>
References: <200509191155.36540.david.jander@protonic.nl>
	<20050919153747.78ACC352682@atlas.denx.de>
	<c3d0340b050919114040d0a0fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <c3d0340b050919114040d0a0fe@mail.gmail.com>
Cc: linux-mtd@lists.infradead.org, David Jander <david.jander@protonic.nl>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Which way to store log in flash on mpc8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 19 September 2005 11:40:05 -0700, Shawn Jin wrote:
> 
> > > This must be a very common task (to store logfiles in flash), but I just can't
> > > seem to find the right way to do it.
> > 
> > Note that log files may cause a lot of trouble  when  using  a  JFFS2
> > file  system. Youmay want to addd a buffering layer, like pramfs in a
> > dedicated RAM area (SRAM ideally).
> 
> What's the trouble caused by log files when using a JFFS2? I'm not
> aware of that. Any pointers to where I should look into are much
> appreciated.

I guess this should become a FAQ item.

JFFS2 creates one or more nodes whenever sys_write is called.
Unbuffered log entries are usually quite small, so a single node is
written.  Let's assume the worst case, just for fun, writes of a
single by.

Now, each node is prepended by a struct jffs2_raw_inode of 64 bytes.
So you're causing the first problem:
1. Up to 65x the raw file data is written to flash.

Which means you waste bus bandwidth, was flash space and waste flash
lifetime.  After GC, most of those nodes should get combined to 4k
nodes (plus 64 bytes for the header).  Now, JFFS2 also requires an
in-memory structure per node, the struct jffs2_raw_node_ref, weighing
in at 16 or 24 bytes, if you have a 32bit or 64bit arch.  Those will
cost you precious memory:
2. Up to 24x the raw file data is required in DRAM.

Next problem is with GC accounting.  JFFS2 only differentiates between
valid and obsolete data.  After writing a huge logfile, all of its
nodes are still valid.  Therefore GC will never try to GC such nodes,
unless they happen to sit in an erase block with a lot of obsolete
data.  And even then, they could get copied as-is, with no combining.
3. JFFS2 GC is too stupid to detect miniature nodes and combine them.

So, your problem 1 and 2 will not go away if you wait long enough.
Renaming the log file also won't help.  The only cure would be to
*copy* it to the new location and delete the original file afterwards.
Or - alternatively - to fix JFFS2 GC and send a patch.
Or - as already proposed - by writing in larger chunks in the first
place.

If you decide to fix JFFS2 GC, I'd be happy to review the patches and
merge them if deemed worthy.

Jörn

-- 
My second remark is that our intellectual powers are rather geared to
master static relations and that our powers to visualize processes
evolving in time are relatively poorly developed.
-- Edsger W. Dijkstra
