Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id E82FE2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Dec 2004 05:44:52 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6473C0@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>
Date: Mon, 20 Dec 2004 13:44:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: etux@embeddedtux.org, LM Sensors <sensors@stimpy.netroedge.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: 2.6.10-rc3 for 8xx with I2C config enabled  compiles now ...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tom,

I have made the following configuration being "compilable" on 2.6.10-rc3
*********** .config ************
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
.........
CONFIG_I2C_ALGO8XX=y

#
# I2C Hardware Bus support
#
..............
CONFIG_I2C_RPXLITE=y
............
#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
.............
*********** .config ************

by following changes:

1) i2c-algo-8xx.h is copied from 2.4(.26) and placed into
./include/linux/i2c-algo-8xx.h

2) i2c-algo-8xx.c is copied from 2.4(.26) and placed into
./drivers/i2c/algos/i2c-algo-8xx.c

3) added into ./drivers/i2c/algos/Makefile 
   after existing line:
   obj-$(CONFIG_I2C_ALGOITE)       += i2c-algo-ite.o
   the following new line:
   obj-$(CONFIG_I2C_ALGO8XX)       += i2c-algo-8xx.o

4) added into ./include/asm-ppc/commproc.h
   after existing line:
   extern void cpm_free_handler(int vec);
   the following new line:
   extern const char *cpm_int_name[];

5) in ./drivers/i2c/busses/i2c-rpx.c
   changed the order of include files: 
   moving the line:
   #include <asm/commproc.h>
   to be above the line:
   #include <linux/i2c-algo-8xx.h>

   so now includes are in the following order:
   ...
#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/stddef.h>
#include <linux/i2c.h>
#include <asm/commproc.h>
#include <linux/i2c-algo-8xx.h>
#include <asm/mpc8xx.h>
   ...
 
Thanks,
Alex 
-----Original Message-----
From: Tom Rini [mailto:trini@kernel.crashing.org]
Sent: Friday, December 17, 2004 12:09 PM
To: Povolotsky, Alexander
Subject: Re: 2.6.10-rc3 for 8xx with I2C config enabled still fails ...


On Fri, Dec 17, 2004 at 11:58:30AM -0500, Povolotsky, Alexander wrote:

So, your best bet to get 8xx I2C working is to grab the 'latest' from a
2.4 tree that has it working, and move it up.  In doing so, you may want
to kill 'i2c-rpx' and merge it all into the i2c-algo-8xx file.
So, I've attached the newest i2c-algo-8xx.h I can find.  The rest of the
code that's in 2.6 is probably good enough.  With this, hopefully you
can hack things into working (if you need a very simple i2c test
program, let me know.  I _think_ i have one around that should give you
the temp info found at least on my old rpxlite).

-- 
Tom Rini
http://gate.crashing.org/~trini/
