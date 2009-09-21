Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4B666B7B7C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 09:01:20 +1000 (EST)
Date: Tue, 22 Sep 2009 03:01:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: NAND partition names in DTS must be named "partition"?
Message-ID: <20090921230118.GB32278@oksana.dev.rtsoft.ru>
References: <5ee96a840909211527g45b47b3fgff907df69fe48666@mail.gmail.com>
	<4AB7FFE9.8050206@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4AB7FFE9.8050206@freescale.com>
Cc: linuxppc-dev@ozlabs.org, "Matthew L. Creech" <mlcreech@gmail.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 21, 2009 at 05:36:25PM -0500, Scott Wood wrote:
> Matthew L. Creech wrote:
> >I upgraded from 2.6.29 to 2.6.31, and the kernel no longer recognized
> >the partitions embedded within my DTS file.  I had to revert this
> >change:
> >
> >http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=4b08e149c0e02e97ec49c2a31d14a0d3a02f8074
> >
> >in order to boot.  This code looks like it expects all partitions to
> >be named "partition", otherwise they're just skipped.  Is there some
> >peculiarity in my setup that makes this not work, or is it a general
> >problem?  I see no major differences between my DTS file and the
> >stardard "mpc8313erdb.dts".
> 
> It looks like mpc8313erdb.dts needs to be updated.

I don't think so, it's just 2.6.31 has a regression that should
be fixed by "MTD ofpart: Check availability of reg property instead
of name property":

http://patchwork.ozlabs.org/patch/32039/

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
