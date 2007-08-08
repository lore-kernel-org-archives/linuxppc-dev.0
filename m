Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6063ADDE07
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 07:29:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l78KNPjg016011
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 16:23:25 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78LTriq156364
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 15:29:53 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78LTreO012384
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 15:29:53 -0600
Date: Wed, 8 Aug 2007 16:29:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: Fix small race in 44x tlbie function
Message-ID: <20070808162951.46491bc7@weaponx.rchland.ibm.com>
In-Reply-To: <f9d9td$nov$1@sea.gmane.org>
References: <20070807042050.GJ13522@localhost.localdomain>
	<f9d9td$nov$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 8 Aug 2007 20:43:25 +0000 (UTC)
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> On Tue, 07 Aug 2007 14:20:50 +1000, David Gibson wrote:
> > 
> > This patch fixes the problem in both arch/ppc and arch/powerpc by
> > inhibiting interrupts (even critical and debug interrupts) across the
> > relevant instructions.
> 
> How could a critical or debug interrupt modify the contents of MMUCR?

Interrupts from UICs can be configured as critical.  If one of those
triggers, (or any other CE triggers) and causes a tlb miss, you have a
race.  The watchdog timer interrupt also is a CE IIRC.

CE and DE are admittedly a much smaller race, but still possible.
Masking EE off is the largest one.

josh
