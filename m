From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: <joakim.tjernlund@lumentis.se>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: 8xx_io/enet.c
Date: Tue, 10 Dec 2002 18:52:16 +0100
Message-ID: <FCEAKDJJAPHPLJFINDAJMENLCLAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <IGEFJKJNHJDCBKALBJLLMELCFIAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

> -----Original Message-----
> From: Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
> Sent: Dienstag, 10. Dezember 2002 16:47
> To: Stephan Linke
> Subject: RE: 8xx_io/enet.c
>
>
> >
> > Hi,
> >
> > just checked the mailing list for the patches. Looks like you
> mean the 'copy
> > large buffers' patch.
> > I took the second version and applied it to fec.c too.
> > It works fine on both devices. The only thing that confused me was the
> > discussion about the possibility of inconsistent data.
>
> Thats the one. However there is a small bug in version 2 w.r.t when the
> invalidate_dcache_range call is made. In the second version the
> call is made
> AFTER the buffer has been received as opposed in my first version
> where the
> call is made BEFORE handing over the buffer to the CPM. That may in some
> rare case corrupt the packet. See
> http://lists.linuxppc.org/linuxppc-embedded/200211/msg00120.html
>
> This is only relevant for 8xx, 82xx don't have to invalidate.
>
> > But we didn't noticed
> > any performance impact when testing it with IP packets.
>
> Didn't you get any performace increase after appling my patch?
> If you did, could you send me your performace numbers?
> Did you try the first version also? If so,any performance
> difference compared with version 2?
>
>   Jocke

Indeed we had a better performance with the patch applied to fec.c
(100base-Tx). Unfortunately I don't have the results at the moment. At
enet.c I didn't noticed mutch of a difference since handling 10base-T
traffic isn't that mutch of a problem at the moment and I didn't spend time
to figure out the exact CPU load.
I remember that someone said he had an performance impact at small packets.
I didn't noticed any (even though there must be a slight on caused by the
additinal if-statement).
I can post some of our results results after I did some more tests but that
may take a while since I am buisy with other stuff at the moment.


  Stephan

>
> PS.
>    Any perticular reason not to cc the embedded list also? Others would
>    probably be intressted also.
>
Well, there is a 'reason'. I simply didn't payed attention to the fact that
a simple reply doesn't reply to the list.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
