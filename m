Return-Path: <yusdisantoso@yahoo.com>
Received: from web40907.mail.yahoo.com (web40907.mail.yahoo.com
	[66.218.78.204]) by ozlabs.org (Postfix) with SMTP id 32BAA2BD71
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Sep 2004 12:44:00 +1000 (EST)
Message-ID: <20040914023719.66560.qmail@web40907.mail.yahoo.com>
Date: Mon, 13 Sep 2004 19:37:19 -0700 (PDT)
From: Yusdi Santoso <yusdisantoso@yahoo.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: MPC52xx IDE driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am currently debugging IDE driver for MPC5xxx based
board (the exact board is Lite5200 with MPC5200
processor from Motorolla). The file I am touching is 
"drivers/ide/mpc5xxx_ide.c". 

My problem is that I can't make the DMA on ATA-IDE
harddisk to work. When I compile with DMA enabled, the
system will stop and after a while timeout with error.
 These are the messages during bootup if the debug
flag is turned on:

> SDMA setup @00313000, l: 1000, nextbd: 0 !
> MAchine check in kernel mode.
> Caused by (from SSR1=41000): Transfer error ack
signal
> Oops: machine check, sig: 7
...dump info then kernel panic...

When I trace through the code, I found that
"mpc5xxx_ide_continue_dma()" always return 0. There
are only two exits from the function and both return
0. The problem is that the return value is checked
inside "mpc5xxx_ide_build_table", if 0 is returned it
goes to error. Is this intentional? 

Even if I modify one of the exit code to 1, the system
still can't run the DMA properly. On running "fdisk",
the program complained that the partition format is
wrong. I guess this is because the driver does not
work properly ??

Any help will be appreciated.

Thanks,


Yusdi

=====




		
__________________________________
Do you Yahoo!?
Yahoo! Mail Address AutoComplete - You start. We finish.
http://promotions.yahoo.com/new_mail 
