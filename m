Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC06064@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Configure 8xx_io in 2.4.21-pre3
Date: Tue, 14 Jan 2003 11:06:19 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Xiaogeng...

Here are some things I would check :

1.) I recommend start with UART only build of the kernel first

2.) Did you check that your PA,PB,PC, and PD pins are set up properly ...

I my custom board had pins moved for things like enet on SCC ? However
normally I believe SMC1 only can be on one pair of pins for a UART ...
another

3.) Another thing to look at is your BRG clock for your board ... in my
kernel I found mvista didn't look at the some parts of the hardware reset
word that divide down my 80 Mhz reference intenerally before it goes to the
brg ... I was really surprised this code wasn't there ...


Good luck,
Jim

-----Original Message-----
From: Xiaogeng (Shawn) Jin [mailto:xjin@redswitch.com]
Sent: Tuesday, January 14, 2003 12:08 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Configure 8xx_io in 2.4.21-pre3


The 8xx CPM configuration in 2.4.4 release from DENX has more options
than any other release, including 2.4.21-pre3. For example,
CONFIG_SMC1_UART is in 2.4.4 (DENX). My board uses SMC1 as UART. I
almost needn't to change anything in 2.4.4-denx to make my 8xx CPM
working. I'm trying to migrate the kernel to 2.4.21 and the kernel is
stuck in my_console_write() and no any message is shown on the console.
So I think the problem is in CPM settings. I enabled the following
configuations for MPC8xx CPM.
CONFIG_FEC_ENET=y
CONFIG_USE_MDIO=y
CONFIG_FEC_LXT971=y
CONFIG_8xx_COPYBACK=y
CONFIG_UCODE_PATCH=y

How can I set CPM correctly in 2.4.21? Any hints are greatly appreciated.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
