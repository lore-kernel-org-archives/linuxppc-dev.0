Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3F30D5BC.9070400@devcom.cz>
Date: Wed, 06 Aug 2003 12:17:32 +0200
From: Jan Damborsky <jan.damborsky@devcom.cz>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Console on frame buffer for mpc823
References: <20030806090042.4CF44C59E4@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Wolfgang,
primarily thank you for your help. But I have not
been lucky to solve my problem. May be I have
old kernel version - 2.4.3.

>>I use custom board with MPC823 and TFT display
>>connected directly to TFT processor interface.
>>I would like to use display as console on framebuffer
>>when booting and running Linux.
>>
>>
>...
>
>
>>How to make kernel use console on /dev/fb/0 ?
>>
>>
>
>You have to configure the kernel to use the  framebuffer  as  console
>device. Check especially the following configuration options:
>
>	CONFIG_FB=y
>	CONFIG_DUMMY_CONSOLE=y
>	CONFIG_FBCON_ADVANCED=y
>	CONFIG_FBCON_CFB8=y
>	CONFIG_FBCON_FONTS=y
>	CONFIG_FONT_8x8=y
>	CONFIG_FONT_8x16=y
>	CONFIG_VT=y
>	CONFIG_VT_CONSOLE=y
>	CONFIG_CONSOLE_NOBLANK=y
>	CONFIG_CONSOLE_NOCUR=y
>
I have set all this CONFIGS_xxx except for CONFIG_CONSOLE_NOBLANK and
CONFIG_CONSOLE_NOCUR which are not supported in this kernel version.

>
>Also, see the FAQ at
>http://www.denx.de/twiki/bin/view/DULG/NoInputUsingFramebuffer
>
I have tried *console=tty0* and *console=tty* on command line,
but output is always on *ttyS0* serial console even
during booting message *Console: switching to frame buffer device*
appears.
When trying *cat /etc/group > /dev/tty*, it is send to serial line. Is
it correct ?
How to test that frame buffer is assigned to text console ?

BTW:
[1] CONFIG_SERIAL_CONSOLE is set - it is hardwired
     to CONFIG_8xx - may be it is problem - isn't it ?

                                      Thanks for help , HANYS


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
