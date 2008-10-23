Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.237])
	by ozlabs.org (Postfix) with ESMTP id D38EADDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Oct 2008 15:17:16 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so136621rvb.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Oct 2008 21:17:15 -0700 (PDT)
Date: Wed, 22 Oct 2008 22:17:13 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Mirsad Vejseli <Vejseli@web.de>
Subject: Re: virtex 4 linux driver bus error
Message-ID: <20081023041713.GA7165@secretlab.ca>
References: <1695261910@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1695261910@web.de>
Sender: Grant Likely <glikely@secretlab.ca>
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

On Wed, Oct 22, 2008 at 02:10:12PM +0200, Mirsad Vejseli wrote:
> hello at all,
> 
> at the moment I use development board ML410 with montavistalinux. 
> 
> I have a problem, please help me! 
> 
> I try to write a linux-driver for writing or reading registers.
> I have a ace-file, which contents Linux and EDK-project with a component (IP-wizard) which is added on a PLB-bus.
> I also have a driver-construct which I can register (insmod driver.ko) into the linux-Kernel only if i do not use functions to write or read the bus (XIO_out32() or XIO_in32 ()  ). If I use this function after registering the driver I got an error.
> If I try to insert the modul with Insmod driver.ko I get a bus error!  
> 
> my driver is similar to http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021578.html
>  
> 
> her the two importent functions  of the driver:
> 

Try something like this:

#define REG_BASE 	(u32) XPAR_komponente_0_BASEADDR // defined in xparameters_ml41x.h 
#define REG_HIGH 	(u32) XPAR_komponente_0_HIGHADDR // defined in xparameters_ml41x.h 

#define reg0_upper	(u32) komponente_SLV_REG0_OFFSET // 32-bit register / defined in komponente.h
#define reg1_upper	(u32) komponente_SLV_REG1_OFFSET // 32-bit register / defined in komponente.h
#define reg2_upper	(u32) komponente_SLV_REG2_OFFSET // 32-bit register / defined in komponente.h

static int __init meintreiber_init(void)
{
	int rtn, upper;

	reg_remapped_address = (u32) ioremap(REG_BASE, REG_HIGH - REG_BASE + 1);
	if (!reg_remapped_address) {
		printk("error mapping registers\n");
		return -ENOMEM;
	}

	upper = in_be32(reg_mapped_address + reg1_upper);
	printk("Data in: %.8X\n", upper);
	return 0;
}
 

g.
