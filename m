In-Reply-To: <412F7CF4.5020303@246tNt.com>
References: <412F7CF4.5020303@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32F4ED42-F859-11D8-8E7D-003065F9B7DC@embeddededge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: request_irq called too soon ? What's the limit ?
Date: Fri, 27 Aug 2004 14:44:59 -0400
To: Sylvain Munaut <tnt@246tnt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Aug 27, 2004, at 2:27 PM, Sylvain Munaut wrote:

> I was wondering why some test ISR I put up didn't get called. Finally I
> found out that the "enable" function of the interrupt controller was
> not
> called.

The interrupt is enabled when you call request_irq().

> At which point may I call this function ? These calls where from the
> setup_arch function.

That's too early.  Interrupts are expected to be installed from
device drivers, so calling it earlier than normal device set up
isn't likely to work and could vary from one kernel version
to another.  Just create some trivial driver that does the interrupt
set up for you.  You can't use it any earlier than that, anyway.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
