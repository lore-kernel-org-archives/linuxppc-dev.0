Return-Path: <jjboor@aimsys.nl>
Received: from linserv001.aimsys.nl (a80-127-156-242.adsl.xs4all.nl
	[80.127.156.242])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3F2567A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Feb 2005 02:11:16 +1100 (EST)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Per Hallsmark <per.hallsmark@t2data.se>
In-Reply-To: <41FFBC75@webmail>
References: <41FFBC75@webmail>
Content-Type: text/plain
Message-Id: <1107442436.32038.30.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Thu, 03 Feb 2005 15:53:56 +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Question about cpm reset on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-02-03 at 15:29, Per Hallsmark wrote:
> Hi all,
> 
> Working with a board using hdlc over SCC channel (852T) and kernel 2.4.21,
> in the cpm reset code in arch/ppc/8xx_io/commproc.c it's like:
> 
> void
> m8xx_cpm_reset()
> {
>         volatile immap_t         *imp;
>         volatile cpm8xx_t       *commproc;
>         pte_t                   *pte;
> 
> 
>         imp = (immap_t *)IMAP_ADDR;
>         commproc = (cpm8xx_t *)&imp->im_cpm;
> 
>  
> #ifdef CONFIG_UCODE_PATCH
>         /* Perform a reset.
>         */
>         commproc->cp_cpcr = (CPM_CR_RST | CPM_CR_FLG);
> 
> 
>         /* Wait for it.
>         */
>         while (commproc->cp_cpcr & CPM_CR_FLG);
> 
> 
>         cpm_load_patch(imp);
> #endif
>      .......
> 
> In our case, CONFIG_UCODE_PATCH is not defined so the commproc is never
> reseted during reboot. Could it be that the #ifdef CONFIG_UCODE_PATCH
> should just be around the cpm_load_patch command?

It seems the author wants to reset the cpm only when microcode 
patches are needed. 

m8260_cpm_reset() does also not reset the cpm.

I don't know why (e.g. the console is setup after this)

Jaap-Jan

> The CONFIG_UCODE_PATCH seems to point this to be i2c/spi patch, but
> shouldn't a reset go to cpm in anycase?
> 
> /Per
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
