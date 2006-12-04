Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D2CF167BE8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Dec 2006 02:00:31 +1100 (EST)
Date: Mon, 4 Dec 2006 18:00:28 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: hs@denx.de
Subject: Re: Compile Error using SMC1 on a MPC8272 for 2.6.19-rc4
Message-ID: <20061204180028.2d2f5cf0@vitb.ru.mvista.com>
In-Reply-To: <1165234150.6011.77.camel@Zeus.EmbLux>
References: <1163159594.6319.56.camel@Zeus.EmbLux>
	<20061111001527.1274c7f4@localhost.localdomain>
	<1165234150.6011.77.camel@Zeus.EmbLux>
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

On Mon, 04 Dec 2006 13:09:10 +0100
Heiko Schocher <hs@denx.de> wrote:

> Hello Vitaly,
> 
> Am Samstag, den 11.11.2006, 00:15 +0300 schrieb Vitaly Bordug:
> > On Fri, 10 Nov 2006 12:53:14 +0100
> > Heiko Schocher wrote:
> > > I tried to compile the Linux Kernel 2.6.19-rc5 with a MPC8272 CPU and
> > > a console on SMC1, and get the following Compile Error:
> > > 
> > >   CC      drivers/serial/cpm_uart/cpm_uart_cpm2.o
> > > drivers/serial/cpm_uart/cpm_uart_cpm2.c: In function
> > > 'cpm_uart_init_portdesc':
> > > drivers/serial/cpm_uart/cpm_uart_cpm2.c:364: warning: assignment makes
> > > integer from pointer without a cast
> > > drivers/serial/cpm_uart/cpm_uart_cpm2.c:368: error: invalid type
> > > argument of 'unary *'
> > > make[3]: *** [drivers/serial/cpm_uart/cpm_uart_cpm2.o] Error 1
> > > make[2]: *** [drivers/serial/cpm_uart] Error 2
> > > make[1]: *** [drivers/serial] Error 2
> > > make: *** [drivers] Error 2
> > > 
> > > The following Code solves the problem:
> > > 
> > > diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> > > b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> > > index 0599030..bb0a6c1 100644
> > > --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> > > +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> > > @@ -349,7 +349,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
> > >  int cpm_uart_init_portdesc(void)
> > >  {
> > >  #if defined(CONFIG_SERIAL_CPM_SMC1) ||
> > > defined(CONFIG_SERIAL_CPM_SMC2)
> > > -	u32 addr;
> > > +	u32 *addr;
> > >  #endif
> > >  	pr_debug("CPM uart[-]:init portdesc\n");
> > >  
> > Yes, but that is not the only issue. I am working on that.
> 
> Yes, i think so too, because I tried the 2.6.19 Kernel on a board with
> MPC8272, SMC1-2 and SMCC1-4 used as serial port, SMC2 as Console, and
> it dont work ... with a 2.6.14er Kernel it worked ...
> 
> I had to change the following Code:
> ----------------------------------------------------------------------------
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> index bb0a6c1..4ee1bfc 100644
> @@ -349,7 +351,7 @@ void cpm_uart_freebuf(struct uart_cpm_po
>  int cpm_uart_init_portdesc(void)
>  {
>  #if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
> -	u32 *addr;
> +	u16 *addr;
>  #endif
>  	pr_debug("CPM uart[-]:init portdesc\n");
>  
> ----------------------------------------------------------------------------
> 
> With this change, Linux comes up, with SMC1-2 and SCC1-4 as serial port,
> and a console on SMC2 :-)
> 
> If I use the Plattform Bus:
> I have also to apply the patch from:
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-November/025101.html
> 
> to bring it up working.
> 
Thanks very much for these bits. I'm in process of finalizing PQ-related powerpc merge and fix-ups for what is 
currently in-tree so arch/ppc been left a bit aside. 

I'll send your patches together with my bunch and get them merged.

-- 
Sincerely, 
Vitaly
