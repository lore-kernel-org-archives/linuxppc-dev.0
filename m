In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990430114242.412A-100000@selq119.unl.edu>
Date: Wed, 5 May 1999 12:55:31 +0200
To: Takashi Oe <toe@unlinfo.unl.edu>, linuxppc-dev@lists.linuxppc.org,
        Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: linuxppc-user@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: XServer for controlfb (fix)
Message-Id: <19990505125531.028926@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch seems to fix the problem with controlfb and x servers when
vram is in bank2 only (my 8500 video doesn't work at all, even under
MacOS, when I put the vram in bank 1):

--- linux.orig/drivers/video/controlfb.c	Mon Feb  8 14:29:33 1999
+++ linux.mol/drivers/video/controlfb.c	Wed May  5 12:45:05 1999
@@ -720,9 +720,11 @@
 	p->total_vram = (bank1 + bank2) * 0x200000;
 	/* If we don't have bank 1 installed, we hope we have bank 2 :-) */
 	p->control_use_bank2 = !bank1;
-	if (p->control_use_bank2)
+	if (p->control_use_bank2) {
 		p->frame_buffer += 0x600000;
-
+		p->frame_buffer_phys += 0x600000;
+	}
+	
 	init_control(p);
 }
 

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
