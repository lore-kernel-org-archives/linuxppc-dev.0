Date: Sat, 11 Sep 1999 11:01:00 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: linuxppc-user@lists.linuxppc.org, erbenson@alaska.net
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: quik 2.0 fix
Message-Id: <19990911110100.027102@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


It took me a while to figure out why my printf's were displaying crazy
results until I found out the glibc2.1 dev_t is a long long ! So this fix
will make quik correctly recognize the partition number:

--- quik.c.old	Sat Sep 11 10:52:54 1999
+++ quik.c	Sat Sep 11 10:52:01 1999
@@ -521,7 +521,7 @@
 	bootdev[7] += UNIT(st1.st_dev);
     strcpy(spart, bootdev);
     if (PART(st1.st_dev) != 0)
-	sprintf(spart+8, "%d", PART(st1.st_dev));
+	sprintf(spart+8, "%d", (int)PART(st1.st_dev));
 
     if (verbose)
 	printf("Second-stage loader is on %s\n", spart);


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
