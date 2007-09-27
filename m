Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BFFCDDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:09:08 +1000 (EST)
Subject: Re: [PATCH 1/7] PowerPC64: Not to insert EA=0 entry at
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20070927.202207.-1300525707.kouish@swc.toshiba.co.jp>
References: <20070927.202207.-1300525707.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 08:08:56 +1000
Message-Id: <1190930936.6158.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-09-27 at 20:22 +0900, Ishizaki Kou wrote:
> Ben-san,
> 
> > On Thu, 2007-09-27 at 17:01 +0900, kou.ishizaki@toshiba.co.jp wrote:
> >
> > > Celleb does not set get_paca()->kstack properly (I don't know which
> > > function should set it up), so we need to workaround.
> >
> > paca->kstack is set in asm (via the PACAKSAVE macro), from either
> > __secondary_start for non-boot CPUs or from start_here_common for the
> > boot CPU.
> >
> > slb_flush_and_rebolt() should not be called before that happens.
> >
> > How do you end up with kstack set to 0 ?
> 
> I found r13 is not set before entering start_here_common for boot cpu.
> For non-boot threads, __secondary_start will set r13 properly.
> 
> So the problem is to set r13 correct PACA address before entering
> start_here_common. Should it set before entering kernel or will some
> patch make sense?

That is scary... we seem to have lost an mfsprg r13,SPRN_SPRG3 somewhere
along the way, I'm surprised things boot at all, or maybe I'm missing
something here... Paul ?

Ben.
