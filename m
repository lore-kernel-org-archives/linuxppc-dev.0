Message-ID: <DF2B720CF774D21189EE00805FA7FA220B909B50@nmrusdunsx3.nielsenmedia.com>
From: "Wells, Charles" <Charles.Wells@nielsenmedia.com>
To: "'Pantelis Antoniou'" <panto@intracom.gr>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: [PATCH] 8xx: fix initialation bug/race condition between u-bo
	ot & linux
Date: Wed, 18 Jun 2003 11:55:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pantelis,

We've developed several custom 8xx-based devices here at work.  The
application images are either VxWorks or Linux and the boot loader is my
own.  I had similar problems during early development of the boot loader.

I found the following statement in the MPC850UM (p. 18-9):

					NOTE:
  The entire dual-port RAM should be cleared as the first step in
  system initialization.  This step should be followed by issuing a
  CPM reset using CPCR.  Only after these two steps should the dual-
  port RAM be programmed for specific functions.

I tried to get a more detailed description of what might happen if this
wasn't followed through my Mot. factory contact without success.  So, in
order to do it "by the book", my boot loader follows the above procedure in
two places: 0) At the beginning (after setting up SDRAM and before enabling
Ethernet), and 1) At the end (just before the boot loader jumps to the
target image).  We haven't seen the symptoms since.

I have no idea if this is applicable to other 8xx family members (I could
not find a similar statement in the MPC860UM).  At the time, I needed to get
past the loader and on with the real work; so I took a conservative
approach.  When we do our next design, I'll take the same approach when I
port our boot loader.

Just a thought.
Charlie

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
