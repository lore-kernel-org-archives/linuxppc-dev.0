Message-ID: <3D192BDF.4050206@embeddededge.com>
Date: Tue, 25 Jun 2002 22:50:07 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: Frank Rowand <frowand@mvista.com>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
References: <20020624221020.A14330@home.com> <3D1897FC.D7D7C5B2@mvista.com> <20020625135008.A15298@home.com> <3D18E933.7020402@embeddededge.com> <20020625153900.B15298@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> The only thing I was talking about was moving it toward the end
> of setup_arch.  All _driver_ init is after that.

Hmmm.....why doesn't kgdb_map_scc call early_serial_init() instead
of waiting for the 4xx platform setup to do that?  The purpose of
kgdb_map_scc() is to do everything necessary to make the serial
port accessible.  Is there something else done in platform specific
setup that is needed?


> I think we are talking two different things.  Kgdb does not work on
> the vast number of 7xx/74xx designs with 16550's all at arbitrary
> locations.  The ppc4xx_kgdb.c binding is non-functional is _devel
> (relying on the old COM_PORT structure that is gone).
>
> You've got me confused Dan, where did I suggest removing a useful
> feature?

Well, it used to be a useful feature :-)  If people keep breaking
kgdb by making changes it relies upon for proper operation, that
should get fixed :-)


> I don't understand what you are suggesting.  I don't poke a static
> serial port mapping in (to be used in STD_SERIAL_DEFS) because
> early_serial_init()/ioremap() can do it dynamically for me.

Well, that was one of the important changes (mapping the port
or using an existing mapping) to allow an early kgdb.  I guess if
you don't want to map it, that's a reason why it won't work.


> Hrm, so are you suggesting a do an early mapping (I use one for
> early boot text support) init kgdb, and not use early_serial_setup()?
> I think kgdb should be able to work with early_serial_setup().

:-)

The kgdb doesn't care how the port was set up, just that is has a
way to use it.  You could call early_serial_setup() several times,
depending upon how the mapping may change.  This is basically how
the 8xx and 8260 work.  I use an early trivial mapping that was set
up by the bootloader, then an intermediate mapping, then finally
something after rs_init() is called.

I guess if moving it to later in setup_arch() is enough.......


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
