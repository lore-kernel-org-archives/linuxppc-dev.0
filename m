Date: Wed, 14 Jul 1999 15:09:21 +1000
Message-Id: <199907140509.PAA21467@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.10.9907131538530.6336-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Tue, 13 Jul 1999 15:45:54 +0200
	(CEST))
Subject: Re: MESH problems in 2.2.x
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9907131538530.6336-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> Just made some diff between 2.1.130 and the `broken' kernels. The following
> two things make me suspicious:
> 
> Index: drivers/scsi/mesh.c
> @@ -1643,6 +1643,7 @@
>  static void
>  mesh_completed(struct mesh_state *ms, Scsi_Cmnd *cmd)
>  {
> +#if 0
>  	if (ms->completed_q == NULL)
>  		ms->completed_q = cmd;
>  	else
> @@ -1651,6 +1652,9 @@
>  	cmd->host_scribble = NULL;
>  	queue_task(&ms->tqueue, &tq_immediate);
>  	mark_bh(IMMEDIATE_BH);
> +#else
> +	(*cmd->scsi_done)(cmd);
> +#endif
>  }
>  
>  /*
> 
> Why did Dave (mesh.c 1.20, according to the vger CVS logs, which don't help me
> much) do this?

I made that change, I think maybe I sent it straight to Linus and it
got into vger via the official releases or something.

The point was that I realized, looking at the scsi code (which has
changed quite a bit since I wrote the original mesh driver) that the
scsi done routine was going to schedule a BH handler anyway so there
was no point in mesh.c having complexity to arrange for that.  I was
cleaning up the SMP locking in mesh.c at the time and making that
change was an alternative to getting the locking right for the
completed_q stuff.

> Index: drivers/scsi/scsi_obsolete.c
> @@ -354,6 +357,18 @@
>      printk("In scsi_done(host = %d, result = %06x)\n", host->host_no, result);
>  #endif
>  
> +    if(SCpnt->flags & SYNC_RESET)
> +    {
> +        /*
> +        * The behaviou of scsi_reset(SYNC) was changed in 2.1.? .
> +        * The scsi mid-layer does a REDO after every sync reset, the driver
> +        * must not do that any more. In order to prevent old drivers from
> +        * crashing, all scsi_done() calls during sync resets are ignored.
> +        */
> +        printk("scsi%d: device driver called scsi_done() "
> +	       "for a syncronous reset.\n", SCpnt->host->host_no);
> +        return;
> +    }
>      if(SCpnt->flags & WAS_SENSE)
>      {
>  	SCpnt->use_sg = SCpnt->old_use_sg;
> 
> And after the `return', my machine no longer does anything...

The mesh driver really needs someone to go through and update the
abort and reset handling to the new way.  The first problem is of
course to work out exactly how the scsi mid-layer expects host adaptor
drivers to behave... :-)

> Things are a bit difficult now, because I no longer have Internet connectivity
> on my boxes. DDS 2 GB packets with high latency form my sole link now :-(

The latency sucks, but the bandwidth is phenomenal, right? :-) :-)

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
