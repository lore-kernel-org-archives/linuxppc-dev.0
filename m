Message-Id: <199901301505.QAA14745@porto.ens-lyon.fr>
From: Loic Prylli <Loic.Prylli@ens-lyon.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jan 1999 16:05:36 +0100 (MET)
To: linuxppc-dev@lists.linuxppc.org
Subject: bug in arch/ppc/mm/init.c
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hello,

The init function of some drivers use ioremap, which may call
MMU_get_page (if the target zone cross a 4Mbyte/s bounday(. But
MMU_get_page is marked as an initfunc, so it is no longer
present->panic.


Here one possible solution:

--- arch/ppc/mm/init.c~ Thu Jan  7 21:06:57 1999
+++ arch/ppc/mm/init.c  Sat Jan 30 16:01:17 1999
@@ -883,7 +883,7 @@
        }           
 }
 
-__initfunc(static void *MMU_get_page(void))
+static void *MMU_get_page(void)
 {
        void *p;
 

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
