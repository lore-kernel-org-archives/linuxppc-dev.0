Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E394DDEE3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 08:46:13 +1100 (EST)
Subject: Re: [PATCH][OF] Add of_device_is_available function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080226.133430.41760910.davem@davemloft.net>
References: <20080223185904.757c2884@zod.rchland.ibm.com>
	<20080223202357.20a12b84@zod.rchland.ibm.com>
	<18371.54796.174623.988521@cargo.ozlabs.ibm.com>
	<20080226.133430.41760910.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 27 Feb 2008 08:45:37 +1100
Message-Id: <1204062337.15052.160.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-26 at 13:34 -0800, David Miller wrote:
> From: Paul Mackerras <paulus@samba.org>
> Date: Tue, 26 Feb 2008 20:04:12 +1100
> 
> > It would probably be good to defend against the possibility that the
> > property isn't null-terminated (for example if its length is zero).
> 
> FWIW, when I pull in the device tree on sparc I eliminate any need for
> those kinds of checks by putting a '\0' at the end of every property
> blob.
> 
> I copied a lot of this code from you guys, so it wouldn't surprise
> me if ppc does this too.  :-)

I doubt we do that. Properties that contain things like ranges, or "reg"
properties are expected to be of a size that is a multiple of
#size-cells/#address-cells and I'm not sure that won't break things here
or there if they suddenly get one more byte..

Or do you mean you/we are appending that-without- changing the length
field ?

Ben.
