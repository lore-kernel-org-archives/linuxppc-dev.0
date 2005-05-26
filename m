Return-Path: <mgreer@mvista.com>
Message-ID: <429631CC.6000606@mvista.com>
Date: Thu, 26 May 2005 13:30:04 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1117000809.6395.92.camel@gaston>	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>	<1117004659.6395.103.camel@gaston>	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>	<1117057460.5076.19.camel@gaston>	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
	<1117089669.9076.105.camel@gaston>
In-Reply-To: <1117089669.9076.105.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> - There is _one_ important point to keep in mind, but that has always
>been true: None of this work before MMU_init(), 
>  
>

This is very true and raises a couple issues that we should fix while 
we're at it:

1) There are progress calls in MMU_init which will try to access the 
uart before its possible to create a mapping to the uart's regs 
(assuming you don't make a hack to map them and that you set up 
ppc_md.progress in your platform_init routine).  We should either get 
rid of those calls in MMU_init, provide an acceptable way to make 
temporary pre-MMU_init mappings, or make sure nobody sets up 
ppc_md.progress until ioremap is working (and also get rid of the calls 
in MMU_init b/c they're never used).

2) Some firmwares don't provide any info on how much memory is in the 
system but MMU_init needs to know that.  So the platform code has to 
read the SPD from the mem sticks via i2c, read the mem ctlr, or read a 
board reg that has the info.  All of those require access to hw regs 
before or during MMU_init.  I should be able to get rid of this one by 
figuring out the amount of memory in the bootwrapper and passing it in 
to the kernel.  I am assuming that all the boards with this problem use 
the bootwrapper.  I think that's a safe assumption but I'll have to verify.

BTW, these are the reasons that I made that set_bat hack that Dan is so 
fond of.  :)  I'll get rid of that hack but I need an answer to 1) first.

Mark
