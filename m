Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142]) by ozlabs.org (Postfix) with ESMTP id 0C1D51007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 09:04:12 +1000 (EST)
Received: from mail68-db3 (localhost.localdomain [127.0.0.1])	by
	mail68-db3-R.bigfish.com (Postfix) with ESMTP id B04E216D051D	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2010 23:04:05 +0000 (UTC)
Received: from DB3EHSMHS012.bigfish.com (unknown [10.3.81.249])	by
	mail68-db3.bigfish.com (Postfix) with ESMTP id 54D3B6A004C	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2010 23:04:05 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GN42s7029639	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 16:04:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o8GN48XO005153	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 18:04:09 -0500 (CDT)
Date: Thu, 16 Sep 2010 18:04:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: linasvepstas@gmail.com
Subject: Re: [PATCH 01/15] ppc: fix return type of BUID_{HI,LO} macros
Message-ID: <20100916180401.5ff1fc5d@schlenkerla.am.freescale.net>
In-Reply-To: <AANLkTikHxiUQR2+Gao0sNn2mzVN-M=Z=+3Z3=7H7GJdK@mail.gmail.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<20100915181319.GB3683@us.ibm.com>
	<AANLkTikHxiUQR2+Gao0sNn2mzVN-M=Z=+3Z3=7H7GJdK@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Sep 2010 17:54:46 -0500
Linas Vepstas <linasvepstas@gmail.com> wrote:

> Acked-by: Linas Vepstas <linasvepstas@gmail.com>
> 
> I'm guessing this worked up til now because the rtas_call function prototype
> was telling compiler to cast these to 32-bit before passing them as args.
> (and since these would still get passed as one arg per 64-bit reg, it
> still wouldn't go wrong.)
> 
> What I'm wondering about is why there was no compiler warning about an
> implicit cast of a 64-bit int to a 32-bit int?  Surely, this is something that
> should be warned about!

-Wconversion enables this.

There'd be a lot of false positives to squash with that enabled --
and it might not be worth the resulting explosion in casts.

-Scott
