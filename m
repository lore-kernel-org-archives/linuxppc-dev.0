Message-ID: <3C6BFF02.5070905@embeddededge.com>
Date: Thu, 14 Feb 2002 13:16:34 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC or SMC for console ?
References: <3C6BF3B1.2040906@capflow.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent Pinchart wrote:

> I need 4 serial ports at runtime, and was wondering if I should rather
> use 2SMC + 2SCC or 4 SCC (or 1SMC + 3SCC).

Always use SCCs for real work and the SMC for console and other low
speed things (like connected to low bit rate TDM).

The SMCs require a large amount of CPM software overhead, so not only
are they relatively slow devices, they also steal cycles from other
peripherals.

Is one of your serial ports in the example above the console?  If you
need four ports not including the console that can be a little more
challenging.  Carefully investigate the I/O pin multiplexing to ensure
you can get the SMC2 I/O, as that is one of the first ones stolen for
other uses.

Have fun!


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
