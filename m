Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4DB3F67A79
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2006 17:32:58 +1000 (EST)
Subject: RE: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673066CF5BE@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673066CF5BE@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 17:32:44 +1000
Message-Id: <1149233565.16202.62.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> If I really need to use bat0 or bat1( I see that the general mmu use bat2 and bat3, 
> where should I set up them?
> 
> For tsi108 pci configuration access, I need to map 16Mbyte 
> physical address.  If I do not use an extra bat, I can not get the correct 
> virtual address use ioremap.

What do you mean ? An ioremap will work, it will give you any virtual
address, you just have to store that in a global instead of hard coding
it. Hard coded virtual addresses are bad. Especially for things like PCI
config space that really isn't performance sensitive.

Ben.
