Date: Sat, 2 Jan 1999 12:14:49 -0700 (MST)
From: Brad Midgley <brad@pht.com>
Reply-To: Brad Midgley <brad@pht.com>
To: From:  ;
cc: drow@cs.cmu.edu, linuxppc-dev@lists.linuxppc.org
Subject: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
In-Reply-To: <Pine.LNX.3.95.990102113010.4424A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990102121137.439B-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


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



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
