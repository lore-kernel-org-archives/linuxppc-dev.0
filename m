To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPX8xx: MMC over SPI.... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 09 Mar 2004 14:18:22 +0100."
             <200403091418.22891.david.jander@protonic.nl>
Date: Tue, 09 Mar 2004 16:25:10 +0100
Message-Id: <20040309152515.A912DC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <200403091418.22891.david.jander@protonic.nl> you wrote:
>
> I know that Wolfgang Denk is going to flame me right away for this, but I'll
> do it anyway :-)

I'm sorry if I caused the impression I would flame people  for  using
SPI.  This  was  definitely  not my intention. But I think it is only
fair to share some experience, and warn you not  to  run  into  well-
known problems.

> I am going to write a SPI driver and on top of that a MMC driver for linux for
> the MPC852T, unless there is something already out there.
> Anyone tried this before and has some sources to share? Or pointers to
> sources?

The SPI driver is there, but I don't recommend to use it for any type
of data transfers that require any  significant  bandwidth.  Motorola
writes:

        The SPI was not designed to be a high-bandwidth channel. It
        can run very quickly for bursts of up to 16-bits. But the
        peripheral has no FIFO and low priority in the MPC860 and
        thus you cannot burst lots of data quickly through the
        interface.
        ...
        Note that the SPI is of lower priority internally than the
        SCCs, thus, the SPI will be the first device to be "starved".
        Since it has no FIFO, it is especially sensitive to underruns.
        The best way to prevent this is to use a buffer size of 1
        "character" (of size programmed in the mode register).
        ...

Also, you should be aware that the SPI  protocol  is  implemented  as
microcode  running  on the CPM, so any high-speed data transfers will
suck up CPM performance.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"...and the fully armed nuclear warheads, are, of  course,  merely  a
courtesy detail."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
