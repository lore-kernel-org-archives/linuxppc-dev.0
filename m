Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3099DB718B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 01:49:33 +1000 (EST)
Date: Thu, 19 May 2011 16:50:39 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded
	hypervisor byte channel driver
Message-ID: <20110519165039.7fd8ec34@lxorguk.ukuu.org.uk>
In-Reply-To: <4DD533DE.1020705@freescale.com>
References: <1305813272-31826-1-git-send-email-timur@freescale.com>
	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<20110519153358.5876f310@lxorguk.ukuu.org.uk>
	<4DD533DE.1020705@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Under what circumstances can ttys be NULL?  I currently only use this code in
> the RX and TX interrupt handlers, which are both enabled in the
> tty_port_operations.activate() function.

When you add hangup support.

> 
> Is this right for the TX handler:
> 
> static irqreturn_t ehv_bc_tty_tx_isr(int irq, void *data)
> {
> 	struct ehv_bc_data *bc = data;
> 	struct tty_struct *ttys = tty_port_tty_get(&bc->port);
> 
> 	ehv_bc_tx_dequeue(bc);
> 	if (ttys) {
> 		tty_wakeup(ttys);
> 		tty_kref_put(ttys);
> 	}
> 
> 	return IRQ_HANDLED;

Yes.
		    EV_BYTE_CHANNEL_MAX_BYTES);
> > The kfifo API is probably faster and cleaner. Much of tty still uses
> > CIRC_* because they predate the new APIs.
> 
> Ok, I'll change it.

I flag that one up as a general comment - don't feel you need to change
it if CIRC_* works in your case.

> > I guess the only other thing to consider is whether you want to implement
> > a SYSRQ interface on your console ?
> 
> I don't think byte channels can support SYSRQ, but I'll look into it.

What some drivers do in this case is nominate some obscure ctrl sequence
to mean 'sysrq' unless doubled (eg ctrl-^ etc)

Depends if the functionality is useful in your environment or not
