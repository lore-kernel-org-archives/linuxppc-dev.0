Subject: Re: netconsole & sungem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040519221056.54d7f732@jack.colino.net>
References: <20040519221056.54d7f732@jack.colino.net>
Content-Type: text/plain
Message-Id: <1085003339.15182.77.camel@gaston>
Mime-Version: 1.0
Date: Thu, 20 May 2004 07:49:00 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-05-20 at 06:10, Colin Leroy wrote:
> Hi,
>
> I tried to make netconsole work (with the attached patch copied from e1000), but can't get anything on the cable... the destination station doesn't see anything (nor Ethereal).
>
> Are there any traps I didn't see ? (I have netconsole as a module and it loads ok:
> netconsole: local port 32768
> netconsole: interface eth0
> netconsole: remote port 6666
> netconsole: remote IP 192.168.0.4
> netconsole: remote ethernet address 08:00:20:76:3c:57
> netconsole: local IP 192.168.0.11
> netconsole: network logging started
> )

I have to look more closely at netconsole, does it actually call open() on
the driver ? If not, beware that sungem will power manage the chip when closed,
also the link state machine may not have had time to run...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
