Return-Path: <npiggin@suse.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2D688B71E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 17:42:23 +1000 (EST)
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B7A17DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 17:42:22 +1000 (EST)
Date: Fri, 12 Jun 2009 09:42:13 +0200
From: Nick Piggin <npiggin@suse.de>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
Message-ID: <20090612074213.GA21070@wotan.suse.de>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
	<4A2D001E.5060802@in.ibm.com>
	<20090609141903.GE15219@wotan.suse.de>
	<4A31EB2A.9080003@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A31EB2A.9080003@in.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Pekka J Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2009 at 11:14:10AM +0530, Sachin Sant wrote:
> Nick Piggin wrote:
> >I can't really work it out. It seems to be the kmem_cache_cache which has
> >a problem, but there have already been lots of caches created and even
> >this samw cache_node already used right beforehand with no problem.
> >
> >Unless a CPU or node comes up or something right at this point or the
> >caller is scheduled onto a different CPU... oopses seem to all
> >have CPU#1, wheras boot CPU is probably #0 (these CPUs are node 0
> >and memory is only on node 1 and 2 where there are no CPUs if I read
> >correctly).
> >
> >I still can't see the reason for the failure, but can you try this
> >patch please and show dmesg?
> I was able to boot yesterday's next (20090611) on this machine. Not sure

Still with SLQB? With debug options turned on?


> what changed(may be because of merge with linus tree), but i can no longer
> recreate this issue with next 20090611. I was consistently able to
> recreate the problem till June 10th next tree.

I would guess some kind of memory corruption that by chance did
not break the other allocators.

Please let us know if you see any more crashes. Thanks for all
your help.
