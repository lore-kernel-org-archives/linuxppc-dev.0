Date: Mon, 7 Jun 1999 13:10:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH problems in 2.2.x
In-Reply-To: <199906030546.PAA00546@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9906071309510.9045-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Jun 1999, Paul Mackerras wrote:
> Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:
> > During boot up I now see the message:
> > 
> >     scsi1: device driver called scsi_done() for a syncronous reset
> 
> The reset and abort handling in the mesh driver needs to be updated;
> the way the scsi mid-layer expects them to work changed during the 2.1
> series but I haven't updated the mesh driver to the new way yet,
> partly because I don't know exactly what the new way is. :-)
> 
> > Since the message mentions `syncronous reset' and since the old Conner doesn't
> > seem to do synchronous mode, this makes me think the mesh driver fails with
> > synchronous devices in 2.2.x. Is this correct? Does anyone else see this
> > problem?
> 
> It's working OK for me now with a 2.3.4 kernel, having fixed ioremap
> (the fix is now in vger for both the 2.2 and 2.3 branches).
> 
> If you want to disable sync mode, you could change the initializer for
> mesh_sync_targets in drivers/scsi/mesh.c from 0xff to 0.

This one seems to work.

Greetings,

				    Geert (nailing down other problems)

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
