Return-Path: <dan@embeddededge.com>
In-Reply-To: <20051114124538.GB28633@logos.cnet>
References: <20051114124538.GB28633@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7af23fbbbf8b4b765f4d6c19f637011f@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 14 Nov 2005 14:06:39 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-dev <linuxppc-dev@ozlabs.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PLEASE REVIEW] ppc32 8xx: core PRxK board family support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 14, 2005, at 7:45 AM, Marcelo Tosatti wrote:

> +++ linux-2.6.14-rc4/arch/ppc/boot/include/cyc_banner.h	2005-10-25 
> 07:01:57.000000000 -0500

I'm not a big fan of all of these banners, printing, and ascii
text in the kernel, but if you think you must have it ........

> +//XXX: remove? Its unused.
> +#if 0
> +struct type0000 {
> +    unsigned char	flash_sign[FLASH_SIGN_SIZE];    /* mark initialized 
> CMOS */
> +    unsigned char	version;            /* Configure vector version */
> +    unsigned char	routing_protocol;   /* RIP, OSPF, etc */
> +    unsigned char	save_sw;            /* TRUE : the RTBOOT must be 
> saved into flash */
> +};
> +#endif

Yes please, remove it.

> +    //[GB]May/06/05  Ethernet Receive Rate Limit
> +    // unsigned char    reserved1[4];

Get rid of trash like this, too, or make it a real C style comment
that explains what is going on here for the rest of us.

> +++ linux-2.6.14-rc4/arch/ppc/boot/simple/embed_config.c	2005-10-25 
> 13:55:04.000000000 -0500

This is a pretty big chunk of board specific code beyond just setting
up the board configuration info.  Consider making it a separate file.

> +++ linux-2.6.14-rc4/arch/ppc/platforms/cpld.h	2005-10-24 
> 15:35:25.000000000 -0500

Would you name this something a little more descriptive, like
perhaps cyc_cpld.h?  Makes it easier to understand where the
files are used.

> +struct fpga_pc_regs {
> +	unsigned char fpga_pc_misc;	// Controls PCMCIA IO's window size

I still don't like // comments ....... :-)

> +//	mem_addr = (unsigned long *)(&cpmp->cp_dpmem[dp_addr]);

Just remove it.

> +//	dp_addr = m8xx_cpm_dpalloc(32);

Ditto, and anywhere else.  If code isn't used, let's just get
rid of it.  Or put in a comment why there may be alternative
or if you are testing something.

Thanks!


	-- Dan
