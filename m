Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0DF2B67C0A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 06:49:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 minyard@acm.org
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Date: Fri, 8 Dec 2006 20:49:01 +0100
References: <20061207172259.64168f8c@localhost>
	<20061207172445.2108cf43@localhost>
	<20061208185902.GA14675@localdomain>
In-Reply-To: <20061208185902.GA14675@localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612082049.02545.arnd@arndb.de>
Cc: Christian Krafft <krafft@de.ibm.com>,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 19:59, Corey Minyard wrote:

> 
> +       if (match->data) {
> +               dev_warn(&dev->dev, "unknown interface type\n");
> +               return -ENODEV;
> +       }
> +
> 
> What's this mean?  I don't understand the error.

The check is bogus and should be removed. The effect is that
only SI_KCS can work, all others will be rejected.

> +	info->io.regsize	= resource0.end - resource0.start + 1;
> +	info->io.regspacing	= resource1.start - resource0.start;
> 
> Are you sure this is a reliable way to check the register spacing and
> register size?  Register size means "how big is a register (8, 16, 32
> bits)".  Register spacing means (how many bytes are there between
> registers.  If you had two registers that were 8 bits and 4 bytes
> apart, for instance, I don't believe the above calculations would work.

Looks right to me. Assume these of properties

#address-cells: <1>
#size-cells: <1>
reg: <0x100> <1> <0x104> <1> /* start, length, start, length */

converting them to resources gives you

resource0 = { .start = 0x100, .end = 0x100, }
resource1 = { .start = 0x104, .end = 0x104, }

consequently, you end up with

info->io = {
	.regsize = 1,
	.regspacing = 4,
	.addr_data = 0x100,
};

which is exactly what you want.

> +static int ipmi_of_remove(struct of_device *dev)
> +{
> +	return 0;
> +}
> 
> With the newest IPMI patches (only in git right now), hot removal of
> interfaces is supported.  Is that what this is for?  If so, you can
> call cleanup_one_si() on the interface.

ok, great.

> Here's a new patch.  Can you test that unloading the module works
> correctly?

Christian has already gone home for the weekend, and I don't have
access to his machine, so testing will probably have to wait until
Monday.

> +static void __devinit of_find_bmc(void)
> +{
> +	of_register_platform_driver(&ipmi_of_platform_driver);
> +}
> +#endif /* CONFIG_PPC_OF */

I guess this function could also be removed entirely, it doesn't
add anything useful.

	Arnd <><
