From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: SUNGEM config
Date: Wed, 13 Feb 2002 22:12:43 +0100
Message-Id: <20020213211243.28959@smtp.wanadoo.fr>
In-Reply-To: <87u1slf5wf.fsf@theorie.physik.uni-muenchen.de>
References: <87u1slf5wf.fsf@theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Precisely.  That's what the ifd daemon does, it polls the device once
>every second via that ioctl in order to see whether it is connected or
>not.

Well, we have a chicken & egg problem then. I shut down the device when
the interface is down for more than about 10 seconds. At that point,
it's isn't possible to get the link state since even the PHY is powered
off. So ifd cannot detect the link up condition. Either I fake the ioctl
and return no link, or I power it back up each time, preventing basically
the chip to ever be power managed.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
