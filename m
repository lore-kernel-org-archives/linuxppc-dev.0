Message-ID: <67505026E29DD311A9AA00508B7315F33B7399@EXCHANGE>
From: Mike Flynn <mflynn@enerdyne.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: Embedded Planet 860T software reset
Date: Mon, 18 Sep 2000 11:16:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Software resets works! Our Julia found John Whitney's comment:

	"I soft reboot my system using "shutdown -nr now..."

Dan's code works as provided. "init 6" and "reboot" don't work, but we have
something
that does.

Mike Flynn
Enerdyne

-----Original Message-----
From: Mike Flynn [mailto:mflynn@enerdyne.com]
Sent: Monday, September 18, 2000 10:17 AM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Embedded Planet 860T software reset



Has anyone been able to execute "reset" or "init 6" in linux 2.2.13 running
on Embedded Planet board and have the system actually reboot?

I found and tried the following code in the archives:

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

Dan said, "At one time, I had modified
the kernel "gorom()" function to simply jump into the boot rom as
if a reset occurred.  I should make this work again for many reasons."

Does anyone know of any further developments and/or successes?

Thanks,

Mike Flynn
Principal Software Engineer
Enerdyne Technologies
8402 Magnolia Ave.
Suite C
Santee, CA 92041
Voice: 619-562-3061
MFlynn@Enerdyne.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
