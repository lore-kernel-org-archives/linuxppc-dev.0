From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>
Subject: Re: mediabay hotswap, tun naming patches (2.4)
Date: Sun, 20 Jan 2002 21:13:30 +0100
Message-Id: <20020120201330.2268@smtp.wanadoo.fr>
In-Reply-To: <20020120134827.15bedeb6.jpgarcia@execpc.com>
References: <20020120134827.15bedeb6.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It's been a while.  Got a few patches that have been languishing in my
>system for too long.
>
>One changes the mediabay ide_register call to an explicit call to the
>pmac_ide call that it needs, at least on a wallstreet.  Without this, an
>ide mediabay cannot be inserted post-boot.

Thanks.

>The second patch changes the behavior of the tun device so that devices
>are not required to have a numerical value after their name.  I have yet
>to figure out how to tell MOL to assign a numerical value and pass tun a
>% like the kernel wants.  Just made it so that if there is no numerical
>value, then that tun device is the only one of its kind.  ( "mol" = one
>iface, while mol% = many ifaces, (or maybe "mol0" and "mol1" are explicit
>different ones, not same as "mol%" ifaces.)).  I suppose would be
>unnessesary/undesired when MOL gets updated to support ___% registration.
>(or i figure out how to use it :)

Could you send this to the tun driver maintainer ?

>Thanks.
>
>PS, I still use my wallstreet, and haven't found out why adb crashes.
>rtc and nvram also appear to break at that moment, but pmu (battery
>support, etc) is fine.  still not sure if its a pure software issue or if
>hardware got confused.

rtc and nvram are broken too ? that's weird. Can you try disabling the
battery polling stuff in via-pmu.c to see if it's causing the problem ?
(comment out the calls to query_battery_state())

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
