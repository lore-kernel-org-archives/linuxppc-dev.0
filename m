Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84E8EDDEC3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 03:31:51 +1100 (EST)
In-Reply-To: <200612221709.31714.david-b@pacbell.net>
References: <037901c71f14$a47115b0$020120ac@Jocke>
	<Pine.LNX.4.64.0612132349560.3439@gate.crashing.org>
	<1166090567.30422.73.camel@gentoo-jocke.transmode.se>
	<200612221709.31714.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9132DA19-B7C2-4FF4-953E-BE1C4EB4E4A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH] Adapt spi_mpc83xx SPI driver for	832x
Date: Tue, 26 Dec 2006 10:31:55 -0600
To: David Brownell <david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net,
	'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 22, 2006, at 7:09 PM, David Brownell wrote:

> On Thursday 14 December 2006 2:02 am, Joakim Tjernlund wrote:
>
>> Adjusted patch(lets hope I didn't mangle this one:):
>
> Assuming this is correct, I don't have a problem with this one.
> Feel free to wrap it up with a signed-off-by and I'll forward it.

I'll cleanup the patches and send something to you.

> I have a question for someone who knows about this controller  
> though...
>
> When issuing an RX-only transfer, the SPI framework currently  
> specifies
> that spi_transfer.tx_buf will be null, and that the data shifted out
> on the MOSI pin is "undefined".  Looking at the spi_mpc83xx driver in
> the current tree, it looked to me as if it wouldn't actually accept
> a null tx_buf ... did I miss something, or would the tx_buf##type  
> macros
> expand to a null pointer exception?  If I did miss something, what  
> data
> would be shifted out in that case?  (IRQ vectors from page zero?)

Yeah this is a bug, your not missing anything.  Would be good if this  
fix could go into 2.6.20.

> There's a proposal afoot to change how that's specified:  rather than
> shifting out "undefined" data, define it as all zeroes.  It was easy
> to see the impact of that on all the other SPI controller drivers now
> upstream; all but one send zeroes already.  But not this one...
>
> - Dave

[snip]
