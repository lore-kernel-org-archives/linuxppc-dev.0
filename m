Date: Wed, 8 Nov 2000 22:48:41 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com.au
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
In-Reply-To: <19341003142642.9550@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10011082158290.25279-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >It does freeze, however, when I snooze the machine while using software
> >cursor. Seems the software cursor interrupt needs to be stopped before
> >turning off the display :-) Question: is software cursor support worth the
> >hassle?
>
> well, it's probably not difficult to fix. I'll give it a look.

Right now, there's no hook in the fbcon code for this AFAIK. On second
thought, all it should take is to clear cursor_on in fbcon.c before sleep
(i.e. by fbcon_cursor(CM_ERASE), but that won't tell you if the cursor was
already erased). Adding new hooks to the consw struct is a no-no, perhaps.
Adding a CM_PAUSE / CM_RESUME feature to fbcon_cursor might be sufficient.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
