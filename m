Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5A3EB6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 07:59:28 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path
	for PTE_64BIT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20100923153347.4b517105@udp111988uds.am.freescale.net>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
	<20100923153347.4b517105@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 07:59:17 +1000
Message-ID: <1285279157.5158.17.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-23 at 15:33 -0500, Scott Wood wrote:
> I don't see a generic accessor that can test PTE flags for user
> access -- in the absence of one, I guess we need an ifdef here.  Or at
> least put in a comment so anyone who adds a userspace use knows they
> need to fix it. 

We could make up one in powerpc arch at least

#define pte_user(val) ((val & _PAGE_USER) == _PAGE_USER)

would do

Cheers,
Ben.
