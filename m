Return-Path: <witcher@mindspring.com>
Received: from elasmtp-curtail.atl.sa.earthlink.net
	(elasmtp-curtail.atl.sa.earthlink.net [209.86.89.64])
	by ozlabs.org (Postfix) with ESMTP id 717DFDDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 10:09:40 +1000 (EST)
Received: from [209.86.224.29] (helo=mswamui-cedar.atl.sa.earthlink.net)
	by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <witcher@mindspring.com>) id 1K8lF5-0004oB-B3
	for linuxppc-dev@ozlabs.org; Tue, 17 Jun 2008 20:09:39 -0400
Message-ID: <21800186.1213747779368.JavaMail.root@mswamui-cedar.atl.sa.earthlink.net>
Date: Tue, 17 Jun 2008 20:09:39 -0400 (GMT-04:00)
From: Eric Witcher <witcher@mindspring.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: Question regarding mpic_assign_isu() in storcenter.c
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Eric Witcher <witcher@mindspring.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The answer is that mpic_assign_isu(mpic, 1, paddr + 0x11000) places the initial base register
for isu 1 on a reserved location in the PIC register map (see *).  I guess you can infer from this
that no badness occurs when you write to a reserved location on the PIC.

That aside, when you walk through mpic_init(), the resulting vector placement as a result of
the mpic_assign_isu() calls are consistent with the corresponding device tree.

isu     vector     register_offset     pic           device_tree (storecenter.dts)
0       0          0x10200             INT0/Serial 0
0       1          0x10220             INT1/Serial 1
0       2          0x10240             INT2/Serial 2
0       3          0x10260             INT3/Serial 3
0       4          0x10280             INT4/Serial 4
0       5          0x102A0             Serial 5
0       6          0x102C0             Serial 6
0       7          0x102E0             Serial 7
0       8          0x10300             Serial 8
0       9          0x10320             Serial 9
0       10         0x10340             Serial 10
0       11         0x10360             Serial 11
0       12         0x10380             Serial 12
0       13         0x103A0             Serial 13
0       14         0x103C0             Serial 14
0       15         0x103E0             Serial 15

1       16         0x11000             Reserved*
1       17         0x11020             I2C           i2c@3000
1       18         0x11040             DMA 0
1       19         0x11060             DMA 1
1       20         0x11080             Reserved
1       21         0x110A0             Reserved
1       22         0x110C0             Message unit
1       23         0x110E0             Reserved 
1       24         0x11100             Reserved
1       25         0x11120             DUART 1       serial0
1       26         0x11140             DUART 2       serial1
1       27         0x11160             Reserved
1       28         0x11180             Reserved
1       29         0x111A0             Reserved
1       30         0x111C0             Reserved
1       31         0x111E0             Reserved
