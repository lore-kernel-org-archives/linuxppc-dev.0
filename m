Date: Thu, 20 May 2004 09:53:21 +0200
From: Colin Leroy <colin@colino.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: netconsole & sungem
Message-Id: <20040520095321.0a4c2ae6@jack.colino.net>
In-Reply-To: <1085003339.15182.77.camel@gaston>
References: <20040519221056.54d7f732@jack.colino.net>
	<1085003339.15182.77.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 20 May 2004 at 07h05, Benjamin Herrenschmidt wrote:

Hi,

> I have to look more closely at netconsole, does it actually call open() on
> the driver ? If not, beware that sungem will power manage the chip when
> closed,

Well, it doesn't look like (it seems to me that all the init stuff is done
in net/core/netpoll.c::netpoll_setup()).
During my tests, I used modules for sungem and netconsole, and I'm actually quite sure that the chip was up, as I had an ssh session to the remote host... I also tried to issue some stuff via 'netcat -u 192.168.0.4 6666' and it worked. It only looks like the netconsole/netpoll isn't sending anything.

> also the link state machine may not have had time to run...

Shouldn't be a problem neither, as everything is already up when I do my tests.

I'll try find more about all this.

Thanks,
--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
