To: linuxppc-embedded@lists.linuxppc.org
From: Martin Egholm Nielsen <martin@egholm-nielsen.dk>
Subject: Re: Interrupt handling triggered by GPIO-input on 405EP?
Date: Tue, 18 May 2004 16:55:42 +0200
Message-ID: <40AA23EE.9080105@egholm-nielsen.dk>
References: <80908CC5B2C9DB47AAF8C77892FCB44315F780@lion.vector.com.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040600030407080809010605"
In-Reply-To: <80908CC5B2C9DB47AAF8C77892FCB44315F780@lion.vector.com.pl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040600030407080809010605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andriy,

>> I've done some initial coding with the ibmgpio driver with my
>> PPC405EP (PPChamelon) board, and inspired by the
>> "gpio_test.c"-application, I've succeeded in turning on some
>> attached LEDs on some of the ports
> can you please share code for manipulating LEDs on PPChameleon? I'm
> using the same board and it would be fine to have such possibility.
I've attached my source-file for turning on LEDs (indirectly) connected
to GPIO-pins 11,13 and 15 on the PPChamelon board.
First of all I created the /dev/gpio device by the command:

mknod /dev/gpio c 10 185

and then you can open and close the pins as you like. :o)

// Martin

--------------040600030407080809010605
Content-Type: text/plain;
 name="gpio_test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gpio_test.c"

#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

#include <linux/types.h>
#include <linux/ioctl.h>

#include <linux/ibm_ocp_gpio.h>

#define GPIO_DEV "/dev/gpio"

int main(int argc, char *argv[])
{
	/* Open the device */
	int fd = open("/dev/gpio", O_RDWR);

	struct ibm_gpio_ioctl_data gpio_ioctl;
	int result;
	int command;

	if(fd==-1) {
		fprintf(stderr,"Unable to open /dev/gpio\n");
		exit(1);
	}

	gpio_ioctl.device=0;

	/* Set IRQ4 pin (GPIO0_21) high - turn on LED */
	gpio_ioctl.mask=0x00000400;
	gpio_ioctl.data=0x00000400;
	ioctl(fd,IBMGPIO_OUT,(void *)&gpio_ioctl);

	/* Sleep 1 second */
	sleep(1);

	/* Set IRQ3-5 pin (GPIO0_20-GPIO0_22) high - turn on LEDs */
	gpio_ioctl.mask=0x00000E00;
	gpio_ioctl.data=0x00000E00;
	ioctl(fd,IBMGPIO_OUT,(void *)&gpio_ioctl);

	close( fd );

	return 0;
}

--------------040600030407080809010605--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
