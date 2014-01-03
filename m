Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07CAD2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jan 2014 11:04:37 +1100 (EST)
Message-ID: <1388707457.11795.32.camel@snotra.buserror.net>
Subject: Re: commit e38c0a1f breaks powerpc boards with uli1575 chip
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 2 Jan 2014 18:04:17 -0600
In-Reply-To: <1388373200.4373.25.camel@pasglop>
References: <201312171135.38576@blacky.localdomain>
 <52B1EC15.5070606@gmail.com> <201312190842.02702@blacky.localdomain>
 <1388373200.4373.25.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Dmitry Krivoschekov <dkrivoschokov@dev.rtsoft.ru>,
 Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 linux-kernel@vger.kernel.org, Rob
 Herring <robherring2@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, Alexey Lugovskoy <lugovskoy@dev.rtsoft.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-12-30 at 14:13 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2013-12-19 at 08:42 +0400, Nikita Yushchenko wrote:
> > No, this does not help.
> > 
> > I've dumped the actual content of 'range' and 'addr' at the failure
> > point 
> > (i.e. ar point that returns error with e38c0a1f but passes without 
> > e38c0a1f ):
> > 
> > OF: default map, cp=0, s=10000, da=70
> > range:  01 00 00 00 00 00 00 00 00 00 00 00
> >  addr:  00 00 00 00 00 00 00 00 00 00 00 70
> 
> Something that has a #address-cells larger than 2, or more generally,
> an address field that contains more than a single number, must have
> a specific translation backend, like we have for PCI.
> 
> This is a bit annoying but originates from the original OFW stuff on
> which this stuff is based where the bus node would provide the methods
> for translation.

I can maybe see that for PCI which has a special encoding, but why is it
always needed?  E.g. if Freescale localbus had a 64-bit offset instead
of 32-bit, the child nodes would have 3 address cells, but
straightforward use of ranges would bring it down to 2 for the final
physical address.  Existing localbus nodes already have "an address
field that contains more than a single number"; it's just a simple
enough encoding that it works to treat it as if it were a single large
number.

-Scott
