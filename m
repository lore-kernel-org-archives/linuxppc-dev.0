Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: broken startup for scsi in 2.4.12 rsync'd this morning
Date: Sat, 13 Oct 2001 16:39:40 -0400
References: <20011013174028.CRXJ4990.tomts6-srv.bellnexxia.net@there> <20011013195117.29022@smtp.wanadoo.fr>
In-Reply-To: <20011013195117.29022@smtp.wanadoo.fr>
MIME-Version: 1.0
Message-Id: <20011013203719.OHCL19094.tomts9-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

> I've neem myself experiencing various kernel lockups at boot with SCSI
> enabled & aic7xxx. In fact, I had some problems with .11 too with a
> disk not reponding on my dual G4.
>
> I don't know what's up, but I'd apreciate if you could send me the
> panic infos so I can start tracing it.

Unforutnately there really isn't any kind of backtrace info given by the
panic.

All that it says is (hand copied)

scsi0:A:1 ahc_intr - referenced scb not vlaid during seqint 0x71 scb(0)

scsio: Dumping Card State in Message - in phase at SEQADDR 0x1c1

...

Kernel panic: for safety
In interrupt handler - not syncing
<0>Rebooting in 180 seconds.

I found the line in the aic7xxx.c  file which prints this.  It seems
ahc_lookup_scb() returns 0 and then it does the kernel panic.

I can't seem to find any backtrace info for the System map. and none of
the messages get written to log - I guess because no sync is done?

I would be happy to copy down all of the Adaptec debug info but I am not
sure it will help.

Is there a way to force ithe kernel to drop into some sort of debug mode
upon doing a "panic"?

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
