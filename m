Message-ID: <638AA0336D7ED411928700D0B7B0D75B0189BAFA@aimail.aiinet.com>
From: "Dayton, Dean" <deand@aiinet.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Irq 0 problem
Date: Fri, 6 Sep 2002 13:32:12 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been trying to port Linux 2.4.18-pre2 to the MPC8266ADS board. I
grabbed the SCC uart.c from 2.5.31.

The kernel loads and runs, the ramdisk is uncompressed and mounted. Then I
take an interrupt with SIVEC=0. SIVEC is now 0 everytime it is read, this
causes do_IRQ() to go into an endless loop.

I modified the code as follows:

 int do_IRQ()
 {
	...
	for (;;)
	{
		irq=get_irq()
-		if (irq >= 0)
+		if (irq > 0)
			ppc_irq_dispatch_handler()
		else
		...
	}
 }

This appears to solve (or at least hide) my problem. Has anyone else run
into this? I think it is occuring during the open of the console port (SCC
1). I ran into the same thing while trying to run on an EST8260 using an SMC
as the console. Am I simply covering up a problem with a misconfigured
device driver?

On another note, is anyone working on PCI support for an 8265/8266? That's
my next task.

Thanks
Dean
-------------
Dean Dayton
System Architect - Applied Innovation Inc.
(614)923-1174
deand@aiinet.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
