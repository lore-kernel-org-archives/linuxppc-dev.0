Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 3A492DDEC9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:14:03 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/16] Port 44x MMU definitions to ARCH=powerpc
References: <20070213061024.B4A8CDDD0D@ozlabs.org>
	<1171347875.20192.63.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 13 Feb 2007 09:13:51 -0800
In-Reply-To: <1171347875.20192.63.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 13 Feb 2007 17:24:34 +1100")
Message-ID: <adafy9am14g.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > +typedef unsigned long long phys_addr_t;
 > > +extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);
 > > +#define PHYS_FMT	"%16Lx"
 > 
 > Do we still need that fixup code ? Since we now have full 64 bits
 > capable ioremap, we don't need to play tricks anymore. I'd rather get
 > rid of them completely.

Maybe make the fixup code print a warning when it actually changes an
address below 4G so we can track down all the places relying on this?

 - R.
