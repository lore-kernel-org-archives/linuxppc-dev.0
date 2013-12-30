Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0BB9F2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 14:14:42 +1100 (EST)
Message-ID: <1388373200.4373.25.camel@pasglop>
Subject: Re: commit e38c0a1f breaks powerpc boards with uli1575 chip
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Date: Mon, 30 Dec 2013 14:13:20 +1100
In-Reply-To: <201312190842.02702@blacky.localdomain>
References: <201312171135.38576@blacky.localdomain>
 <52B1EC15.5070606@gmail.com> <201312190842.02702@blacky.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Dmitry Krivoschekov <dkrivoschokov@dev.rtsoft.ru>,
 Alexey Lugovskoy <lugovskoy@dev.rtsoft.ru>,
 Thierry Reding <thierry.reding@avionic-design.de>,
 linux-kernel@vger.kernel.org, Rob Herring <robherring2@gmail.com>,
 Grant Likely <grant.likely@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-12-19 at 08:42 +0400, Nikita Yushchenko wrote:
> No, this does not help.
> 
> I've dumped the actual content of 'range' and 'addr' at the failure
> point 
> (i.e. ar point that returns error with e38c0a1f but passes without 
> e38c0a1f ):
> 
> OF: default map, cp=0, s=10000, da=70
> range:  01 00 00 00 00 00 00 00 00 00 00 00
>  addr:  00 00 00 00 00 00 00 00 00 00 00 70

Something that has a #address-cells larger than 2, or more generally,
an address field that contains more than a single number, must have
a specific translation backend, like we have for PCI.

This is a bit annoying but originates from the original OFW stuff on
which this stuff is based where the bus node would provide the methods
for translation.

Cheers,
Ben.
 
