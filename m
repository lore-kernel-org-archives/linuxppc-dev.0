Message-ID: <3ADDFA54.D44199F7@mvista.com>
Date: Wed, 18 Apr 2001 16:34:28 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kyle Harris <kharris@nexus-tech.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sound driver on mpc823
References: <3ADDDCFF.CB4B9A6F@nexus-tech.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kyle Harris wrote:

> The CPM reports underrun errors. The driver does not set the LAST bit
> for any buffer descriptors and setting this bit prevents this error.

Setting the LAST indicator doesn't "prevent" the error, it just
causes the CPM to stop at this point until you can fill more buffers.
This is not the desirable effect for audio codecs, or anything else
that requires a continuous stream of data.

> ........ If I set the data length to be greater than 16
> bytes I still get underrun errors.

Just 16 bytes?  Hell, those are gone almost as quickly as you
tell the CPM the buffer is available.  You better be using huge
buffers, or lots of them.  The CS4218 driver uses 32K buffers.
You shouldn't be writing small buffers to audio codecs, the management
overhead is significant.

> 1) Why is the LAST bit never set?

For lots of reasons.  Primarily, it causes the CPM to send a continuous
stream of data from the buffers.  When you set the LAST indicator, it
will stop and transmit idles (or some other bit pattern you may program),
before it opens the next buffer and resynchronizes with the TDM.  You
clearly don't want this in an audio stream.  I also want to know when
an underrun occurs, so I can clean up the audio channel.

> ......... Which I guess is OK if the application
> continues to send data to the driver. But is this desirable? How is the
> device closed in this case?

The application must continue to send data.  If it doesn't, the CPM
will indicate an underrun condition, you will have to send the
communication channel (an SCC or SMC) a restart command, and then it
starts to poll the next BD in the ring for more data.

In the case of an audio codec, if the application can't keep up, does
it matter what you do?  With the current driver design, you give the
application the maximum amount of time to provide the data, and if it
doesn't the channel is cleanly shut down and restarted.  By using the
LAST indicator, you can get trash in the audio stream between every
buffer descriptor (and you usually will with SMC resync to the TDM).

> 2) Why do underrun errors occur even when the LAST bit is set?

There may be some race condition due to the small buffers you are
using.  It really shouldn't (but you shouldn't be using LAST in
this application anyway).

> .... Is the
> CPM unable to keep up at this data rate?

The CPM can easily keep up.  The problem is your software can't
keep buffers available for the CPM.

> ..... Is this significant, or does
> the driver/codec recover?

It would be significant for me, since I only want bits I send from
an application reaching the codec.  When I stop sending or close
the device, I want it shut down properly.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
