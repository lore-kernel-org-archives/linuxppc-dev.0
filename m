To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Cc: "Paolo Scaffardi" <arsenio@tin.it>
Subject: Re: rebooting with the FADS
References: <001701c01e61$958ed240$0a00010a@paoloweb> <009801c02392$d9011ca0$22227c92@intranet.gr>
From: Marcus Sundberg <marcus@cendio.se>
Date: 24 Oct 2000 19:13:47 +0200
In-Reply-To: "Yannis Plevrakis"'s message of "Thu, 21 Sep 2000 09:11:57 +0300"
Message-ID: <veu2a2jh6c.fsf@lipta.cendio.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Yannis Plevrakis" <iple@intracom.gr> writes:

> >
> > on my FADS, i see that it is not possible to reboot from software: you
> must
> > press the reset buttons to do this.
> >
>
> Just a "brute force" alternative:
> In case you don't mind having a latency of tens/hundrends of miliseconds
> before rebooting
> and you want a soft reboot very similar to a hardware one, generating a
> HRESET signal,
> a very simple approach could be to use the software watchdog timer.

No need to use the watchdog for that, just do a checkstop reset.

in m8xx_setup.c:

extern void m8xx_cs_reset(void);

void
m8xx_restart(char *cmd)
{
        /* Wait for serial console message. */
        mdelay(20);
        /* Turn off interrupts and do a checkstop reset */
        cli();
        m8xx_cs_reset();
        for(;;);
}


and in head.S:


/*
 * Perform a checkstop reset of the CPU
 */
#define KAPWR_KEY       0x55ccaa33

_GLOBAL(m8xx_cs_reset)
	mfmsr   r3                      /* Read MSR */
	rlwinm  r3,r3,0,20,18           /* Mask ME bit, and... */
	sync
	mtmsr   r3                      /* ...write back MSR. */
	sync
	mfspr   r4,149                  /* Read DER */
	rlwinm  r4,r4,0,3,1             /* Mask CHSTPE bit, and... */
	sync
	mtspr   149,r4                  /* ...write back DER. */
	sync
	mfspr   r3,638                  /* Load r3 with immr, and... */
	rlwinm  r3,r3,0,0,15            /* ...mask lower 16 bits */
	lwz     r4,644(r3)              /* Read PLPRCR */
	lis     r5,KAPWR_KEY@l
	ori     r5,r5,KAPWR_KEY@h       /* Make sure PLPRCR is ready for */
	stw     r5,900(r3)              /* unlocking. */
	lis     r6,KAPWR_KEY@h
	ori     r6,r6,KAPWR_KEY@l
	stw     r6,900(r3)              /* Unlock PLPRCR */
	ori     r4,r4,128               /* Set CSR bit, and... */
	stw     r4,644(r3)              /* write back PLPRCR. */

	addis   r3,r3,1         /* Add IMAP_SIZE to immr, and... */
	lwz     r4,-4(r3)       /* ...read from a non-existant address! */
	blr                     /* Return if we fail for some reason... */


//Marcus
--
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
