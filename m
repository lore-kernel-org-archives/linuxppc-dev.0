Subject: Re: Download timeout problems on Embedded Planet CLLF (was Patch for zsrec.c)
To: mlocke@jps.net (Matthew Locke)
Date: Tue, 1 Feb 2000 12:53:01 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <NDBBJCEBJMJJJBIMCFBEOEJJCAAA.mlocke@jps.net> from "Matthew Locke" at Jan 31, 2000 05:13:28 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000201015301.E3B2A1B172@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matt,

Thanks for chiming in here; I was beginning to think I was just going crazy...

Matthew Locke writes:
> I assume you mean using tftp.  If so ...
> I have had the download timeout problems.  It is not related (directly) to
> the EP boards.  It is more of a tftp issue. If there is alot of network
> traffic, tftp might not receive its packets in time.  If you have a large
> file with alot of network traffic, it defintely will timeout.

I think you mean it's an issue with the EP implementation of tftp.

RFC1350 requires that the sender and receiver use retransmission after
timeouts to deal with lost UDP packets, as follows:

					If a packet gets lost in the
    network, the intended recipient will timeout and may retransmit his
    last packet (which may be data or an acknowledgment), thus causing
    the sender of the lost packet to retransmit that lost packet.

It seems as though the EP implementation simply aborts the transfer instead.

>                                                                I worked
> around these issues by isolating the EP and host from the other network
> traffic and/or splitting the srec file into smaller parts.

Both these options are painful. It's hard to isolate a network device and its
server from the network, and splitting the file prevents me using the autoload
feature in the ROM monitor.

> PS: we are working on a ELF binary dnload capabiltiy, watch EPs website next
> month.  That will speed up the dnload.

Sounds great! If it's still using tftp, can you make sure they get the timeout
handling right this time? :-)

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
