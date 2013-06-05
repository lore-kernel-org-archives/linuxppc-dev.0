Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C15BD2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 08:38:25 +1000 (EST)
Message-ID: <1370471891.3766.244.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: check the bus address instead of resource
 address in pcibios_fixup_resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 06 Jun 2013 08:38:11 +1000
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B726F@saturn3.aculab.com>
References: <1370435211-6929-1-git-send-email-haokexin@gmail.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B726F@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 14:10 +0100, David Laight wrote:
> > If a BAR has the value of 0, we would assume that it is unset yet and
> > then mark the resource as unset and would reassign it later.
> 
> IIRC the PCI spec allows a BAR address of zero.
> Certainly some sparc systems have assigned 0 to a BAR.
> So assuming a BAR of 0 means it is unset may not be
> true for all systems.

Yes, look at the code and the comment above :-) It tries to make a
guess... which so far has worked well for us.

Note that people assigning 0 to BARs are asking for trouble anyway.

Cheers,
Ben.
