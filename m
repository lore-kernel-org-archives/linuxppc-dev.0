Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C4FADE06A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:09:25 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6LH9IWx024455
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:09:18 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6LH9Hol215608
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:09:17 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6LH9Hj9002748
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:09:17 -0400
Date: Mon, 21 Jul 2008 13:05:51 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: luisgpm@linux.vnet.ibm.com
Subject: Re: [RFC] 4xx hardware watchpoint support
Message-ID: <20080721130551.23a06006@zod.rchland.ibm.com>
In-Reply-To: <1216658194.5727.36.camel@gargoyle>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 13:36:33 -0300
Luis Machado <luisgpm@linux.vnet.ibm.com> wrote:

> 
> > This doesn't look right for how it's coded.  This would be the
> > CONFIG_4xx || CONFIG_BOOKE case, but CONFIG_4xx includes PowerPC 405.
> > That has a different bit layout among the DBCR registers.  Namely, on
> > 405 you would be clearing the TDE and IAC1 events because the DAC
> > events are in DBCR1, not DBCR0.
> 
> Maybe guarding the 405-specific parts in a separate "#if
> defined(CONFIG_40x)" block will do?

That, or adding a small function to move the bits to the appropriate
registers (set_dbcr or set_dac_events).

> Do you think it's worth to support this facility on 405's processors? If
> so, i'll gladly work on a solution to it.

I would think so.  There's really no difference from a userspace
perspective, so gdb watchpoints could be valuable there too.  I'll
leave it up to you though.

josh
