From: hollis@austin.ibm.com
Date: Mon, 3 Dec 2001 16:46:16 -0600
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org, davidm@amberdata.demon.co.uk
Subject: Re: RFC: i8259.c & PCI int ack
Message-ID: <20011203164616.I421@austin.ibm.com>
References: <0112032237.AA11733@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0112032237.AA11733@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 03, 2001 at 02:37:56PM -0800, Michael Sokolov wrote:
> hollis@austin.ibm.com wrote:
>
> > - i8259_init now takes a 'long intack_addr', which on PReP is 0xbffffff0.
> >   For platforms that only poll, this argument is irrelevant and can be 0x0
> >
> > [...]
> >
> > If this is the right idea, I intend to change all 8259 users:
> > - ppc_md.get_irq = i8259_irq       ->   ppc_md.get_irq = i8259_poll
> > - i8259_init()                     ->   i8259_init(0x0)
> > - i8259_irq(smp_processor_id())    ->   i8259_poll()
>
> With this patch on platforms that only poll, your code will still do an
> ioremap on i8259_init's argument, even if it's 0. I'm not sure that is good.

Good point; fixed.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
