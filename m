Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: <benh@kernel.crashing.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: some questions on new dual 1Gig G4's support?
Date: Mon, 4 Feb 2002 13:27:26 -0500
References: <20020203185831.MQZJ9396.tomts12-srv.bellnexxia.net@there> <20020204181538.4089@mailhost.mipsys.com>
In-Reply-To: <20020204181538.4089@mailhost.mipsys.com>
MIME-Version: 1.0
Message-Id: <20020204182315.PZGJ18463.tomts7-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

> No. It's 2 things. First the NAP must be disabled depending on the
> errata (7450 + L3), but also, neither the 7450 nor the 7455 support
> DOZE, they can only NAP or do nothing. Worst, on the 7455, it's bad
> to set HID0:DOZE as it actually has a different meaning.

Yes, that is the HIGH_BAT_EN (bit 8) of HID0 which I think we should leave
as zero to keep the 7455 compatible with the 7450.  I know nothing about
BAT registers or how to take advantage of block sizes up to 4 Gig, and I
also do not know if/how we should handle the 4 extra special purpose
registers (supevisor mode only).  Some sample exception handling code uses
these extra SPRG registers to hand;le BAT table exceptions to speed things
up.  Someone who actually knows a whole lot more about the best way to use
BATs will have to take a look at all of these extra pieces.

> So let's split the can doze & can nap into 2 different features.

I will do that in cputable.h as you said..

But what about the SLEEP mode my last e-mail mentioned.  It is a different
mode from NAP (does no bus snooping) but saves more power.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
