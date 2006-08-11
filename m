Return-Path: <Vipin.Malik@EmersonProcess.com>
Received: from NAOUT-CINEXS02.nasmtpout.emrsn.com
	(naout-cinexs02.nasmtpout.emrsn.com [67.96.16.12])
	by ozlabs.org (Postfix) with ESMTP id A005067B61
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 11:02:47 +1000 (EST)
Subject: Problem with SCC uart in UART mode on mpc8270 w/ Linux-2.6.17.6
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 10 Aug 2006 19:55:34 -0500
Message-ID: <E52B7395D85BAD46B0BC59D3324B9EF7010D8270@ushou-exm01.na.emersonprocess.com>
From: <Vipin.Malik@EmersonProcess.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to use the SCC1 in uart mode on a MPC8270 under 2.6.17.4 from
kernel.org

I've turned on all SCC uarts and I can send and rx data but have an
issue:
The first time I open the port (ttyCPM2) by "cat /dev/ttyCPM2" and "cat
>/dev/ttyCPM2"
I can tx and rx fine.

The problem occurs when I close the first cat session and open it again.

This time, my TX has some sort of threshold in it. It seems that only
after a few 10's of bytes have been sent to the port (the fifo size?
Need to
check) does the scc actually send the data. After that it's all ok.

However, my rx never works after the 1st port open.

Console is on SMC1 and works fine all the time.

I'm using non-platform mode (whatever I tried to do in platform mode, my
SMC1 console stopped working/board stopped working. I would not get any
output after u-boot starts the kernel- not even the Linux version
string).

Any ideas?

TIA

Vipin
P.S. I had to hack the compat code to get the BRG's wired properly for
the SCC's, but the SCC works the 1st time and tx works (besides the
threshold
 issue)- so I don't think that is the cause.

I also tried to get platform code working, but not luck. Is there any
 document or email anywhere I can read that explains that setup?
