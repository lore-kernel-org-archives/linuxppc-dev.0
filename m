Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9979C2C02B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 15:44:33 +1000 (EST)
Message-ID: <1370497454.3766.267.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: Improve device hotplug initialization
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 06 Jun 2013 15:44:14 +1000
In-Reply-To: <20130606052508.GA1901@roeck-us.net>
References: <1369762514-27352-1-git-send-email-linux@roeck-us.net>
 <51A5CAC1.6030800@freescale.com> <20130531051423.GA15505@roeck-us.net>
 <1369979047.3928.112.camel@pasglop> <20130601135809.GA6395@roeck-us.net>
 <1370480404.3766.260.camel@pasglop> <20130606052508.GA1901@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yuanquan Chen <Yuanquan.Chen@freescale.com>,
 Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Chen Yuanquan-B41889 <B41889@freescale.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 22:25 -0700, Guenter Roeck wrote:
> 
> 
> Can you point me to some of the breaking code ? I guess it must be in some of
> the pci_dma_dev_setup callbacks, but those I looked at only check devicetree
> data or simply set function pointers, both of which should not be affected by
> the call order.
> 
> How about pcibios_fixup_device, to be called after pcibios_fixup_bus ?

Mostly the pseries ones from a cursory glance. They could be improved to
be agnostic to the call order I suppose or simply done better but heh...

I like using pcibios_add though ... we just need to figure out how to
sort out that ordering if possible.

Cheers,
Ben.
