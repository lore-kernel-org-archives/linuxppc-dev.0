Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7D96767DEA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 06:33:34 +1000 (EST)
Date: Fri, 29 Jul 2005 15:33:23 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Vikas Aggarwal" <va824363@albany.edu>
Message-Id: <20050729153323.3f2c62ad.kim.phillips@freescale.com>
In-Reply-To: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
References: <32704.198.22.236.230.1122651627.squirrel@198.22.236.230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc8248  SEC -- interrupt handler not invoked
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 29 Jul 2005 11:40:27 -0400 (EDT)
"Vikas Aggarwal" <va824363@albany.edu> wrote:

> Hi All,
>   Will  appreciate if someone can guide me how to debug this inside SEC
> (security co-processor) core.
> 
>  The linux driver is writing descriptor into the FETCH-Register(0x2048) 
> for Random Number generation execution unit(RNG-EU). The request came
> through a test program from user space. The RNG generation request never
> seems to complete as my ISR is not invoked.
>  I checked the CCPSR(Crypto Channel Pointer Status register = 0x2010) and
> it has value=0:7(0-31 : 32-63 bits). 7 means "channel_error". But its
> always there even before I write the RNG descriptor to Fetch-register.

a value of 7 in bits 56-63 (PAIR_PTR) can suggest processing has not begun.

can you verify you are writing the upper bits of the FR (i.e. 0x204c)?

Kim
