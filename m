Message-ID: <3ADE01A6.CB30230E@nexus-tech.net>
Date: Wed, 18 Apr 2001 17:05:42 -0400
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: sound driver on mpc823
References: <3ADDDCFF.CB4B9A6F@nexus-tech.net> <3ADDFA54.D44199F7@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Dan Malek wrote:
>
> Kyle Harris wrote:
>
> > The CPM reports underrun errors. The driver does not set the LAST bit
> > for any buffer descriptors and setting this bit prevents this error.
>
> Setting the LAST indicator doesn't "prevent" the error, it just
> causes the CPM to stop at this point until you can fill more buffers.
> This is not the desirable effect for audio codecs, or anything else
> that requires a continuous stream of data.
>
> > ........ If I set the data length to be greater than 16
> > bytes I still get underrun errors.
>
> Just 16 bytes?  Hell, those are gone almost as quickly as you
> tell the CPM the buffer is available.  You better be using huge
> buffers, or lots of them.  The CS4218 driver uses 32K buffers.
> You shouldn't be writing small buffers to audio codecs, the management
> overhead is significant.

At this point I'm just trying to verify the data that is sent to the
codec. So, for debug purposes I'm sending a small number of bytes. I
understand your comments concerning streaming data. But I still don't
understand why underrun errors occur when the end of data is indicated.
I guess I won't worry about that for now.

I'm struggling to define the RAM entries and buffer descriptors such
that data is formatted correctly for the ac97 (one 16 bit slot followed
by 12 20 bit slots (of which only 4 slots are valid)). It seems I should
be able to define RAM for 1 16bit slot followed by 8 10bit slots. But
I'm not sure exactly how the CPM correlates the RAM entries to buffer
descriptors (e.g., does it advance buffer descriptors when the RAM entry
changes). Various experiments so far with the RAM and BDs don't make
much sense. Any advice is appreciated.

Thanks, Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
