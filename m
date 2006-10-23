Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 90E6E67BC9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Oct 2006 03:26:07 +1000 (EST)
Date: Mon, 23 Oct 2006 21:23:10 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Subject: Re: CPM2 (MPC8260) SMC problem. Please help.
Message-ID: <20061023212310.34ab6d70@vitb.ru.mvista.com>
In-Reply-To: <247D8ECE-79CC-4BA2-A902-D86802E50335@gmail.com>
References: <f20416350610230902y78bd6740qc34e407004d6d511@mail.gmail.com>
	<247D8ECE-79CC-4BA2-A902-D86802E50335@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[...]
> >>
> >> I think that should be walked along the cpm_uart driver, TX part  
> >> to see is sending stuff
> >> do not indicate any error in the CPM registers, or at least  
> >> discover exact track leading to the endless loop.
> >
> > HI. I'm new here, but I encounted a very similar problem late last  
> > week....
> >
> > Boris, I am willing to bet that your problem lies with the return
> > value from cpm_uart_tx_pump().  Here's the last few lines of that
> > function from 2.6.17 :
> > 693         if (uart_circ_empty(xmit)) {
> > 694                 cpm_uart_stop_tx(port);
> > 695                 return 0;
> > 696         }
> > 697
> > 698         return 1;
> > 699 }
> > Note that return value is 0 if there is no more data in the tty's
> > circular queue (uart_circ_empty() returns true)  This is the case when
> > you send a small packet.  It seems appropriate to turn off the
> > transmitter (cpm_uart_stop_tx()) in the general case, but the problem
> > is that you never turned on the transmitter in the first place.....you
> > called cpm_uart_tx_pump() from cpm_uart_start_tx() like so:
> > 195         if (cpm_uart_tx_pump(port) != 0) {
> > 196                 if (IS_SMC(pinfo)) {
> > 197                         smcp->smc_smcm |= SMCM_TX;
> > 198                         smcp->smc_smcmr |= SMCMR_TEN;
> > 199                 } else {
> > 200                         sccp->scc_sccm |= UART_SCCM_TX;
> > 201                         pinfo->sccp->scc_gsmrl |= SCC_GSMRL_ENT;
> > 202                 }
> > 203         }
> >
> > When you then attempt to close the port, you'll get stuck here, in
> > cpm_uart_shutdown():
> > 455                 /* Wait for all the BDs marked sent */
> > 456                 while(!cpm_uart_tx_empty(port)) {
> > 457                         set_current_state(TASK_UNINTERRUPTIBLE);
> > 458                         schedule_timeout(2);
> > 459                 }
> > Because the transmitter was never turned on, the bd will never be
> > processed by the CPM and cpm_uart_tx_empty() will always return false.
> >
> > Recommendation: Change the first block of code above to: "return
> > (count != 0);"  Now cpm_uart_tx_pump() will return true if data was
> > placed in a bd, instead of true when there is more data to be
> > processed later.  This code works for me - but there are folks on this
> > list who would have a better idea about possible side
> > effects........anyone?
> 
> Yes, sounds true.
> 
> Since I was responsible for that, hand me the brown paper bag...
> 
> /me wears it.
> 
> Please send me a patch to process it.
> 

Hey, not that rough :)

I used to add some bits and "cpm_uart_tx_empty() will always return false" is mine as well.

Greg: 
Patch/code snippet from working tree welcome, and I'll address it anyway since it looks like generic issue.

Thanks.
-- 
Sincerely, 
Vitaly
