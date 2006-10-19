Return-Path: <rainer.poisel@kirchnersoft.com>
Received: from mxs.KSOFTCOM (ksow-gw.kirchnersoft.com [80.122.131.238])
	by ozlabs.org (Postfix) with ESMTP id 3715D67B9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 01:21:19 +1000 (EST)
Message-ID: <F05B338A1B21D9119FFF0004761A51136AB28E@exchange-server.ow.ks>
From: RPo <rainer.poisel@kirchnersoft.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: MPC5200 (Board: PM520) I2C Problem
Date: Thu, 19 Oct 2006 17:05:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm currently using the MPC5200 based board "PM520" and 
want to access the I2C bus. To do so, I attached a PCF8574P
to the bus. But I was not successful in setting the outputs
of this IC. 

Here is the code with which I tried to access the bus:
8<==================================================
  int i2c = 0, i = 0xfffffff;
  i2c = open("/dev/i2c-0",O_RDWR);
  if(i2c > 0)
    RT_TRACE(printf("I2C opened successfully.\n"));
  else
    RT_TRACE(printf("Error: I2C could not be opened.\n"));
  ioctl(i2c, I2C_SLAVE, 0x46);
  write(i2c, &i, 1);
8<==================================================

The open() and ioctl() calls are successful (checked with 
strace) but the write() call always returns -1 and an 
EREMOTEIO error. The device nodes have been created this way:

8<==================================================
mknod /dev/i2c-0 c 89 0
mknod /dev/i2c-1 c 89 1
chmod 666 /dev/i2c-*
8<==================================================

So here is my configuration:

Linux 2.4.25 (ELDK 3.1.1-2005-06-07)

The I2C modules were compiled after I had made some changes
to the i2c-pm520.c file in the kernel-tree:

8<================== ORIGINAL ======================
/* #define MPC5xxx_I2C1_ENABLE  0 */    /* Disabled     */
8<================== ORIGINAL ======================

8<================== MODIFIED ======================
#define MPC5xxx_I2C1_ENABLE     1       /* Enabled      */
8<================== MODIFIED ======================

I was unsure about the bus my code uses and so I decided to
enable both busses. These are the printks I get, when I load 
the modules:

8<==================================================
# /ftp/sbin/insmod ./i2c-core.o
i2c-core.o: i2c core module version 2.6.1 (20010830)
# /ftp/sbin/insmod ./i2c-proc.o
i2c-proc.o version 2.6.1 (20010830)
# /ftp/sbin/insmod ./i2c-dev.o
i2c-dev.o: i2c /dev entries driver module version 2.6.1 (20010830)
# /ftp/sbin/insmod ./i2c-algo-mpc5xxx.o speed=85
# /ftp/sbin/insmod ./i2c-pm520.o
i2c-algo-5xxx.o: scanning bus PM520 I2C module #1 interface...
............................................................................
....
................................................
i2c-pm520.o: I2C module #1 installed
i2c-algo-5xxx.o: scanning bus PM520 I2C module #2 interface...
............................................................................
....
.(0x51)......(0x58)(0x59)(0x5a)(0x5b)(0x5c)(0x5d)(0x5e)(0x5f)...............
....
............(0x7f)
i2c-pm520.o: I2C module #2 installed
8<==================================================

So, what are these identifiers on I2C module #2 interface? 
I can neither find them in the documentation of the EEPROM
nor the one of the realtime clock. write() calls to these
IDs are succesful, but it seems like nothing happens. The
same is for the other bus (module #1 interface).

Has anyone an idea or experience with I2C bus on the MPC5200?
Best regards and thanks for reading,
Rainer
