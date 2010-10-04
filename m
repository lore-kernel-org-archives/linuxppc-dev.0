Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32BFCB70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  4 Oct 2010 15:25:31 +1100 (EST)
Message-ID: <63799.84.105.60.153.1286166325.squirrel@gate.crashing.org>
In-Reply-To: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
References: <AANLkTikPhpvJetY+NDFggYE6Wp6ppyt2BLmzEbsiwHuZ@mail.gmail.com>
Date: Mon, 4 Oct 2010 06:25:25 +0200 (CEST)
Subject: Re: use of BAT before taking over the MMU
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Albert Cahalan" <acahalan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On the prom boot path, with the firmware supposed to
> be managing the MMU, there is a case where:
>
> 1. Linux changes some BAT registers.
> 2. Bits 0x00000070 are/become set in the MSR.
> 3. Linux takes an MMU fault.
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

The PowerPC OF binding requires the firmware to save and restore
the BATs on entry to / exit from the firmware.


Segher
