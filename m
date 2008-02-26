Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7B281DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 10:54:44 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1QNsf8L008423
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 18:54:41 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1QNsfHs254686
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 18:54:41 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1QNse81005109
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 18:54:41 -0500
Date: Tue, 26 Feb 2008 17:53:26 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH][OF] Add of_device_is_available function
Message-ID: <20080226175326.56b928b9@zod.rchland.ibm.com>
In-Reply-To: <20080226.144423.138965691.davem@davemloft.net>
References: <18371.54796.174623.988521@cargo.ozlabs.ibm.com>
	<20080226.133430.41760910.davem@davemloft.net>
	<1204062337.15052.160.camel@pasglop>
	<20080226.144423.138965691.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 26 Feb 2008 14:44:23 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Wed, 27 Feb 2008 08:45:37 +1100
> 
> > I doubt we do that. Properties that contain things like ranges, or "reg"
> > properties are expected to be of a size that is a multiple of
> > #size-cells/#address-cells and I'm not sure that won't break things here
> > or there if they suddenly get one more byte..
> > 
> > Or do you mean you/we are appending that-without- changing the length
> > field ?
> 
> Right, simply don't change the length field.  Put the zero byte
> at offset "length + 1"
> 
> It's stupid to validate NULL termination everywhere when we
> can make it an invariant in one spot.

I don't mind fixing up the function to use strncmp and checking for a 0
length from of_get_property.  However, I'm almost certain that other
places in the code have the same issue so what you're saying here seems
to make sense.

josh
