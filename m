Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id BE2E667CB6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Nov 2006 09:09:36 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1119219ugf
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 14:09:34 -0800 (PST)
Message-ID: <528646bc0611271409g27ec05a0m9d7149e55256d363@mail.gmail.com>
Date: Mon, 27 Nov 2006 15:09:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 4/9] [POWERPC] move Efika support files into platforms/52xx
In-Reply-To: <200611272256.44623.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1164662190802-git-send-email-grant.likely@secretlab.ca>
	<11646622073115-git-send-email-grant.likely@secretlab.ca>
	<11646622072999-git-send-email-grant.likely@secretlab.ca>
	<200611272256.44623.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/27/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 27 November 2006 22:16, Grant Likely wrote:
> > +#ifdef CONFIG_PCI
> > +/*
> > + * Access functions for PCI config space using RTAS calls.
> > + */
> > +static int rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
> > + int len, u32 * val)
> > +{
> > +struct pci_controller *hose = bus->sysdata;
> > +unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
> > + | (((bus->number - hose->first_busno) & 0xff) << 16)
> > + | (hose->index << 24);
> > +int ret = -1;
> > +int rval;
> > +
> > +rval = rtas_call(rtas_token("read-pci-config"), 2, 2, &ret, addr, len);
> > +*val = ret;
> > +return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
> > +}
> > +
> > +static int rtas_write_config(struct pci_bus *bus, unsigned int devfn,
> > + int offset, int len, u32 val)
> > +{
> > +struct pci_controller *hose = bus->sysdata;
> > +unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
> > + | (((bus->number - hose->first_busno) & 0xff) << 16)
> > + | (hose->index << 24);
> > +int rval;
> > +
> > +rval = rtas_call(rtas_token("write-pci-config"), 3, 1, NULL,
> > + addr, len, val);
> > +return rval ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
> > +}
> > +
>
> I know you're only moving this code, but shouldn't this really use the
> code from arch/powerpc/kernel/rtas_pci.c? If it doesn't work out of
> the box, I guess we should rather split out the pseries specific
> bits from it and make the common parts more generic.
>

Oh, probably.  :)  As you mentioned; because I'm just moving the code,
I certainly don't want to tackle that with this patch series.

The Efika code is still quite young (in fact the code in Paul's tree
isn't complete enough yet to boot), and it is being actively
developed.  Expect to see PCI rework in the future, but I don't know
if it will make the .20 merge window.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
