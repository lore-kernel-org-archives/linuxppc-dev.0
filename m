From: laurent.mohin@acterna.com
To: weiwu <weiwu@isdn.iscas.ac.cn>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <C1256B8B.002BE475.00@magnus.eni.wago.de>
Date: Fri, 29 Mar 2002 08:53:00 +0100
Subject: Re: UPM works for 16MB PC SDRAM but fails for 32MB memory
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I don't know the exact organisation of your SDRAMs, but you probably have a
problem with the MPC addresses you use to make the bank selection.
I guess you use two 16 bits devices of 8M to reach the 16MB size. With the
organisation you described, you use an address size of 21 bits (MPC A29-A9). So
you can use  MPC A8 and A7 for bank select.
But, if you plan to extend your SDRAM size to 32 MB (I guess you will use two 16
M devices), you have to use MPC A7 and A6 for bank select.

Hope it helps,

Laurent




weiwu <weiwu@isdn.iscas.ac.cn> on 29/03/2002 02:38:19

To:   "linuxppc-embedded@lists.linuxppc.org"
      <linuxppc-embedded@lists.linuxppc.org>
cc:
Subject:  UPM works for 16MB PC SDRAM but fails for 32MB memory




I have bootrom code (ppcboot) for which I have UPM values with which I
can access the 16MB PC SDRAM okay but for 32MB memory
my bootrom fails to execute out of RAM.

software: Now I have modifyed the AMA and MAMR registers,but it still not work!

Hardware:
My board uses two HY57V281620A SDRAMS and it's configuration is 4 Banks x 2M x
16bits, 12 rows and 9 column.

MPC SDRAM
=========
A29 A0
A28 A1
A27 A2
A26 A3
A25 A4
A24 A5
A23 A6
A22 A7
A21 A8
A20 A9
GPL_A0 A10
A18 A11

A7 BA0
A8 BA1
OE_GPL_A1 RAS
GPL_A2 CAS
GPL_A3 WE

What do I have to do get 32MB memory going?
Thanks!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
