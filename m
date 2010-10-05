Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C0DDB70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 19:09:27 +1100 (EST)
Subject: Re: use of BAT before taking over the MMU
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <acahalan@gmail.com>
In-Reply-To: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Oct 2010 19:09:19 +1100
Message-ID: <1286266159.2463.335.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2010-10-02 at 14:32 -0400, Albert Cahalan wrote:
> On the prom boot path, with the firmware supposed to
> be managing the MMU, there is a case where:
> 
> 1. Linux changes some BAT registers.
> 2. Bits 0x00000070 are/become set in the MSR.
> 3. Linux takes an MMU fault.

Meeep ! Linux should never take an MMU fault at that point :-) If it
does, then there's a bug somewhere that needs squashing.

> 4. The firmware handles it.
> 
> AFAIK, you can't expect the firmware to leave the BAT alone.
> If the firmware provides mapping services by using the BAT
> as a software-filled TLB, Linux's BAT changes may be lost.
> 
> You also can't expect that your BAT changes will not conflict
> with mappings that the firmware uses for itself. The firmware
> might write to your new BAT mapping, relying on those virtual
> addresses to be something else entirely.

Right, which is why the moment Linux takes over the BATs, it shouldn't
call into FW anymore nor take faults.

Cheers,
Ben.
