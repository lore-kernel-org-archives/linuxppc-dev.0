Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AC49EC3.978D9A4A@snmc.com>
Date: Fri, 30 Mar 2001 08:57:07 -0600
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: ?????? <engineersong@hanmail.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 console problem on MPC860
References: <20010330095839.HM.30000000001Zxx8@www4.hanmail.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Daum,

I had problems trying to get the uart.c driver to do what you wanted as
well.  I don't think it was really meant to support both SCC and SMC at
the same time.  I ended up splitting the driver into two different
drivers, making one work just for the SCC, and the other only for the
SMC.  This works quite well.

The code is in the QSLinux release, which you can download from
ftp:://qslinux.org.  When you untar the kernel you can find the two
drivers in the directory snmc/qslinux/kernel/drivers/char.

Regards,
Daris Nevil


?????? wrote:
>
> Hi, all
> I am not used to write in English.
>
> I would like to use SCC3 as second console, and use SMC1 as first console.
> I ported denx kernel 2.4.3-pre4 into my 860 board.
> when I compiling, checked SCC3 for UART option in MPC8xx CPM option.
> SMC1(ttyS0) is connected to my linux box COM2, SCC3(ttyS1) is connected to COM1.
>
> After booting, in COM2 echo 1111 > /dev/ttyS1 result is shown in SCC3(ttyS1).
> so far good.
> but, COM1 port don't any receive keyboard key.
>
> In /arch/ppc/uart.c
> I modified CONFIG_SERIAL_CONSOLE_PORT for SCC3 console
>
> #if 1
> #undef CONFIG_SERIAL_CONSOLE_PORT
> #define CONFIG_SERIAL_CONSOLE_PORT      1
> #endif
>
> Is it enough to to make SCC3 console?
>
> Thanks for any comments and replyings.
>
> ==================================================
> 우리 인터넷, Daum
> 평생 쓰는 무료 E-mail 주소 한메일넷
> 지구촌 한글 검색서비스 Daum FIREBALL
> http://www.daum.net
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
