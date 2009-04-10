Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15830DDF9F
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Apr 2009 07:51:41 +1000 (EST)
Date: Fri, 10 Apr 2009 14:47:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Jeff Haran" <jharan@Brocade.COM>
Subject: Re: bug in drivers/edac/mpc85xx_edac.c:mpc85xx_mc_check() ?
Message-Id: <20090410144715.0fa5939e.akpm@linux-foundation.org>
In-Reply-To: <57AC2FA1761300418C7AB8F3EA493C9702C5F200@HQ-EXCH-5.corp.brocade.com>
References: <57AC2FA1761300418C7AB8F3EA493C9702C5F200@HQ-EXCH-5.corp.brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Dave Jiang <djiang@mvista.com>,
	linux-kernel@vger.kernel.org, Doug Thompson <dougthompson@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(cc's added)

On Wed, 8 Apr 2009 14:57:42 -0700
"Jeff Haran" <jharan@Brocade.COM> wrote:

> Hi,
> 
> Recent versions of this function start off with:
> 
> static void mpc85xx_mc_check(struct mem_ctl_info *mci)
> {
>     struct mpc85xx_mc_pdata *pdata = mci->pvt_info;
>     ...
> 
>     err_detect = in_be32(pdata->mc_vbase + MPC85XX_MC_ERR_DETECT);
>     if (err_detect)
>         return;
> 
>     ...
> }
> 
> My reading of the Freescale 8548E Manual leads me to conclude that the
> Memory Error Detect register (ERR_DETECT) will have various bits set if
> the memory controller has detected an error since the last time it was
> cleared. If no memory error has occurred, the register will contain 0.
> 
> Perhaps I am missing something very basic, but it seem to me that the
> above "if" should be:
> 
>     if (!err_detect)
>         return;
> 
> as the existing code would seem to read "if any errors have occurred,
> ignore them", though perhaps testing has demonstrated that the Freescale
> manual is in error.
> 
> Please include this email address in responses as I do not subscribe.
> 
> Thanks,
> 
> Jeff Haran
> Brocade
