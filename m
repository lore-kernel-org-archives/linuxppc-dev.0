Return-Path: <blofeldus@yahoo.com>
Received: from web53504.mail.re2.yahoo.com (web53504.mail.re2.yahoo.com
	[206.190.37.65]) by ozlabs.org (Postfix) with SMTP id CFA19DDF2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 13:18:06 +1000 (EST)
Date: Fri, 22 Aug 2008 20:11:23 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
To: Wolfram Sang <w.sang@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <957941.2462.qm@web53504.mail.re2.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

----- Original Message ----

> From: Wolfram Sang <w.sang@pengutronix.de>
> To: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxppc-embedded@ozlabs.org
> Sent: Monday, August 18, 2008 9:18:31 AM
> Subject: [PATCH V2] MPC52XX: Don't touch pipelining for MPC5200B
> 
> 
> MPC5200 needs to have pipelining disabled for ATA to work. MPC5200B does not.
> So, for the latter, don't touch the original setting from the bootloader.
> 
> Signed-off-by: Wolfram Sang 
> ---
> Hello Arnd,
> 
> On Mon, Aug 18, 2008 at 12:49:36PM +0200, Arnd Bergmann wrote:
> 
> > Please make this a run-time conditional instead of compile-time.
> Like this?
> 
> ..................................................................
> 
> This needs some testing IMHO. Most configs in U-Boot tend to enable pipelining,
> which then used to be disabled by the kernel. So, on the one hand, this change
> would enable what is originally wanted; on the other hand, systems may run
> under a new configuration and need to be checked for regressions. Especially as
> there can be puzzling effects, like for one setup here, FEC only works reliably
> with pipelining enabled.
> 
> arch/powerpc/platforms/52xx/mpc52xx_common.c |    7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
> ===================================================================
> --- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
> +++ arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -99,11 +99,14 @@
>     out_be32(&xlb->master_pri_enable, 0xff);
>     out_be32(&xlb->master_priority, 0x11111111);
> 
> -    /* Disable XLB pipelining
> +    /*
> +     * Disable XLB pipelining
>      * (cfr errate 292. We could do this only just before ATA PIO
>      *  transaction and re-enable it afterwards ...)
> +     * Not needed on MPC5200B.
>      */
> -    out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
> +    if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR)
> +        out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
> 
>     iounmap(xlb);
> }
> 
> -- 
>   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
> Pengutronix - Linux Solutions for Science and Industry


Hi
 Since this bug is ATA specific, shouldn't this code be conditioned by CONFIG_IDE ?

Thanks
-roger


      
