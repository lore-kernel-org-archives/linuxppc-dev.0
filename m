Date: Sat, 2 Jan 1999 18:04:01 -0500 (EST)
From: satadru pramanik <satadru@umich.edu>
To: Brad Midgley <brad@pht.com>
cc: drow@cs.cmu.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990102121137.439B-100000@cricket>
Message-ID: <Pine.SOL.4.05.9901021800540.29365-100000@asteroids.rs.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Please let me know!!! And if this _does- fix the problem, it should go to
linus asap, before 2.2 gets finalized.  This certainly is a problem for
me, and I can't imagine seeing a 2.2 final kernel that hangs on serious
scsi activity. ( it crashes my web server every ten minutes.)


On Sat, 2 Jan 1999, Brad Midgley wrote:


paul,

what was the result of testing this patch? i see it isn't present at vger.
but does it make scsi activity safer? does it need more testing? should i
test it as-is?

dan, have you figured out a setup to burn cd's without panics?

brad

> Paul Mackerras <paulus@cs.anu.edu.au> wrote:
> 
> Daniel Jacobowitz <drow@drow.res.cmu.edu> wrote:
> > Anything involving general heavy load (say, compiling XFree86) on an
> > external disk causes either lockups or panics (inactive in
> 
> There used to be some cli's in drivers/scsi/sd.c which disappeared at
> some stage (I don't know why).  The following patch puts them back
> in.  Could you try this?  One person said that it helped but that then
> 
> --- linux/drivers/scsi/sd.c	Tue Oct 20 21:44:44 1998
> +++ linux-pmac/drivers/scsi/sd.c	Wed Nov  4 13:48:30 1998
> @@ -531,10 +531,14 @@
>      Scsi_Cmnd * SCpnt = NULL;
>      Scsi_Device * SDev;
>      struct request * req = NULL;
> +    unsigned long flags;
>      int flag = 0;
>  
> +    save_flags(flags);
>      while (1==1){
> +	cli();
>  	if (CURRENT != NULL && CURRENT->rq_status == RQ_INACTIVE) {
> +	    restore_flags(flags);
>  	    return;
>  	}
>  
> @@ -549,6 +553,7 @@
>           */
>          if( SDev->host->in_recovery )
>            {
> +	    restore_flags(flags);
>              return;
>            }
>  
> @@ -601,6 +606,7 @@
>  	 * Using a "sti()" gets rid of the latency problems but causes
>  	 * race conditions and crashes.
>  	 */
> +	restore_flags(flags);
>  
>  	/* This is a performance enhancement. We dig down into the request
>  	 * list and try to find a queueable request (i.e. device not busy,
> @@ -618,6 +624,7 @@
>  	if (!SCpnt && sd_template.nr_dev > 1){
>  	    struct request *req1;
>  	    req1 = NULL;
> +	    cli();
>  	    req = CURRENT;
>  	    while(req){
>  		SCpnt = scsi_request_queueable(req,
> @@ -632,6 +639,7 @@
>  		else
>  		    req1->next = req->next;
>  	    }
> +	    restore_flags(flags);
>  	}
>  
>  	if (!SCpnt) return; /* Could not find anything to do */
> 
> 




----
satadru pramanik www.umich.edu/~satadru
Do, or do not.  There is no try.
-Yoda
---


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
