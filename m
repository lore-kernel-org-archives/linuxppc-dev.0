Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140]) by ozlabs.org (Postfix) with ESMTP id 862A0B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 01:07:53 +1000 (EST)
Received: from mail21-db3 (localhost.localdomain [127.0.0.1])	by
	mail21-db3-R.bigfish.com (Postfix) with ESMTP id 3CBAAB08347	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:17:54 +0000 (UTC)
Received: from DB3EHSMHS011.bigfish.com (unknown [10.3.81.252])	by
	mail21-db3.bigfish.com (Postfix) with ESMTP id 11EE934804C	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 24 Sep 2010 15:17:54 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8OF7beI012559	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:07:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8OF7bXH023163	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 10:07:37 -0500 (CDT)
Date: Fri, 24 Sep 2010 10:07:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
	Device Tree
Message-ID: <20100924100735.47b49580@udp111988uds.am.freescale.net>
In-Reply-To: <20100924071006.GA21318@angua.secretlab.ca>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
	<20100924071006.GA21318@angua.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: christophe leroy <christophe.leroy@c-s.fr>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net,
	Anton Vorontsov <avorontsov@ru.mvista.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Sep 2010 01:10:06 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Sep 16, 2010 at 09:05:03AM +0200, christophe leroy wrote:
> > This patch applies to 2.6.34.7 and 2.6.35.4
> > It fixes an issue during the probe for CPM1 with definition of parameter ram from DTS
> > 
> > Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>
> 
> I'm sorry, I don't understand the fix from the given description.
> What is the problem, and why is cpm_muram_alloc_fixed() the wrong
> thing to call on CPM1?  Does CPM2 still need it?

I don't see how cpm_muram_alloc_fixed() can be used safely at all.  If
you need a fixed address, it shouldn't be part of the general
allocation pool, or something else might get it first.

-Scott
