Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <joakim.tjernlund@lumentis.se>,
	"Dayton, Dean" <deand@aiinet.com>,
	"linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: dcache and 8260_io/fcc_enet.c
Date: Fri, 1 Nov 2002 17:01:29 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLIEJDFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <IGEFJKJNHJDCBKALBJLLOEJCFHAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Crap, disregard my previous mail.

The 8260 CPM is aware of the CPU dcache and therefor you don't need to flush
the data before handing the buffer over to the CPM. The CPM 8xx family CPU
has no understanding of the CPU caches and needs an explicit flush.

  Jocke
>
> >
> > I noticed that fcc_enet_start_xmit() does not flush the transmit data before
> > setting up the transmit buffer descriptor. I get the impression that this is
> > not necessary. But I don't understand why. I have spent the morning looking
> > through code and Motorola docs and am non the wiser.
>
> That's because the 8260 CPU understand the CPU caches and, while the 8xx does not
> and therefore needs a flush_dcache_range().
>
>     Jocke
>
> >
> > Thanks
> > Dean
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
