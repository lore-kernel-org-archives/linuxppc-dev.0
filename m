Message-Id: <200110250031.f9P0VuY48163@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: now random kernel panics with aic7xxx driver 6.2.4 in kernel 2.4.12 
In-Reply-To: Your message of "Sun, 14 Oct 2001 09:17:11 EDT."
             <20011014131455.VGFQ17332.tomts11-srv.bellnexxia.net@there>
Date: Wed, 24 Oct 2001 18:31:56 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi Justin,
>
>Well, the idea of passing tag_info to the aic7xxx did help me boot but now
>I am getting random kernel panics.  So I upgraded to your latest 6.2.4
>with Ben's 2.4.12 and overnight when no activity was present, I got a
>panic.

I haven't forgotten about this problem... just been dragged off onto
another fire for a few days.

Can you apply this patch and reproduce the problem again?  Hopefully
this additional diagnostic information will help me understand the
problem.

--
Justin

diff -c -r aic7xxx/aic7xxx.c /usr/src/sys/dev/aic7xxx/aic7xxx.c
*** aic7xxx/aic7xxx.c	Wed Oct 24 17:19:14 2001
--- /usr/src/sys/dev/aic7xxx/aic7xxx.c	Wed Oct 24 18:28:48 2001
***************
*** 6302,6308 ****
  	printf("ACCUM = 0x%x, SINDEX = 0x%x, DINDEX = 0x%x, ARG_2 = 0x%x\n",
  	       ahc_inb(ahc, ACCUM), ahc_inb(ahc, SINDEX), ahc_inb(ahc, DINDEX),
  	       ahc_inb(ahc, ARG_2));
! 	printf("HCNT = 0x%x\n", ahc_inb(ahc, HCNT));
  	printf("SCSISEQ = 0x%x, SBLKCTL = 0x%x\n",
  	       ahc_inb(ahc, SCSISEQ), ahc_inb(ahc, SBLKCTL));
  	printf(" DFCNTRL = 0x%x, DFSTATUS = 0x%x\n",
--- 6302,6309 ----
  	printf("ACCUM = 0x%x, SINDEX = 0x%x, DINDEX = 0x%x, ARG_2 = 0x%x\n",
  	       ahc_inb(ahc, ACCUM), ahc_inb(ahc, SINDEX), ahc_inb(ahc, DINDEX),
  	       ahc_inb(ahc, ARG_2));
! 	printf("HCNT = 0x%x SCBPTR = 0x%x\n", ahc_inb(ahc, HCNT),
! 	       ahc_inb(ahc, SCBPTR));
  	printf("SCSISEQ = 0x%x, SBLKCTL = 0x%x\n",
  	       ahc_inb(ahc, SCSISEQ), ahc_inb(ahc, SBLKCTL));
  	printf(" DFCNTRL = 0x%x, DFSTATUS = 0x%x\n",
***************
*** 6375,6380 ****
--- 6376,6392 ----
  	}
  	printf("\n");

+ 	printf("Sequencer SCB Info: ");
+ 	for (i = 0; i < ahc->scb_data->maxhscbs; i++) {
+ 		ahc_outb(ahc, SCBPTR, i);
+ 		printf("%d(c 0x%x, s 0x%x, l %d, t 0x%x) ",
+ 		       i, ahc_inb(ahc, SCB_CONTROL),
+ 		       ahc_inb(ahc, SCB_SCSIID),
+ 		       ahc_inb(ahc, SCB_LUN),
+ 		       ahc_inb(ahc, SCB_TAG));
+ 	}
+ 	printf("\n");
+
  	printf("Pending list: ");
  	i = 0;
  	LIST_FOREACH(scb, &ahc->pending_scbs, pending_links) {
***************
*** 6382,6388 ****
  			break;
  		if (scb != LIST_FIRST(&ahc->pending_scbs))
  			printf(", ");
! 		printf("%d", scb->hscb->tag);
  		if ((ahc->flags & AHC_PAGESCBS) == 0) {
  			ahc_outb(ahc, SCBPTR, scb->hscb->tag);
  			printf("(0x%x, 0x%x)", ahc_inb(ahc, SCB_CONTROL),
--- 6394,6401 ----
  			break;
  		if (scb != LIST_FIRST(&ahc->pending_scbs))
  			printf(", ");
! 		printf("%d(c 0x%x, s 0x%x, l %d)", scb->hscb->tag,
! 		       scb->hscb->control, scb->hscb->scsiid, scb->hscb->lun);
  		if ((ahc->flags & AHC_PAGESCBS) == 0) {
  			ahc_outb(ahc, SCBPTR, scb->hscb->tag);
  			printf("(0x%x, 0x%x)", ahc_inb(ahc, SCB_CONTROL),

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
