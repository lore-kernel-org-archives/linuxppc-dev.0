Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DC0DDDEEC
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 11:42:21 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2S0gGEt023212
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:42:16 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2S0gGOH1089884
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:42:16 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2S0gGBn001474
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 20:42:16 -0400
Date: Thu, 27 Mar 2008 19:39:25 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] [POWERPC] 4xx: Create common ppc4xx_reset_system() in
	ppc4xx_soc.c
Message-ID: <20080327193925.2781a6e2@zod.rchland.ibm.com>
In-Reply-To: <20080327235618.GA16141@localhost.localdomain>
References: <1206629011-28821-1-git-send-email-sr@denx.de>
	<20080327235618.GA16141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Mar 2008 10:56:18 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Mar 27, 2008 at 03:43:31PM +0100, Stefan Roese wrote:
> > This patch creates a common system reset routine for all 40x and 44x
> > systems. Previously only a 44x routine existed. But since this system
> > reset via the debug control register is common for 40x and 44x let's
> > share this code for all those platforms in ppc4xx_soc.c.
> 
> Well... they're sort of common.  The source looks the same, but the
> SPR number of DBCR0 is different on 40x and 44x, which is a
> potentially serious gotcha.

Except that since 40x and 44x should never be built into the same
kernel.  So the #defines for DBCR0 should be picked correctly from
reg_booke.h.

I thought about that too, but I can't see where it will be an issue in
practice.

josh
