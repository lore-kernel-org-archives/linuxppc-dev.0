From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 sleep power consumption patch; final buttons patch
Date: Thu, 16 Aug 2001 11:43:24 +0200
Message-Id: <20010816094324.6838@smtp.adsl.oleane.com>
In-Reply-To: <20010816040022.28de2b71.jpgarcia@execpc.com>
References: <20010816040022.28de2b71.jpgarcia@execpc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Attached is a patch that addresses sleep-time fan activation on
>wallstreets, and probably other pre-UMA systems.  The code existed in
>2.2, and removed in 2.4 for some reason I am unaware of.  The patch is
>the missing 2.2 code almost verbatim.

Thanks !

>the gist:
>- mediabay IOBUS_enable/disable at sleep (not sure if its related to the fan)

That one should be now done in feature.c, no need to duplicate the code
in mediabay.c (in fact, doing it twice may even be a problem).

>- sleep notification to control power of MESH SCSI chip's host (most
>likely cause)

Ok, that's interesting, it probably got "lost" when I merged all of the
sleep stuff to 2.4, and since I no longer have a MESH-based box ...

>This works on my system.  This should be reviewed and merged at next
>convenience.  If some system crashes in sleep from it, then just don't
>have it map mio_base for that system.  Shouldn't affect pismo and later
>as they shouldn't have MESH.
>
>Not sure about the mediabay mod tho.  It was in 2.2.  <shrug>
>
>I wonder if Darwin forgot about MESH also..  OSX has the fan problem too.

Darwin has a weird MESH driver, dunno if it changed much since the last time
I looked at it (at that time, it didn't work properly on wallstreet).

I'll take card of merging those.

>=====
>
>the second attachment is the volume/eject powerbook button NIL support
>posted a while ago, now in a final form.  Since nobody has had any
>negative feedback or comments, that too can be merged.  It doesn't break
>anything.  I promise.  Thanks to Bastien for helping out with this.

Ok, Will be in asap.

Thanks !

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
