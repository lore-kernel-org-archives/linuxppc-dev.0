Return-Path: <vijay_padiyar@hotmail.com>
Received: from hotmail.com (bay1-dav14.bay1.hotmail.com [65.54.244.118])
	by ozlabs.org (Postfix) with ESMTP id E89EA67A67
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 18:57:00 +1100 (EST)
Message-ID: <BAY1-DAV14F92D2B45266ECD1105A48B540@phx.gbl>
From: "Vijay Padiyar" <vijay_padiyar@hotmail.com>
To: "Yuli Barcohen" <yuli@arabellasw.com>,
	"LinuxPPC Support" <linuxppc-embedded@ozlabs.org>
Date: Sat, 12 Mar 2005 13:27:26 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: problem opening I2C device on MPC8260
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there

I am running Linux-2.6.10 with BusyBox 1.0 on an MPC8260-based target. I'm
having problems opening the I2C controller device on the MPC8260.

I have now included I2C support in the kernel by setting the following
options:

CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

CONFIG_I2C_ALGOBIT=y

None of the options under "I2C Hardware Bus support" and "Hardware Sensor
Chip support" are set. Do I need to enable any of these for MPC8260?

I have also mounted the Sysfs filesystem using 'mount -t sysfs sysfs /sys'.
When the kernel boots up, I can see the following message:

"i2c /dev entries driver"

which is from the I2C module initialization function i2c_dev_init() in
i2c-dev.c. This means that the I2C module has been loaded and initialized
correctly. However, the /sys/class/i2c-dev folder is found to be *empty*.

I have also created the following I2C device files in my /dev folder:

mknod i2c-0 c 89 0
mknod i2c0 c 89 0
mknod i2c-1 c 89 1
mknod i2c1 c 89 1

When I try to open the I2C device from a user program in root mode, I get an
error and the value of errno is ENODEV.

if ((fd = open("/dev/i2c-0", O_RDWR)) < 0)
{
    printf ("Error: ");

    if (errno == ENODEV)
        printf ("No such device!\n");
}

Please tell me what I could be doing wrong? Is there anything I've missed in
setting up my configuration to use I2C? Is there anything more I need to do?

Regards

Vijay Padiyar

http://www.vijaypadiyar.eu.tf
