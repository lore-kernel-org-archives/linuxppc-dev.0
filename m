Date: Thu, 7 Jan 1999 09:00:55 -0700 (MST)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: system.h and "::"
Message-ID: <Pine.LNX.3.96LJ1.1b7.990107085341.599A-100000@cricket>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hello...

using the latest snapshot of r5 (and its associated libs/compiler), i have
a problem with asm/system.h that i hope has a simple fix.

i wrote a c++ program that includes some system header files. it chokes
when asm/system.h gets included because "::" appears in that file. that
has special meaning to the c++ compiler. the compile succeeds if it's
broken up into ": :" but will that cause any problems? does that have the
same meaning in assembly? the patch ends this message. 

brad

--- system.h.orig	Thu Jan  7 08:57:18 1999
+++ system.h	Thu Jan  7 01:47:34 1999
@@ -16,7 +16,7 @@
 	asm("dcbf %0,%1\n\t"
 	    "sync \n\t"
 	    "isync \n\t"
-	    :: "r" (line), "r" (0));
+	    : : "r" (line), "r" (0));
 }
 
 extern __inline__ void dcbi(void *line)
@@ -24,7 +24,7 @@
 	asm("dcbi %0,%1\n\t"
 	    "sync \n\t"
 	    "isync \n\t"
-	    :: "r" (line), "r" (0));
+	    : : "r" (line), "r" (0));
 }
      
 extern __inline__ void __restore_flags(unsigned long flags)



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
