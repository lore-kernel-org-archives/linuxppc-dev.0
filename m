Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0C15CDDEE1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 23:09:30 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 04 Feb 2009 13:09:28 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1233719407.16867.164.camel@pasglop>
Message-ID: <20090204120928.102380@gmx.net>
MIME-Version: 1.0
References: <20090202212139.69160@gmx.net>  <20090202213910.258290@gmx.net>
	<1233719407.16867.164.camel@pasglop>
Subject: Re: [PATCH v2 1/4] Add platform support for AmigaOne
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 04 Feb 2009 14:50:07 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev list <linuxppc-dev@ozlabs.org>
> Betreff: Re: [PATCH v2 1/4] Add platform support for AmigaOne

> > + hose->first_busno = bus_range ? bus_range[0] : 0;
> > + hose->last_busno = bus_range ? bus_range[1] : 0xff;
> > +
> > + setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);
> 
> Minor in the context of amigaone but still... the above should come from
> the device-tree... I suppose those are really just IO space addresses
> cf8 and cfc, in which case, an option is to call that first:
I agree that these addresses should come from the device-tree, but these
two config registers are not located within the normal PCI I/O address
space (0xfe000000-0xfec00000).
Maybe I should add a "reg" property to the PHB node, but I don't know if
this is the right approach. The OF PCI spec isn't very clear about this.
What do you think?

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
