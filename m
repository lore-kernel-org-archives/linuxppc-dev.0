Message-ID: <3D19D3FE.700@embeddededge.com>
Date: Wed, 26 Jun 2002 10:47:26 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Matt Porter <porter@cox.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Move kgdb init code?
References: <20020624221020.A14330@home.com> <3D1897FC.D7D7C5B2@mvista.com> <20020625135008.A15298@home.com> <3D18E933.7020402@embeddededge.com> <20020625153900.B15298@home.com> <3D192BDF.4050206@embeddededge.com> <20020626012524.A16050@home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:

> .... At any rate, every
> one of them is potentially different and so should be calling
> early_serial_init from the <board>.c or <board>_setup.c to pass in
> the board-specific UART values.

I see.  I was wondering if we should move the kgdb start up
back into the board specific setup again......That way we can
choose to start up kgdb at any point in there according to board
initialization.  Of course, I still like to use xmon, and it uses
the same serial port functions as kdgb, so if we move the kgdb
initialization we should also move xmon.


> Damn people. :)

My experience has been it usually gets fixed as the last required
feature before a product ships to a customer :-)


> So, my concern at the beginning is whether moving it from before
> ppc_md.setup_arch to after that call would have adverse effects
> on those using kgdb.

Let's move it back into the board specific setup.  IMHO, it doesn't
really affect what we can debug with kgdb/xmon.  I just didn't want it
to go all of the way back to the way it was........

I'm surprised more people don't use xmon.  That is the first debugger
I usually use, since you can make it easily understand some complex
kernel data structures and associations.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
