Message-ID: <3958E94D.E55D4294@netx4.com>
Date: Tue, 27 Jun 2000 13:50:05 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PLPRCR & Checkstop reset
References: <Pine.LNX.3.96.1000625172850.17884A-100000@tristar.cc.absoval.com> <3958E040.15B86909@netx4.com>
Content-Type: multipart/mixed; boundary="------------AFCAF9F21A0B2FFFA3681894"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------AFCAF9F21A0B2FFFA3681894
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Malek wrote:

> Here is the first installment.

Let's try this again.......I will actually attach something
this time.  I am travelling and don't have access to a system
or enought documentation to attempt checkstop/reset.



	-- Dan
--------------AFCAF9F21A0B2FFFA3681894
Content-Type: text/plain; charset=us-ascii; name="m8xx_setup.patch"
Content-Disposition: inline; filename="m8xx_setup.patch"
Content-Transfer-Encoding: 7bit

--- linux.old/arch/ppc/kernel/m8xx_setup.c	Wed Feb 16 11:43:25 2000
+++ linux/arch/ppc/kernel/m8xx_setup.c	Tue Jun 27 09:47:27 2000
@@ -228,9 +240,17 @@
 void
 m8xx_restart(char *cmd)
 {
-	extern void m8xx_gorom(void);
+	extern void m8xx_gorom(uint bp, uint startaddr);
+	uint	startaddr;
+
+	startaddr = 0xfff00100;
+
+	if (cmd != NULL) {
+		if (!strncmp(cmd, "startaddr=", 10))
+			startaddr = simple_strtoul(&cmd[10], NULL, 0);
+	}

-	m8xx_gorom();
+	m8xx_gorom((uint)__pa(res), startaddr);
 }

 void

--------------AFCAF9F21A0B2FFFA3681894--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
