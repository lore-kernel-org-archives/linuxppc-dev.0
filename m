Message-ID: <002901c28b5a$55f60820$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Hans Feldt" <Hans.Feldt@uab.ericsson.se>, <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>, <scop@digitel.com.br>,
	<thomas@corelatus.com>
References: <IGEFJKJNHJDCBKALBJLLAEPLFHAA.joakim.tjernlund@lumentis.se> <001c01c28b4b$28665b80$4f158a86@default>
Subject: Re: [PATCH] arch/ppc/8xx_io/enet.c, version 2
Date: Wed, 13 Nov 2002 22:19:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> ----- Original Message -----
> From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
>
> > You may be right, perhaps one must invalidate the whole buffer before giving it
> > to the CPM/DMA. Suppose you reuse a buffer which has been modified before it
> > was freed and the dcache must write back data to free up space and the buffer,
> > which now is owned by the CPM, get written to.
>
> I beleive this could happen. Since IP does not perform checksumming
> but relies on the link (don't know this really) in that matter, I guess
> the application could get wrong data...

OK, anyone against? Dan?

>
> > I have not seen any corrupted packets and you are the first to report
> > any problems.
>
> Did you run any data integrity tests?
No, normal use, lots of pings etc.

>
> > What modifications have you done?
>
> I haven't used your driver patch. I used the __idea__ of delaying the
> invalidate to the point where you know how much has been received. This was
> in an RTOS ATM driver for a 405. An integrity test showed that some few
> packets was wrong. Data was changed by means of cache lines.

Did you notice any difference in performance when moving the invalidate call?

Any other problems with the patch?

Dan, would you like a new patch or will you fix this?

         Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
