Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8628ADDF59
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 21:05:10 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67B53YE012404
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 07:05:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67B53fd171466
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 05:05:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67B52dm019925
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2008 05:05:03 -0600
Date: Mon, 7 Jul 2008 07:01:24 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] [V2] powerpc: legacy_serial: reg-offset & shift aren't
	used
Message-ID: <20080707070124.73ba794f@zod.rchland.ibm.com>
In-Reply-To: <1215413228.8970.106.camel@pasglop>
References: <20080701175250.E0BA41CE804D@mail117-va3.bigfish.com>
	<1215413228.8970.106.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dwg@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 07 Jul 2008 16:47:08 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2008-07-01 at 10:52 -0700, John Linn wrote:
> > The legacy serial driver does not work with an 8250
> > type UART that uses reg-offset and reg-shift. This
> > change updates the driver so it doesn't find the UART
> > when those properties are present on the UART in the
> > device tree for soc devices.
> > 
> > Signed-off-by: John Linn <john.linn@xilinx.com>
> > Acked-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > V2
> > 
> > Corrected logic to use "||" rather than "&&".
> 
> I have some problems with this patch:
> 
>  - First if the properties are present but their value match the
> register layout of a standard UART, we will bail out... not nice.

Why would they be present in that case?

>  - Why don't we just implement support for the reg-shift and
> offset instead ?

Probably because the last time someone suggested that it spawned a
lengthy debate about what reg-offset/shift were supposed to do.

josh
