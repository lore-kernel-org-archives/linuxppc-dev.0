Message-Id: <4.3.2.20001213174222.00bfdef0@falcon.si.com>
Date: Wed, 13 Dec 2000 17:45:26 -0500
To: Brian Ford <ford@vss.fsi.com>, Dan Malek <dan@mvista.com>
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: 2.5 or 2.4 kernel profiling
Cc: Graham Stoney <greyham@research.canon.com.au>,
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.21.0012131547530.24199-100000@eos>
References: <3A37A048.46E692A0@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 04:08 PM 12/13/00 -0600, Brian Ford wrote:

>On Wed, 13 Dec 2000, Dan Malek wrote:
>
> > Graham Stoney wrote:
> >

[snip]

>I speak only for the 8260, but...
>
>With it, you can DMA directly into IP aligned skbuffs, eliminating the
>copy.  I've done it and it seems to work.  I'll have to benchmark it, but
>the copy overhead should be significant.  This just makes IP do the
>checksum later.
>
>Also, to avoid bus contention, shouldn't the Rx buffers be on the local
>bus?  Probably the BD's too.  Unless we can figure out how to
>put these in DPRAM, but it doesn't look possible for the FCC's.  I don't
>know if it is possible to allocate skbuffs in other than 60x bus SDRAM,
>though.

I asked the Mot help line about this.  There response follows.  The
bottom line, according to them, is that you can put the BDs in DPRAM,
but it will still cause 60x bus cycles, defeating the purpose of
putting them in DPRAM.  I have not personally verified this.

----------------------------------------------------------------------

Date: Wed, 3 May 2000 07:36:33 +0200
Subject: Motorola DigitalDNA Help, Service Request # 1-PUU6 Reply
To: vanbaren_gerald@si.com
From: DigitalDNA Help <DigitalDNA.Help@motorola.com>
MIME-Version: 1.0
Reply-To: DigitalDNA Help <DigitalDNA.Help@motorola.com>
Message-Id: <390FCC60.2280E779@tcfc.tornado.nsk.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Content-Length: 2170
X-UID: 1

Dear K Van Baren,

in reply to your Service Request SR 1-PUU6 [ref. TORLP] (see details
below):


CPM busy-polling adds about 1% overhead to bus activity. Can you ignore
it?
You may put FCC BDs in Dual-Port RAM but CPM will continues to access
them through 60x bus.
The only way to disable this polling is to emit STOP TX command when you
have not data to send.

------- Details of your request: -------

Date Opened :  04 Apr 2000 06:46:09
Product :       MPC8260
Category:       Technical Request

---------- Subject ----------
8260 FCC buffer description

---------- Description ----------
I want to minimize bus activity due to the CPM busy-polling buffer
descriptors for the transmit "ready" flag.  I realize I can turn off the
polling and do the transmit on
  demand trick, but polling is convenient.  To minimize bus activity, I
wish to put the FCC buffer descriptors in Dual-Port RAM.

  The discussion of Dual-Port RAM in section 13.5 talks about the buffer
descriptors residing in Dual-Port RAM or in main memory.  The SCC
discussion on buffer
  descriptors in section 19.2 says the buffer descriptors for the SCCs,
SMCs, SPI, and I2C _must_ reside in Dual-Port RAM, and the RBASE and
TBASE definitions
  enforce that since they are 16 bits only.

  The FCCs are not mentioned in the above list.  The FCC parameter RAM
has a full 32 bit address for RBASE and TBASE and there is a flag that
selects whether the
   buffer descriptors are in local bus memory or 60x bus memory.  Can
they be put in Dual-Port RAM?

------- End of request details -------



To review or update this Service Request, or to enter a new Service
Request, please access Motorola's Customer Support web site at
http://www.motorola.com/semiconductors/support

If there is ever an occasion when you cannot access Motorola's Customer
Support web site, you can also contact us by sending an email to
DigitalDNA.Help@motorola.com
or by calling us at one of the following numbers:

Americas                1-800-521-6274          7AM-6PM Phoenix
Asia                    +852-2666-8307          8AM-6PM Hong Kong
Japan                   0120-191-014            8AM-5PM Tokyo
Europe                  +49-89-92103-559        9AM-5PM Munich


Regards,
Motorola Semiconductors Customer Support

----------------------------------------------------------------------


[snip]

>Opinions welcome.

I have plenty of them :-)


>--
>Brian Ford
>Software Engineer
>Vital Visual Simulation Systems
>FlightSafety International
>Phone: 314-551-8460
>Fax:   314-551-8444

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
