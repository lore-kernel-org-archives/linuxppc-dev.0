Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D31B1B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 May 2011 01:16:00 +1000 (EST)
Message-ID: <4DD533DE.1020705@freescale.com>
Date: Thu, 19 May 2011 10:14:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 6/7] tty/powerpc: introduce the ePAPR embedded hypervisor
	byte channel driver
References: <1305813272-31826-1-git-send-email-timur@freescale.com>	<1305813272-31826-7-git-send-email-timur@freescale.com>
	<20110519153358.5876f310@lxorguk.ukuu.org.uk>
In-Reply-To: <20110519153358.5876f310@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
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

Alan Cox wrote:
> ttys = tty_port_tty_get(&bc->port);
> stuff
> if (ttys != NULL)
> 	tty stuff
> 	tty_kref_put(ttys);

Under what circumstances can ttys be NULL?  I currently only use this code in
the RX and TX interrupt handlers, which are both enabled in the
tty_port_operations.activate() function.

Is this right for the TX handler:

static irqreturn_t ehv_bc_tty_tx_isr(int irq, void *data)
{
	struct ehv_bc_data *bc = data;
	struct tty_struct *ttys = tty_port_tty_get(&bc->port);

	ehv_bc_tx_dequeue(bc);
	if (ttys) {
		tty_wakeup(ttys);
		tty_kref_put(ttys);
	}

	return IRQ_HANDLED;
}

I just want to make sure that testing for NULL is really necessary in my
interrupt handlers.

>> > +		len = min_t(unsigned int,
>> > +			    CIRC_CNT_TO_END(bc->head, bc->tail, BUF_SIZE),
>> > +			    EV_BYTE_CHANNEL_MAX_BYTES);
> The kfifo API is probably faster and cleaner. Much of tty still uses
> CIRC_* because they predate the new APIs.

Ok, I'll change it.

> You really also need a hangup method so vhangup() does the right thing
> and you can securely do logins etc and sessions on your console. As
> you've got no hardware entangled in this and you already use tty_port
> helpers the hangup helper will do the work for you.

Ok.

> 
> I guess the only other thing to consider is whether you want to implement
> a SYSRQ interface on your console ?

I don't think byte channels can support SYSRQ, but I'll look into it.

-- 
Timur Tabi
Linux kernel developer at Freescale
