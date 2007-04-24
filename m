Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CD70BDDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 21:25:34 +1000 (EST)
Date: Tue, 24 Apr 2007 13:25:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] generic check_legacy_ioport
Message-ID: <20070424112530.GA11489@aepfle.de>
References: <20070417210745.GA3567@aepfle.de>
	<20070423081540.GA28244@aepfle.de>
	<1177376000.14873.38.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1177376000.14873.38.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 24, Benjamin Herrenschmidt wrote:

> Ok, I like the aproach, but why the heck those ifdef's ? Can't you just
> remove them ?

Just to keep it small for .configs without floppy, PS/2 etc. I can
remove it.

> > +	if (np) {
> > +		of_node_put(np);
> >  		return 0;
> 
> And also check now if the parent is "isa". Just to be sure. If a
> platform won't match that, then it will need it's own
> check_legacy_ioport which is fine with me.

Do you think a device_type fdc, i8042 or ipmi will appear outside an isa
node?

> To be totally correct, we should -also- check if the port number fits in
> the the actual "reg" property but I'm not sure I can be bothered :-)

Why all this complexity? Its there mainly to match a class of boards,
not to match a specific device configuration.

Thats how it may look finally, currently only compile tested.

int check_legacy_ioport(unsigned long base_port)
{
        struct device_node *parent, *np = NULL;
        int ret = -ENODEV;

        switch(base_port) {
        case I8042_DATA_REG:
                np = of_find_node_by_type(NULL, "8042");
                break;
        case FDC_BASE: /* FDC1 */
                np = of_find_node_by_type(NULL, "fdc");
                break;
        case 0xca2:
        case 0xca9:
        case 0xe4:
                np = of_find_node_by_type(NULL, "ipmi");
                break;
#ifdef CONFIG_PPC_PREP
        case _PIDXR:
        case _PNPWRP:
        case PNPBIOS_BASE:
                /* implement me */
#endif
        default:
                break;
        }
        if (np) {
                parent = of_get_parent(np);
                if (parent) {
                        ret = strcmp(parent->type, "isa");
                        of_node_put(parent);
                }
                of_node_put(np);
        }
        return ret;
}
