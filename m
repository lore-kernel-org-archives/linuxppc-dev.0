Date: Thu, 15 Jul 1999 10:45:42 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH problems in 2.2.x
In-Reply-To: <199907140509.PAA21467@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9907151045030.15826-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Jul 1999, Paul Mackerras wrote:
> Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:
> > Just made some diff between 2.1.130 and the `broken' kernels. The following
> > two things make me suspicious:
> > 
> > Index: drivers/scsi/mesh.c
> > @@ -1643,6 +1643,7 @@
> >  static void
> >  mesh_completed(struct mesh_state *ms, Scsi_Cmnd *cmd)
> >  {
> > +#if 0
> >  	if (ms->completed_q == NULL)
> >  		ms->completed_q = cmd;
> >  	else
> > @@ -1651,6 +1652,9 @@
> >  	cmd->host_scribble = NULL;
> >  	queue_task(&ms->tqueue, &tq_immediate);
> >  	mark_bh(IMMEDIATE_BH);
> > +#else
> > +	(*cmd->scsi_done)(cmd);
> > +#endif
> >  }
> >  
> >  /*
> > 
> > Why did Dave (mesh.c 1.20, according to the vger CVS logs, which don't help me
> > much) do this?
> 
> I made that change, I think maybe I sent it straight to Linus and it
> got into vger via the official releases or something.
> 
> The point was that I realized, looking at the scsi code (which has
> changed quite a bit since I wrote the original mesh driver) that the
> scsi done routine was going to schedule a BH handler anyway so there
> was no point in mesh.c having complexity to arrange for that.  I was
> cleaning up the SMP locking in mesh.c at the time and making that
> change was an alternative to getting the locking right for the
> completed_q stuff.

But on my UP box, changing the `#if 0' to `#if 1' fixed all my MESH
problems...

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
