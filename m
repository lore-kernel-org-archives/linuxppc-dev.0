Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 68B1BDE04B
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 22:46:52 +1100 (EST)
Date: Thu, 10 Jan 2008 12:47:12 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: add phy-handle property for fec_mpc52xx
Message-ID: <20080110114712.GB20988@aepfle.de>
References: <20080109140608.GA15673@aepfle.de>
	<18309.33034.549240.640970@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <18309.33034.549240.640970@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 10, Paul Mackerras wrote:

> Olaf Hering writes:
> 
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -1487,6 +1487,34 @@ static void __init prom_find_mmu(void)
> >  	else if (strncmp(version, "FirmWorks,3.", 12) == 0) {
> >  		of_workarounds = OF_WA_CLAIM | OF_WA_LONGTRAIL;
> >  		call_prom("interpret", 1, 1, "dev /memory 0 to allow-reclaim");
> > +#ifdef CONFIG_PPC_MPC52xx
> > +	} else if (strcmp(version, "EFIKA5K2") == 0) {
> 
> Why have you added this stuff in prom_find_mmu rather than putting it
> in fixup_device_tree_efika()?

I just looked for a "model" check.
