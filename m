Date: Wed, 31 Jul 2002 17:11:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC/PATCH] idle loop changes
Message-ID: <20020801001143.GH17472@opus.bloom.county>
References: <20020731193200.GD17472@opus.bloom.county> <3D4847D5.9030404@embeddededge.com> <20020731143357.C5793@home.com> <3D48569D.30201@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D48569D.30201@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 31, 2002 at 05:29:01PM -0400, Dan Malek wrote:
> Matt Porter wrote:
>
> >So, some new machdep calls that you can populate on a per board basis?
> >Are you just talking about them being used upon entering/exiting idle?
>
> I was just thinking the power_save() function could be unique to a
> board.  It has to be something combined with the power save mode
> chosen on the chip, so machdep calls may not be appropriate.  We are
> using names like ppc6xx_pm_idle, ppc4xx, ppc8xx, when it could be
> my_custom_board_pm_idle......Just don't assume one type of chip will
> use the same function on different boards.  When the idle/power save
> function is chosen, it should probably be done during board setup,
> not processor set up.

Right.  ppc6xx_pm_idle happens to work in most cases on all of the 6xx
boards, but once this gets in there is nothing stopping fooboard from
overriding this in platform_init().

The whole reason behind these changes is that the current power_save()
is dangerous on 4xx, and with the thought that maybe 8xx (or 405LP)
would need to do something much different.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
