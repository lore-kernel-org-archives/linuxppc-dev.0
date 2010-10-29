Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8520B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 11:16:42 +1100 (EST)
Message-ID: <53195.84.105.60.153.1288311394.squirrel@gate.crashing.org>
In-Reply-To: <20101028210753.22240.qmail@kosh.dhis.org>
References: <20101028210753.22240.qmail@kosh.dhis.org>
Date: Fri, 29 Oct 2010 02:16:34 +0200 (CEST)
Subject: Re: Pegasos OHCI bug (was Re: PROBLEM: memory corrupting bug,
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: pacman@kosh.dhis.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> > Almost all of my devices are under that PCI node. What will I prove by
>> > disabling them?
>>
>> You should put it after "load", and before "go".
>>
>> It should give you a working system; it's a sledgehammer workaround.
>
> I can do it a little more gracefully than that. This works to deactivate
> the
> problem devices manually:
>
>   1 lbflip 80000000 8 + rl!
>   1 lbflip 80001000 8 + rl!
>
> where 80000000 and 80001000 have been obtained from
> /pci@80000000/usb@5/assigned-addresses and
> /pci@80000000/usb@5,1/assigned-addresses; 8 is the offset of the
> HcCommandStatus register; and the 1 bit is HostControllerReset (HCR).
>
> Now I'm just trying to find the more correct way of doing it, without
> hardcoded addresses. That'll be something like this:
>
>   search the device tree for OHCI nodes
>   for each OHCI node
>     get assigned-addresses
>     map-in
>     set HCR
>     wait for acknowledgement
>     map-out

As you noted, your firmware does not show which usb host controllers
are OHCI and which are not.  It has a lot of other problems as well.
Also, it's a lot of code to do things this way.  Which is why I suggested
the "heavy handed" workaround: it is simple and should work on even the
most broken OF implementations.

To figure out which host controllers are OHCI, you'll need to look
at the PCI class code (0c0310 for OHCI), since your OF doesn't want
to tell you.

> Sound good?

Sounds like it should work, yes.


Segher
