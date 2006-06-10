Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F960679E6
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Jun 2006 08:05:09 +1000 (EST)
Subject: Re: pmf_register_irq_client gives sleep with locks held warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1149931638.3864.34.camel@johannes.berg>
References: <1149020341.5128.7.camel@johannes>
	<1149123574.15446.15.camel@localhost.localdomain>
	<1149793098.11525.34.camel@johannes>
	<1149897784.12687.87.camel@localhost.localdomain>
	<1149931638.3864.34.camel@johannes.berg>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 08:04:56 +1000
Message-Id: <1149977097.12687.144.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-06-10 at 11:27 +0200, Johannes Berg wrote:
> On Sat, 2006-06-10 at 10:03 +1000, Benjamin Herrenschmidt wrote:
> 
> > > I don't think your patch is right, it seems to me that now
> > > pmf_unregister_irq_client races against pmf_do_irq: what happens when an
> > > interrupt comes in right in the middle of the list_del()?
> > 
> > Yeah, possibly... too late for 2.6.17 tho.
> 
> That's ok, we don't have any in-kernel users anyway. Alas the alsa
> people will be dissatisfied because they like to ship new drivers for
> old kernels or something. Oh well, I don't care.

We still want people to build out-of-tree for 2.6.17 (please keep the
git there for that), as it will take a while before 2.6.18 is here.

The remaining possible bug in the pmf irq code is probably harmless in
99.99% of the cases in practice :)

Ben.
