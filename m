Date: Sun, 27 Jun 1999 21:05:34 -0500 (CDT)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: sym53c8xx clock being incorrectly set
Message-ID: <Pine.LNX.4.04.9906272056130.5764-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When my MTX machine boots correctly, I get a message when the sym53c
driver inits something like this:

ncr53c875-0: NCR clock is 26772KHz, 26772KHz


When I compiled 2.2.10, I got saw somthing like 60xxxKHz, and the symbios
driver would continually reset the bus on command timeouts.
(see my previous message)


Well, I changed line 9495 of drivers/scsi/sym53c8xx.c from

        OUTB (nc_stime1, gen);  /* set to nominal delay of 1<<gen * 125us */
        while (!(INW(nc_sist) & GEN) && ms++ < 100000)
                UDELAY (1000);   /* count ms */
        OUTB (nc_stime1, 0);    /* disable general purpose timer */    

to

		UDELAY (480);   /* count ms */


This is obviously not the right way to fix this, but it has solved my
immediate problem (my machine didn't boot), and I have a couple of
deadlines to meet.

If anyone figures this out, or has an idea what why this is messed up, let
me know. Otherwise, I'll get around to fixing it eventually. (I hope)

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
