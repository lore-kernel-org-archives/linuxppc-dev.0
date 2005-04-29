Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70771679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 04:21:44 +1000 (EST)
Date: Fri, 29 Apr 2005 10:56:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Porter <mporter@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Kumar Gala <kumar.gala@freescale.com>, linuxppc-embedded@ozlabs.org
Message-ID: <20050429135648.GA5496@logos.cnet>
References: <20050426184828.GA22714@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050426184828.GA22714@gate.ebshome.net>
Subject: Re: [PATCH] ppc32: backport Book-E decrementer handling fix from 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Apr 26, 2005 at 11:48:28AM -0700, Eugene Surovegin wrote:
> Marcelo,
> 
> this is backport of Matt Porter's patch for Book-E decrementer 
> handling in timer_interrupt. 
> 
> The fix has been in 2.6 from August but never made it to 2.4, and I 
> re-discovered this fix last week :)
> 
> Original Matt's post to linuxppc-dev with explanation can be found at:
> http://ozlabs.org/pipermail/linuxppc-dev/2004-August/017458.html

Applied, thanks. 

> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> 
> ===== arch/ppc/kernel/time.c 1.16 vs edited =====
> --- 1.16/arch/ppc/kernel/time.c	2003-07-03 09:56:34 -07:00
> +++ edited/arch/ppc/kernel/time.c	2005-04-26 11:37:58 -07:00
> @@ -150,7 +150,7 @@
>  
>  	hardirq_enter(cpu);
>  
> -	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) < 0) {
> +	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
>  		jiffy_stamp += tb_ticks_per_jiffy;
>  		if (!user_mode(regs))
>  			ppc_do_profile(instruction_pointer(regs));
