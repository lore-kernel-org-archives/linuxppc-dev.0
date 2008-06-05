Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14E34DE7F6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 02:52:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m55Gqa0L012292
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 09:52:37 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m55GqZ50020054
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Jun 2008 11:52:36 -0500 (CDT)
Date: Thu, 5 Jun 2008 11:52:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: inline assembly
Message-ID: <20080605165235.GE4150@ld0162-tx32.am.freescale.net>
References: <4846F0C0.80808@freescale.com> <4846EEAE.3000908@hypersurf.com>
	<11849.1212662691@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11849.1212662691@redhat.com>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 05, 2008 at 11:44:51AM +0100, David Howells wrote:
> Scott Wood <scottwood@freescale.com> wrote:
> 
> > int tmp;
> > 
> > asm volatile("addi %1, %2, -1;"
> >              "andc %1, %2, %1;"
> >              "cntlzw %1, %1;"
> >              "subfic %0, %1, 31" : "=r" (j), "=&r" (tmp) : "r" (i));
> 
> Registers are usually assumed to be 'long' in size, so I'd recommend using
> that rather than 'int' for tmp, though I suspect it'll make little difference
> (except, perhaps on x86 where you can partially use registers).

I had originally written that as long, but I changed it since the asm
code is explicitly assuming 32-bit.  It's more documentation than
anything else.

-Scott
