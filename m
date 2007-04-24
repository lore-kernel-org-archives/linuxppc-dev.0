Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 37914DDEE7
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 08:34:44 +1000 (EST)
Subject: Re: [PATCH] generic check_legacy_ioport
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070424112530.GA11489@aepfle.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070423081540.GA28244@aepfle.de>
	<1177376000.14873.38.camel@localhost.localdomain>
	<20070424112530.GA11489@aepfle.de>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 08:34:36 +1000
Message-Id: <1177454076.14873.128.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Do you think a device_type fdc, i8042 or ipmi will appear outside an isa
> node?

Well, if they do, I don't want that code to recognize them... I'm pretty
sure for example we have IPMI on QS21 blades and it's not on an ISA bus
and shouldn't match the legacy IO ports for example.

> > To be totally correct, we should -also- check if the port number fits in
> > the the actual "reg" property but I'm not sure I can be bothered :-)
> 
> Why all this complexity? Its there mainly to match a class of boards,
> not to match a specific device configuration.
> 
> Thats how it may look finally, currently only compile tested.
> 
> int check_legacy_ioport(unsigned long base_port)
> {
>         struct device_node *parent, *np = NULL;
>         int ret = -ENODEV;
> 
>         switch(base_port) {
>         case I8042_DATA_REG:
>                 np = of_find_node_by_type(NULL, "8042");
>                 break;
>         case FDC_BASE: /* FDC1 */
>                 np = of_find_node_by_type(NULL, "fdc");
>                 break;
>         case 0xca2:
>         case 0xca9:
>         case 0xe4:
>                 np = of_find_node_by_type(NULL, "ipmi");
>                 break;
> #ifdef CONFIG_PPC_PREP
>         case _PIDXR:
>         case _PNPWRP:
>         case PNPBIOS_BASE:
>                 /* implement me */
> #endif
>         default:
>                 break;
>         }
>         if (np) {

Why not just

	if (np == NULL)
		return -ENODEV;

And save some tabs ? :-)

>                 parent = of_get_parent(np);
>                 if (parent) {
>                         ret = strcmp(parent->type, "isa");
>                         of_node_put(parent);
>                 }
>                 of_node_put(np);
>         }
>         return ret;
> }

Looks good except maybe

	ret = strcmp(parent->type, "isa");

should probably be

	ret = strcmp(parent->type, "isa") ? -ENODEV : 0;

Cheers,
Ben.
