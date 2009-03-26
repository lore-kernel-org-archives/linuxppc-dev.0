Return-Path: <Joakim.Tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07305DDE19
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 05:20:54 +1100 (EST)
In-Reply-To: <20090326180543.GA2406@oksana.dev.rtsoft.ru>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1238072077-27044-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<20090326133918.GA27085@oksana.dev.rtsoft.ru>
	<OF5FC70952.28684E98-ONC1257585.005ADBF9-C1257585.005BDD35@transmode.se>
	<20090326180543.GA2406@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] ucc_geth: Rework the TX logic.
Message-ID: <OFEB54C9DC.647D70E1-ONC1257585.0064475A-C1257585.0064C85F@transmode.se>
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Thu, 26 Mar 2009 19:20:49 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> wrote on 26/03/2009 19:05:43:

> On Thu, Mar 26, 2009 at 05:43:25PM +0100, Joakim Tjernlund wrote:
> [...]
> > > bd == ugeth->confBd[txQ]
> > > and
> > > !in_be32((u32 __iomem *)(bd+4))
> > > 
> > > Are not equivalent wrt. speed. MMIO accessors should be rather
> > > slow comparing to normal memory.
> > 
> > Yes, I know. I did it this way because I something broke under stress
> > when ugeth->confBd[txQ] instead. The ucc_geth_tx() and 
> > ucc_geth_start_xmit()
> > gets out of sync somehow.
> 
> Would be great if you could investigate it more. Maybe there is
> a serious bug somewhere, or maybe you're introducing another
> (yet hidden) bug...

I have spent some time on it and didn't see how to do it. I don't think
the current method hides any bugs. I have used this method on 8xx for
many years and it works well.

Actually the current method might work without the 
spin_lock_irq(&ugeth->lock)/spin_unlock_irq(&ugeth->lock)
in ucc_geth_start_xmit(). I can't break it, can you?

 Jocke
