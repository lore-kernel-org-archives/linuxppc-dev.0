Return-Path: <stevan@iritel.com>
Received: from iritel.iritel.bg.ac.yu (iritel.iritel.bg.ac.yu [193.203.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FCB6682F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 01:21:57 +1000 (EST)
Received: from iritel (root@localhost)
	by iritel.iritel.bg.ac.yu (8.13.1/8.13.1) with SMTP id j8KFFuFS017032
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Sep 2005 17:15:56 +0200
Received: from [193.203.19.118] (stevan [193.203.19.118])
	by iritel.iritel.bg.ac.yu (8.13.1/8.13.1) with ESMTP id j8KFFuSo017027
	for <linuxppc-embedded@ozlabs.org>; Tue, 20 Sep 2005 17:15:56 +0200
From: Stevan Ignjatovic <stevan@iritel.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <1127229408.3932.40.camel@stevan.iritel.co.yu>
Mime-Version: 1.0
Date: Tue, 20 Sep 2005 17:16:48 +0200
Subject: MPC8250 MCC operating on 2-bit channels
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

My problem is concerned with the multi channel controller MCC2 on
MPC8250. Its task is to relay messages from D channels between Local
Exchange and ISDN BRA subscribers. All active D channels (up to 128) are
aggregated into single stream tied directly to the TDMc2, ie. both
TDMc2_Rx and TDMc2_Tx are divided into 2-bit channels. 2.048MHz clock
and 8KHz frame pulse are generated externaly and are connected to
corresponding processor pins (common pins for receive and transmit
sections).

When tested with internal loopback (SI2MR[SDM2]=0b10) everything works
fine, ie. for example the message we send through channel 0 is received
correctly on channel 0. However, it doesn't work in real application.

The debugging process led me to this simple test. I connected TDMc2_Rx
and TDMc2_Tx to FPGA in which I implemented the delay of N frames (N x
125us, since the frame pulse is 8KHz), such that for N=0 I have simple
external loopback, for N=1 delay of one entire frame, and so on. I was
sending messages through channel 0 (it is the only channel I actually
started). The results I obtained were very strange. For N=0, N=4, N=8
the received message was correct, but for N=1,2,3 it was not (I was
usually reported CRC erro,r or non octet alignment error, or abort).When
I tried with 4-bit channels, the result was correct for N=0,2,4,....
Only with 8-bit channels I obtained correct result for all frame delays.
The fact that everything works fine with 8-bit channels makes me believe
that all MCC and SIRAM settings are ok. I tried many combinations of
SIRAM programming (For example, I tried to program only channel 0 as
2-bit and all others as 8-bit, or as null entries), but it didn't work
out. It is also worth to mention that I have never received GUN or GOV
errors. 

Has anybody dealt with 2-bit channels on MCC? What can cause such
problems (remember that everything works fine with 8-bit channels). I
would also appreciate if somebody has the possibility to implement
similar test.

Regards,
Stevan 
