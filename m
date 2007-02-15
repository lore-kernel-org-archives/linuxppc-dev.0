Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id D8B38DDEC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Feb 2007 03:33:59 +1100 (EST)
Date: Thu, 15 Feb 2007 19:33:55 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: hs@denx.de
Subject: Re: Moving from arch/ppc to arch/powerpc with an MPC8248 (part 1)
Message-ID: <20070215193355.78e3fcd7@localhost.localdomain>
In-Reply-To: <1171543423.5935.14.camel@Apollo>
References: <1171543423.5935.14.camel@Apollo>
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

On Thu, 15 Feb 2007 13:43:43 +0100
Heiko Schocher wrote:

> Hello Laurent, Vitaly
> 
> >> Are you using up-to-date powerpc.git? I get rid of hardcoded
> CPM_MAP_ADDR
> >> completely (or it should be such, heh). please make sure you have
> >> my recent
> 
> I found two more in arch/powerpc/sysdev/cpm2_common.c (in actual
> powerpc.git Tree):
> 
> diff --git a/arch/powerpc/sysdev/cpm2_common.c
> b/arch/powerpc/sysdev/cpm2_common.c index ec26599..2159895 100644
> --- a/arch/powerpc/sysdev/cpm2_common.c
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -60,7 +60,7 @@ intctl_cpm2_t *cpm2_intctl;
>  void
>  cpm2_reset(void)
>  {
> -	cpm2_immr = (cpm2_map_t *)ioremap(CPM_MAP_ADDR,
> CPM_MAP_SIZE);
> +	cpm2_immr = (cpm2_map_t *) ioremap(get_immrbase(),
> CPM_MAP_SIZE); cpm2_intctl = cpm2_map(im_intctl);
>  
>  	/* Reclaim the DP memory for our use.
> @@ -234,7 +234,7 @@ static void cpm2_dpinit(void)
>  {
>  	spin_lock_init(&cpm_dpmem_lock);
>  
> -	im_dprambase = ioremap(CPM_MAP_ADDR, CPM_DATAONLY_BASE +
> CPM_DATAONLY_SIZE);
> +	im_dprambase = (u8 *) ioremap(get_immrbase(),
> CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE); 
>  	/* initialize the info header */
>  	rh_init(&cpm_dpmem_info, 1,
> 
> 

Those exist in my local tree - missed the resubmit I guess. Will fix.

> >> commits in.
> >
> > I'm using up-to-date linux-2.6.git, which is probably way old
> > compared to posuch werpc.git :-) What's the powerpc.git URL ? Do
> > you plan to push your changes upstream for 2.6.21 ?
> 
> I think you find the powerpc.git at
> http://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git/
> 
> Am I right?
> 
yep. :)
> I also "playing" at the moment to port a running mpc8272 base port
> under arch/ppc to arch/powerpc, but I cant say, when I am finishing
> it ...
> 
it is completed and works for me - I even checked in the defconfig.

> When I compile the Tree I got a compilererror in
> drivers/serial/cpm_uart/cpm_uart_cpm2.c, because I have a SMC as a
> console. I fixed it with the following patch:
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> index 787a8f1..5a36ad2 100644
> --- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
> @@ -285,7 +285,7 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
>  int __init cpm_uart_init_portdesc(void)
>  {
>  #if defined(CONFIG_SERIAL_CPM_SMC1) ||
> defined(CONFIG_SERIAL_CPM_SMC2)
> -	u32 addr;
> +	u16* addr;
>  #endif
>  	pr_debug("CPM uart[-]:init portdesc\n");
>
Well, those init_portdesc should not be toggled in normal case - all should come through platform devices (done by device tree traversal for now since we need to keep the compatibility with ppc stuff)
  
