Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
From: "challaharikumar" <challaharikumar@tataelxsi.co.in>
To: <linuxppc-dev@lists.linuxppc.org>
Cc: <dan@embeddededge.com>
Subject: ADS8260 Hang 
Date: Thu, 22 Apr 2004 11:57:44 +0530
Message-ID: <001101c42832$ec117760$3401080a@telxsi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

I having been trying to bring up the ADS8260 board and incidentally ran
into some problems.

I initially tried using Linux 2.4.1 kernel and it worked fine and the
board was up.
I upgraded to 2.4.17 and I found out that the system started hanging
during boot up.

I compiled 2.4.17 for ppc boot. (I already have ppc boot on my ADS board
and I test my development by tftp boot'ing the kernel image.

I tried tracking down where the hang could be and ended up at the RFI
instruction where its waiting to complete the MMU initialization. The
system executes SYNC instruction and then hangs. (arch/ppc/kernel/head.S)

I tried comparing the file head.S between 2.4.1 and 2.4.17. I found out
some patches done inside the 2.4.1 had been made generic. There were
patches for the BAT initialization and RAM mapping on the MPC8260.

Is there an update on the files?
Should the patches be done for 2.4.17 as well ?

Any suggestions or pointers could be very helpful.

[Running on x86 with Red Hat 8.0 and cross compiling for PPC.]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
