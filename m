Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 49903DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 20:56:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4MAuInE027583
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 03:56:19 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4MAuHav018138
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 05:56:18 -0500 (CDT)
Subject: Re: fsl booke MM vs. SMP questions
From: Dave Liu <r63238@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1179803367.32247.785.camel@localhost.localdomain>
References: <1179731215.32247.659.camel@localhost.localdomain>
	<1179741447.3660.7.camel@localhost.localdomain>
	<1179742083.32247.689.camel@localhost.localdomain>
	<1179747448.3660.22.camel@localhost.localdomain>
	<1179785273.32247.742.camel@localhost.localdomain>
	<1179803367.32247.785.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 22 May 2007 18:56:15 +0800
Message-Id: <1179831375.3827.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-22 at 13:09 +1000, Benjamin Herrenschmidt wrote:
> In the end, the best solution might still be to simply not do any of
> this and instead send an IPI on invalidations. That's the method used by
> most architectures in linux (if not all) that do software TLB load on
> SMP. Basically, the invalidate code path then does:
> 
> 	- Update the linux PTE
> 	- write barrier
> 	- send IPI interrupt to all CPUs in mm->cpu_vm_mask
> 	- local TLB flush
> 
> And the IPI does a local TLB flush on all affected CPUs.

How to avoid IPI interrupt missing if the IPI interrupt is edge-
triggered?

or How to make sure TLB flushed on the else all affected CPUs?

-d
