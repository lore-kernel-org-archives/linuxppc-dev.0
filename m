Message-ID: <3D486350.8070700@embeddededge.com>
Date: Wed, 31 Jul 2002 18:23:12 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Matt Porter <porter@cox.net>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
References: <20020731193200.GD17472@opus.bloom.county> <3D4847D5.9030404@embeddededge.com> <20020731143357.C5793@home.com> <3D48569D.30201@embeddededge.com> <3D485B2F.84829A96@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer wrote:

> Why not use keep the ppc6xx_pm_idle, etc. as fallbacks (e.g., nothing
> special about  your board so use generic 6xx one)

That's fine, except we aren't using machdep calls.  The interaction between
the external devices and the processor control may not allow (or we may
not desire) using a "standard" processor function.  For example, the MPC8xx
has four powersave modes and four sleep modes.  Only one of the modes
is generic and isn't suitable to use if I use one of the other modes that
may require external device management.

My comment was truly simple :-)  Just don't assume the processor powersave
modes are suitable for all boards.  A board may wish to do something
different, so I suggest keeping the power save function initialization local
to a board rather than processor architecture.  Many of them are likely to
be generic and can use the same function, just allow the provision for them
to be different at the board level, that's all.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
