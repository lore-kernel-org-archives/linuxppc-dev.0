Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D11@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "'Yu Bo-BOYU1'" <Bo.Yu@motorola.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: powerpc board without RTC
Date: Mon, 3 Feb 2003 09:13:16 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
Don't comment out the time_init() in start_kernel(). Instead change the
content of the calibrate_decr() function to set the variable set in it on a
fixed falue.
You must find this value by yourself but a good starting point is your
frequency in Hz (I think)
Example of the code
	unsigned int freq = 28000000;
	tb_tick_per_jiffy = freq/HZ;
	tb_to_us = mulhwu_scale_factor(freq,1000000);

and don't forget to set in platform_init()
ppc_md.time_init = NULL;
ppc_md.set_rtc_time = NULL;
ppc_md.get_rtc_time = NULL;
ppc_md.calibrate_decr = calibrate_decr();	/name of your
calibrate_decr() function

-----Original Message-----
From: Yu Bo-BOYU1 [mailto:Bo.Yu@motorola.com]
Sent: Sunday, February 02, 2003 10:33 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: powerpc board without RTC



Hello,

I had a custom 7410 board without RTC. Therefore, I commented out
time_init() in start_kernel(). Is this acceptable for linux ?

>From the startup log of linux, it hang in calibrate_delay() which I think
it is related to RTC.

Any recommendation how I should do to avoid RTC. I really don't care
about time of day stuff except the system tick.



Loading... 618940
Starting at 0x800000...

loaded at:     00800000 008971BC
zimage at:     00805870 00893F33
avail ram:     00400000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Total memory = 64MB; using 128kB for hash table (at c0180000)
Linux version 2.4.17_mvl21 (root@ibm-t30) (gcc version 2.95.3 20010315
(release/
MontaVista)) #41 Sun Feb 2 15:18:05 CST 2003
Host bridge init okay
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
OpenPIC Version 1.2 (1 CPUs and 26 IRQ sources) at fdfd0000
Calibrating delay loop...



Thanks.

Bo

- - - - - - - DISCLAIMER - - - - - - - -
Unless indicated otherwise, the information contained in this message is
privileged and confidential, and is intended only for the use of the
addressee(s) named above and others who have been specifically authorized to
receive it. If you are not the intended recipient, you are hereby notified
that any dissemination, distribution or copying of this message and/or
attachments is strictly prohibited. The company accepts no liability for any
damage caused by any virus transmitted by this email. Furthermore, the
company does not warrant a proper and complete transmission of this
information, nor does it accept liability for any delays. If you have
received this message i nerror, please contact the sender and delete the
message. Thank you.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
