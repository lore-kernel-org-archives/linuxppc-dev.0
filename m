Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id EB31FDDF09
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Nov 2007 07:14:17 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so557237pyi
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Oct 2007 13:14:16 -0700 (PDT)
Message-ID: <8496f91a0710311314k3dd90e12t670e2405fcaa0725@mail.gmail.com>
Date: Wed, 31 Oct 2007 23:14:15 +0300
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org, "Theo Gjaltema" <gjalt007@chello.nl>
Subject: Re: reboot of mpc8270 sometimes fails
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I thik that m8260_restart in 2.4 kernel is broken. Try to get it from
the 2.6 kernel, or look at this.

 /* The 8260 has an internal 1-second timer update register that
@@ -112,21 +123,16 @@ m8260_get_rtc_time(void)
 static void
 m8260_restart(char *cmd)
 {
-	extern void m8260_gorom(bd_t *bi, uint addr);
-	uint	startaddr;
-
-	/* Most boot roms have a warmstart as the second instruction
-	 * of the reset vector.  If that doesn't work for you, change this
-	 * or the reboot program to send a proper address.
-	 */
-	startaddr = 0xff000104;
-
-	if (cmd != NULL) {
-		if (!strncmp(cmd, "startaddr=", 10))
-			startaddr = simple_strtoul(&cmd[10], NULL, 0);
-	}
-
-	m8260_gorom((unsigned int)__pa(__res), startaddr);
+	__volatile__ unsigned char dummy;
+	
+	local_irq_disable();
+	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= 0x00000001;
+
+	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
+	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
+	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
+	printk("Restart failed\n");
+	while (1) ;
 }
