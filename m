Return-Path: <bgat@billgatliff.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE70DB71BE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 16:13:06 +1100 (EST)
Received: by fxm5 with SMTP id 5so5776154fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Feb 2011 21:13:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF0A8BBBE2.4D143142-ON88257831.000E1C77-88257831.000E6FD6@selinc.com>
References: <OF8C287A2E.13F8CEBF-ON8825782B.0073FBAF-8825782B.00789868@selinc.com>
	<20110208021616.GO30616@yookeroo>
	<OF0A8BBBE2.4D143142-ON88257831.000E1C77-88257831.000E6FD6@selinc.com>
Date: Mon, 7 Feb 2011 23:13:02 -0600
Message-ID: <AANLkTin5B02PuVrDH_5FaeYEK+amnopKzS36wyjEafFZ@mail.gmail.com>
Subject: Re: Question on supporting multiple HW versions with a single driver
	(warning: long post)
From: Bill Gatliff <bgat@billgatliff.com>
To: Bruce_Leonard@selinc.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


I think the Silicon Motion SM501 driver might provide a useful
example, since the chip comes in both memory-mapped and PCI versions.
Unfortunately the chip is implemented as a multi-function driver
(mfd), so the code is not un-complicated.  Still fairly
straightforward and well-written once you learn your way around it,
though.

Basically, it implements a core set of functionality to talk to the
actual chip registers, which is bus-agnostic.  Then the bus-specific
drivers use these functions when they actually want to touch the chip
itself.  In other words, exactly what David suggested.


b.g.


On Mon, Feb 7, 2011 at 8:37 PM,  <Bruce_Leonard@selinc.com> wrote:
>>
>> There are a number of drivers which already have this sort of dual bus
>> binding.
>>
>
> Thanks for the feedback David, I appreciate it. =A0Could you point me to =
one
> of those drivers that has "this sort of dual bus binding" so can see an
> example of what I'm trying to do?
>
> Bruce
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Bill Gatliff
bgat@billgatliff.com
