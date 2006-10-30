Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 28FF267C93
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Oct 2006 02:40:22 +1100 (EST)
Date: Mon, 30 Oct 2006 18:40:02 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: CPM2 SCC/SMC break handling broken
Message-ID: <20061030184002.35611755@vitb.ru.mvista.com>
In-Reply-To: <200610301623.51537.laurent.pinchart@tbox.biz>
References: <200610261002.44688.laurent.pinchart@tbox.biz>
	<200610271101.38911.laurent.pinchart@tbox.biz>
	<200610271620.23046.scop@digitel.com.br>
	<200610301623.51537.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 30 Oct 2006 16:23:51 +0100
Laurent Pinchart <laurent.pinchart@tbox.biz> wrote:

> Hi Ricardo,
> 
> > > > > I need to generate a break on a CPM2 SMC serial port (same issue with
> > > > > SCC serial ports).
> > > > >
> > > > > The tcsendbreak() man page states that the function should generate a
> > > > > break between 250ms and 500ms, but testing showed that the break is
> > > > > one character long (10 bits in 8N1 mode).
> > > >
> > > > [snip]
> > > >
> > > > > CPM_CR_STOP_TX is documented to generate a break of BRKCR characters.
> > > > > The BRKCR register is initialized to 1, so only 1 break character is
> > > > > sent, which won't last between 250ms and 500ms.
> > > >
> > > > [snip]
> > > >
> > > > > Could anyone think of a proper solution which would not disturb the
> > > > > other drivers too much ?
> > > >
> > > > Well, one could always set the BRKCR parameter to the maximum number of
> > > > break characters permitted by it's size, since the break condition will
> > > > anyway end as soon as the RESTART TX command is issued as a consequence
> > > > of the tty->driver->break_ctl(tty, 0) call. But I did not test this.
> > >
> > > That's a very good idea, but the documentation is a bit misleading here.
> > > I tested the CPM2 behaviour, and found out that the break will last BRKCR
> > > characters, even if a RESTART TX command is sent sooner.
> > >
> > > The user manual states
> > >
> > > "The SMC sends a programmable number of break characters according to
> > > BRKCR and reverts to idle or sends data if a RESTART TRANSMIT is issued
> > > before completion."
> > >
> > > I suppose they meant that, if a RESTART TX command is issued before
> > > completion of the break sequence, the SMC will send data at the end of
> > > the break sequence. This is at least the behaviour I noticed after trying
> > > your idea.
> >
> > Too bad.... :( One more good idea to the junk bin.
> >
> > Hmm, just a wild shot you can try, while you're at that: what about setting
> > BRKCR to zero and issuing another STOP TRANSMIT, just before the RESTART
> > TRANSMIT?
> 
> Wow, congratulations. I wouldn't have thought about that.
> 
> static void cpm_uart_break_ctl(struct uart_port *port, int break_state)
> {
>         struct uart_cpm_port *pinfo = (struct uart_cpm_port *)port;
>         int line = pinfo - cpm_uart_ports;
>         volatile u16 *brkcr = IS_SMC(pinfo) ? &pinfo->smcup->smc_brkcr
>                                 : &pinfo->sccup->scc_brkcr;
> 
>         pr_debug("CPM uart[%d]:break ctrl, break_state: %d\n", port->line,
>                 break_state);
> 
>         if (break_state)
>         {
>                 *brkcr = 32767;
>                 cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
>         }
>         else
>         {
>                 *brkcr = 0;
>                 cpm_line_cr_cmd(line, CPM_CR_STOP_TX);
>                 cpm_line_cr_cmd(line, CPM_CR_RESTART_TX);
>         }
> }
> 
> This is a bit hackish though, but it works and doesn't require any API 
> modification.
> 
> Vitaly, could you give me your opinion ?
I'm fine with this change. Can you provide a sorta more complete reference why it is required?
I understood in general, but as author, you can explain the reason more clear I beleive...


Thanks.
-V
