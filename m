Return-Path: <sam@ravnborg.org>
Received: from pqueueb.post.tele.dk (pqueueb.post.tele.dk [193.162.153.10])
	by ozlabs.org (Postfix) with ESMTP id 6A3EADDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 07:03:54 +1100 (EST)
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueueb.post.tele.dk (Postfix) with ESMTP id 928B381AA
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Feb 2009 21:03:38 +0100 (CET)
Date: Mon, 16 Feb 2009 21:04:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090216200415.GA16721@uranus.ravnborg.org>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
	<20090216142001.GA27869@oksana.dev.rtsoft.ru>
	<20090216145317.GA3616@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090216145317.GA3616@oksana.dev.rtsoft.ru>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> There are few arches that have "auto detection" of CROSS_COMPILE
> variable: mips, m68k, parisc, xtensa, h8300 and blackfin.
> 
> So `normal' arches don't have any chance to overwrite the flags
> because of the few offenders above. ;-)

We also have archs where we add options to gcc that may
impact for example -fno-stack-protector.
We had a bug in x86 in this area for a while.

So the only sane thing is to only add the most generic options to
KBUILD_CFLAGS before we include the arch specific part.
And we can then add the conditional options later - like
the KBUILD_CFLAGS += $(call cc-option, -fno-stack-protector)
in this case.

We learned a few lessons in this area over time as your
history digging also showed.

	Sam
