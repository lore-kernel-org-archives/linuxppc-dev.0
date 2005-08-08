Return-Path: <deboralh@fel.com.cn>
Received: from sina37-40.sina.com.cn (sina37-40.sina.net [202.108.37.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "securemail.sina.net",
	Issuer "VeriSign Trust Network" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0373467F1E
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 11:49:20 +1000 (EST)
Date: Mon, 8 Aug 2005 09:53:32 +0800
From: "Debora Liu" <deboralh@fel.com.cn>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Message-Id: <20050808014920.0373467F1E@ozlabs.org>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: Re: Volunteers to test i2c-algo-8xx on v2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Marcelo Tosatti

In message <2005-08-07 08:34:52 marcelo.tosatti@cyclades.com> you wrote:
>
>Does anyone volunteer to test this 8xx i2c driver?
>
>
I don't have kernel v2.6, but I have test my board with eldk-3.1.1 linux-2.4.25
when my board kernel booting, I found one problem.
eldk-3.1.1 linux-2.4.25 kernel include i2c, i2c-algo-8xx, pcf8563 driver.
If one pcf8563 chip on my board, there are't problem.
But if my board don't have pcf8563 chip, kernel stop as blow:
Linux version 2.4.25 (liu@bighead) (gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9))
#4 励 7埖 29 12:19:14 CST 2005
m8xx_setup.c:Reserved 0x10000 memory at 0xc0190000
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nftla1 ip=192.168.0.207:192.168.0.82:::sc855t:eth
0:off
Decrementer Frequency = 300000000/60
Warning: real time clock seems stuck!
Calibrating delay loop... 79.66 BogoMIPS
========= HZ=100   loops_per_jiffy=398336
Memory: 30752k available (1144k kernel code, 356k data, 56k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
WDT_8xx: SWT not enabled by firmware, SYPCR=0xffffff88
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
      Starting kswapd
Journalled Block Device driver loaded
i2c-core.o: i2c core module version 2.6.1 (20010830)
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
i2c-algo-8xx.o: i2c mpc8xx algorithm module version 2.6.1 (20010830)
i2c-rpx.o: i2c MPC8xx module version 2.6.1 (20010830)
i2c-proc.o version 2.6.1 (20010830)
CPM UART driver version 0.04
ttyS0 at 0x0280 is on SMC1 using BRG1
ttyS1 at 0x0380 is on SMC2 using BRG2
pty: 256 Unix98 ptys configured
PCF8563 Real-Time Clock Driver $Revision: 1.3 $ wd@denx.de



I modify i2c-algo-8xx.c cpm_iic_write(), then no problem,
my board defined by CONFIG_SVM8xx

#ifdef CONFIG_SVM8xx
    while(!(i2c->i2c_i2cer & 0x12))
      if (time_after(jiffies, tmo)) {
        tmo = 0;
        break;
      }
#else
                while(!(i2c->i2c_i2cer & 0x12 || time_after(jiffies, tmo))); /* Bus
#endif



= = = = = = = = = = = = = = = = = = = =
				 
　　　　　　　　Debora Liu
　　　　　　　　deboralh@fel.com.cn
　　　　　　　　　　2005-08-08
