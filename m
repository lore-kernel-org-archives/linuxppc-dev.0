Message-ID: <38431D61.4977E59B@netx4.com>
Date: Mon, 29 Nov 1999 19:42:09 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: BenH <bh40@calva.net>
CC: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound problems
References: <19991130012819.012476@smtp.calvacom.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BenH wrote:


> I tried reproducing the complete init-cleanup-init sequence in
> dmasound_init() without luck (weird...). There must be some kind of
> timing issue out there, or I missed something. I don't know the AWACS
> chip very well so it's difficult to guess.

If these are actually a power and reset to the audio codec, there
are timing constraints.  Usually, you have to power up and hold
reset at least 50 milliseconds before releasing reset (Crystal
codec specs).

This is why it may work with XMON if you set/clear bits
individually, but not work when you run the code.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
