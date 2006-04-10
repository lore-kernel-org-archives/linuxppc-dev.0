Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12DF067A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 06:06:34 +1000 (EST)
In-Reply-To: <1144698501.972.103.camel@saruman.qstreams.net>
References: <1144698501.972.103.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6518EE00-812C-4839-AF00-AA976C35E799@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GPIO endianness on MPC8349
Date: Mon, 10 Apr 2006 15:06:33 -0500
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Apr 10, 2006, at 2:48 PM, Ben Warren wrote:

> Hello,
>
> I'm a noobie to this CPU, and am utterly confused with how the bits  
> are
> ordered on the GPIO ports.  I imagine it's the same as all Freescale
> PPCs, but who knows.  Anyway...
>
> Using an MPC8349MDS eval board, I have one LED to play with.  From the
> schematic, it's connected to GPIO1[1].  From other processors that  
> I've
> worked with, I would have expected to toggle it with either 0x40000000
> (IBM 405) or 0x00000002 (68360).  Nope.  To make this bit move, I mess
> with bit 0x00000040 in the appropriate DAT register.  This leads me to
> believe that either the bit ordering is something
> like ...89abcdef01234567 (sorry for the confusing notation, but
> hopefully it makes sense) or the schematic has a typo.  Since I'm  
> trying
> to write a generic GPIO handler, I'd like to have a little  
> confidence in
> my extrapolation from a single point.
>
> Can anybody shed some light on this?

This is because the Freescale docs are misleading.  If you look at  
the schematic you will see the LED is wired to GPIO1[5] which makes  
sense for the 0x40 value you have to use.

- kumar
