Message-ID: <77FE4A1FA59FF947845A42194AD667627730BD@uswaumsx07medge.med.ge.com>
From: "Eisenhut, Daniel (MED)" <Daniel.Eisenhut@med.ge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Check stop failure on 8270 i2c
Date: Mon, 16 Feb 2004 16:30:30 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've ran into a strange problem that I'm not sure even how to
troubleshoot.
Hopefully, someone can lead me in the right direction...  I working on a
custom board with an 8270 processor running linuxppc_2_4_devel (2.4.23)

I've converted the 8260 i2c driver from U-Boot to a Linux module to talk
with our rtc.  Everything works great as I can read and write to the
rtc.
But occasionally the system resets due to a check stop state in the
processor.  I've determine that this occurs sometime during or between
setting the STR bit in the i2com register and going to sleep waiting for
an interrupt (which was added since it just busy waits in U-Boot).

If I have debug output turned on, this checkstop reset occurs after
about
15-30 calls to "hwclock".  (Each clock read makes about 13 i2c
transfers)
But if I turn off debugging, it fails after about 1-5 calls.  Obviously
there is some kind of race condition going on here.

Has anyone seen this problem before?  Any suggestions on how to proceed
to
troubleshoot this problem?  (And yes I do have a BDI2000)

Thanks for your help...
Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
