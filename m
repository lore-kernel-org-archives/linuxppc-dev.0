From: Benjamin Herrenschmidt <bh40@calva.net>
To: <minyard@acm.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Misc problems with Lombard (serial, ethernet, SCSI)
Date: Mon, 25 Sep 2000 09:22:00 +0200
Message-Id: <19340820005344.27517@192.168.1.10>
In-Reply-To: <m2vgvlthiy.fsf@c469597-a.grlnd1.tx.home.com>
References: <m2vgvlthiy.fsf@c469597-a.grlnd1.tx.home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>* Serial drivers - At least when talking to the modem, it will occasionally
>  cease to work.  I use pppd to connect, and when it disconnects I cannot
>  reconnect.  Once this happens, anything that tries to open the port get
>  an I/O error.  If I unload the serial module and then reload it, the
>  problem goes away for a while.  This started happening around 2.2.15.

Dan Malek recently "ported" a workaround for a HW SCC bug which seem to
fix such problems. (The SCC get stuck sometimes when receiving certain
kinds of bad characters). I'll try to get that merged ASAP.

>* MESH Driver - It won't work with my scanner.  The scanner works fine
>  under MacOS and used to work under Linux x86.  It has problems with
>  disconnects.  Also, once I use it then sleeping and awaking will locks up
>  the machine.  Also, unloading the MESH module and reloading it locks up
>  the machine.

Paul ? Any clue ? MESH is still a weird beast to me ;)

>* Ethernet driver (BMAC) - The driver will occasionally lock up under heavy
>  load (I haven't seen this yet with 2.2.17, though).  If I define an alias
>  address, bringing down the alias address will also bring down the main
>  address (this is still happening under 2.2.17).  Unloading the ethernet
>  driver and loading it again causes a lockup.

I've not experieced that before, there are some known issues with bmac
(HW bugs uncovered by comments in Apple's Darwin source code) but AFAIK,
nothing that cause a kernel lockup.

>I'm also seeing random lockups after long periods of running under
>heavy load, but this is new and I'm thinking it may be a heat problem.
>But just in case, I'll say it.

It may also be a RAM problem. Some Lombards are known to have memory
controller (or RAM, we don't know for sure) problems.
Also, which boot method are you using ?

>I'm posting this to see if anyone is aware of these problems.  I'm
>willing to work on them, but I don't want to duplicate work.  But I
>would like to hear from the responsible parties for each driver to
>know what to do.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
