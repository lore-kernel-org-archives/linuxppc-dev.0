Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 168132C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 11:15:37 +1000 (EST)
Message-ID: <1378862123.3783.5.camel@pasglop>
Subject: Re: [RFC PATCH v2 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Wed, 11 Sep 2013 11:15:23 +1000
In-Reply-To: <1378856847.12204.380.camel@snotra.buserror.net>
References: <20130905055122.F256EE07B6@canberra.localdomain>
 <1378856847.12204.380.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Chivers <schivers@csc.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, cproctor@csc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-10 at 18:47 -0500, Scott Wood wrote:

> No blank line before }
> 
> > +CONFIG_CMDLINE_BOOL=y
> > +CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
> 
> I take it there's no way to pass a command line in from whatever loader
> this board uses... but you could put it in the dts instead.

No, please don't put that in the device-tree. Somebody might want
different settings, this is typically what .config is for.

> Did you ever figure out the problem with the combined defconfig?
> 
> > +	help
> > +          This option enables support for the Motorola (now Emerson) MVME5100
> > +	  board.
> 
> Whitespace
> 
> > +/* Board register addresses. */
> > +#define	BOARD_STATUS_REG	0xfef88080
> > +#define	BOARD_MODFAIL_REG	0xfef88090
> > +#define	BOARD_MODRST_REG	0xfef880a0
> > +#define	BOARD_TBEN_REG		0xfef880c0
> > +#define BOARD_SW_READ_REG	0xfef880e0
> > +#define	BOARD_GEO_ADDR_REG	0xfef880e8
> > +#define	BOARD_EXT_FEATURE1_REG	0xfef880f0
> > +#define	BOARD_EXT_FEATURE2_REG	0xfef88100
> 
> Use a space rather than a tab after #define.
> 
> > +static unsigned int pci_membase;
> 
> phys_addr_t
> 
> > +static void mvme5100_restart(char *cmd)
> > +{
> > +	u_char			*restart;
> 
> Is all that tabbing before "*restart" really necessary?
> 
> > +	restart = ioremap(BOARD_MODRST_REG, 4);
> > +	local_irq_disable();
> > +	mtmsr(mfmsr() | MSR_IP);
> > +
> > +	out_8((u_char *) restart, 0x01);
> 
> If ioremap() fails you'll panic here.
> 
> In any case, you should map things at boot time.
> 
> -Scott
> 
> 
