Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D912BDDEFB
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 14:50:16 +1100 (EST)
Subject: Re: [PATCH v2 1/4] Add platform support for AmigaOne
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090202213910.258290@gmx.net>
References: <20090202212139.69160@gmx.net>  <20090202213910.258290@gmx.net>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 14:50:07 +1100
Message-Id: <1233719407.16867.164.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> + hose->first_busno = bus_range ? bus_range[0] : 0;
> + hose->last_busno = bus_range ? bus_range[1] : 0xff;
> +
> + setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc, 0);

Minor in the context of amigaone but still... the above should come from
the device-tree... I suppose those are really just IO space addresses
cf8 and cfc, in which case, an option is to call that first:

> + /* Interpret the "ranges" property */
> + /* This also maps the I/O region and sets isa_io/mem_base */
> + pci_process_bridge_OF_ranges(hose, dev, 1);

And -then- use hose->io_resource.start + 0xcf8 / 0xcfc, the later can be
hard coded as they are pretty standard values.

Ben.
