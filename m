Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 5F64C68802
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 20:00:19 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Alessandro Rubini <rubini@gnudd.com>
Date: Wed, 28 Dec 2005 10:00:11 +0100
References: <200512271730.28563.david.jander@protonic.nl>
	<20051227214949.GA8236@mail.gnudd.com>
In-Reply-To: <20051227214949.GA8236@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512281000.12073.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Which CAN driver to port to for PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

On Tuesday 27 December 2005 22:49, Alessandro Rubini wrote:
> I need to port ocan to support SJA1000 on an ARM device, as a client
> asked for it.  Also, another client asked for a 2.6 port, so all of
> this will happen pretty soon (2-3 weeks). I don't know if that makes
> any difference.

That could of course make a difference.... eventually.
The problem I see with Ocan is that it has a very different API than all the 
others. I know of at least two others, which try to be compatible (or at 
least easily portable between) with each other: lincan and can4linux. I am 
not sure but I think they started from the same base, and somehow agreed to 
stay API-compatible.
Ocan's API on the other hand, seems to be tailored around the intel 
controller, and doing little more than offering a user-space interface to the 
chip, much in the same way as one is used to programming small 
microcontrollers with integrated CAN periferals. I wonder how the port to 
SJA1000 will turn out, since I believe it would have to emulate some 
82527-specific stuff, in order to offer a compatible API.
The advantage OCan might have, is probably better control of timing, since 
AFAIK, one can avoid using queues, which give additional delays if the queue 
is not empty; somehting often not wanted in real-time applications.

Also one difficulty in designing a good CAN driver model, is the fact that CAN 
offers up to the link-layer in hardware, and the rest is application 
specific, so it is hard to do much in the driver without hampering some 
possible application. I am convinced though, that there should be a 
chip/card-independent API to the application-programmer, and that effort 
should be done to converge into the same direction. Programmers now really 
have a tough time choosing, and that is as bad as having no choice at all 
IMHO.

So, wouldn't it be better to try to unite forces and at least offer similar 
API's, or even better, develop a standard linux CAN framework? I guess there 
is little chance something like this will ever become part of the kernel, but 
right now the situation is really awful. CAN is quite popular for embedded 
systems, but even embedded systems developers like to write portable code.

Regards,

P.S.: Alessandro: I have copy of "LDD1" on my desk, and I like it a lot. 
Thanks!

-- 
David Jander
Protonic Holland.
