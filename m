Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3348CDDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 07:38:05 +1100 (EST)
Message-ID: <45DA0AA4.3020107@am.sony.com>
Date: Mon, 19 Feb 2007 12:37:56 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
References: <20070216062739.6DFDBDDD05@ozlabs.org>	
	<45D7AA50.3090408@am.sony.com>
	<1171915022.18571.50.camel@localhost.localdomain>
In-Reply-To: <1171915022.18571.50.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> This messed me up a bit since I had two stacks in the bss, one for each
>> processor thread.  By the time this was called on the primary thread the
>> secondary thread could already be using its stack.  I changed the secondary
>> thread to use a small stack in the data section, so this seems OK.
> 
> The secondary thread(s) don't need a stack to loop in secondary hold,
> right ? So maybe we could go all the way without using a stack. Do we
> need C code at all for them ? We just need to hold them until we make
> them branch to the kernel.

I thought it would be nice to be able to use printf() in there so you
see the following.  Its handy for debugging.

smp_secondary_hold:307: released cpu (1)


-Geoff
