Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: 14 May 2003 15:27:00 +0800
Message-ID: <20030514152700.68497.qmail@eyou.com>
From: "rick.liu" <dovi@eyou.com>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: "rick.liu" <dovi@eyou.com>
Subject: Re: Why my console output nothing
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Wolfgang

Thanks for ur reply,in your message you wrote:
======= 2003-05-13 15:46:00 =======

>Dear Rick,
>
>
>Chances for useful  replies  are  much  better  in  the  u-boot-users
>mailing list instead.

Later I will try :-)

>
>Chances for useful replies would be even better  if  you  provided  a
>little more information. "modify several line of ..." is not really a
>precise description of what you did.
>

you mean it's not the problem of my console configuration but the u-boot
program?
But I thought it might at least output some message of the board before it can
output the prompt "=>",is that right? Listing all my chang in the TQM860L.h
may help:

#define	CONFIG_CLOCKS_IN_MHZ	50 /*50Mhz osc connected to 860_EXTCLK*/
#define CONFIG_BOARD_TYPES	0     /*It's a simple board ,supported?*/
#define CFG_OR0_PRELIM	0xfff80920  /*boot flash is AM29LV040B,512k*/
#define CFG_BR0_PRELIM	0x40000401  /* magic numbers of my modify take
                                       /*reference from a working vxworks
BSP's
                                       /* romInit.s of the same board*/

/* #define SDRAM_BASE2_PRELIM	0x00000000*/
#define SDRAM_BASE4_PRELIM	0x00000000  /*cs4 is sdram*/

#define CFG_OR4_PRELIM	0xfe000f60
#define CFG_BR4_PRELIM	0x00000081

#define CFG_MAMR_11COL	0x10924111 /*11 col,here is the value I write to mamr
in tqm8xx.c*/

#define CONFIG_SCC1_ENET	1 /*should add a number?*/
/*#define CONFIG_FEC_ENET*/ /*no FEC*/

and in tqm8xx.c,I did like this:

1.changed upm_table according to my sdram;
2.modify the register's value in the function initdram()


>
>Porting U-Boot to new hardware requires more  than  just  tweaking  a
>line  here  and there. It will require both an in-depth understanding
>of the hardware and U-Boot.
>

:-),I am trying to learn,would u  recommend some helpful material about
u-boot?

>
>Did you read the README that comes with U-Boot?
>
yes

>Finally: did you order your BDI2000 yet? You will  probably  need  it
>soon.

I know that,and I will try to persuade my "boss".

Best regards,
Rick Liu





--http://www.eyou.com
--稳定可靠的免费电子信箱  语音邮件  移动书签  日历服务  网络存储...亿邮未尽


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
