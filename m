From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx_io/enet.c
Date: Tue, 10 Dec 2002 16:02:40 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJGENJCLAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <IGEFJKJNHJDCBKALBJLLGEKOFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Joakim,

> > Since the errors are reported on packet base it is always the last
packed
> > that get's corrupted. (I think it's like this: when there are no more
> > buffers the CPM simply continues writing on the current buffer causing
this
> > problem).
>
> I think not, once the CPM has received a packet in a BD, it
> closes that BD and
> will not modify that BD until you tell the CPM its free again. Atleast
> this should be the case for the SCC, don't know if the FEC is supposed
> to do the same
>

we are using the one in the 2.4.18 kernel (hardhead). Sorry I don't actualy
know wich patch. :(

But I recall that we had this problem with fec.c while our CPU was under
heavy load. But I think it's the same situation on enet.c.
Finaly you are right. SCCE_ENET_BSY dosn't cause such problems. At the FEC
there is no BSY interrupt event. There's only BD_ENET_RX_OV signaling a
buffer overflow. Since that is an error condition the buffer has to be
discarded leading to the  condition I tried to describe.
It looks like BD_ENET_RX_OV occures in enet.c ONLY for 'oversized' frames.
On FEC it occures on missing BD's too cuasing that stupid behavior.
I didn't expect that mutch of a difference. Sorry.


Stephan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
