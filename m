Message-Id: <199902131443.JAA07700@linuxmaster.corel.eng>
From: "Gavriel State" <u497w7n9@umail.furryterror.org>
Subject: Patch for Megahertz PCMCIA Ethernet support
Date: Sat, 13 Feb 1999 09:45:10 -0500
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've had much more success with the latest (3.08) PCMCIA code
and my Megahertz card.  Here's a patch that solves the remaining
problems with the Megahertz card (the last two bytes were being
swapped by the output code).

Is there anyone I should be sending this to in particular, or is
the list the best place?

--- smc91c92_cs.c Mon Feb  8 14:08:02 1999
+++ smc91c92_cs.c.orig Mon Jan 18 08:22:11 1999
@@ -1200,8 +1200,8 @@
 #ifdef USE_32_BIT
  outl((length+6) << 16, ioaddr + DATA_1);
  if (length & 0x2) {
-     outsl_ns(ioaddr + DATA_1, buf,  length >> 2 );
-     outw_ns( *((uint16 *)(buf + (length & 0xFFFFFFFC))),ioaddr +DATA_1);
+     outsl(ioaddr + DATA_1, buf,  length >> 2 );
+     outw( *((uint16 *)(buf + (length & 0xFFFFFFFC))),ioaddr +DATA_1);
  } else
      outsl_ns(ioaddr + DATA_1, buf,  length >> 2 );
 #else

-Gav

--
Gavriel State
Engineering Project Leader - Linux Apps
Corel Corp
gavriels@corel.com



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
