Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C5A9DE1F5
	for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2008 01:43:53 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m4QFhlNE019854
	for <linuxppc-dev@ozlabs.org>; Mon, 26 May 2008 17:43:48 +0200
Message-ID: <0b5701c8bf47$49219520$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Still struggling with Xilinx GPIO...
Date: Mon, 26 May 2008 17:43:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I still haven't managed to figure out how to use the Xilinx GPIO from 
usermode.

The program gpio_test found at 
http://www.itee.uq.edu.au/~listarch/microblaze-uclinux/archive/2004/05/msg00004.html 
and slightly modified as this:

#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

#include <linux/types.h>
#include <sys/ioctl.h>

#include <xgpio_ioctl.h>

#define GPIO_DEV "/dev/xgpio"

void usage(int argc, char *argv[])
{
        fprintf(stderr,"usage: %s hexval\n\n", argv[0]);
        fprintf(stderr,"\n");
        fprintf(stderr,"Puts the input hexval onto the LEDs, and\n");
        fprintf(stderr,"displays the current value on the DIP switches\n");
        fprintf(stderr,"\n");
        fprintf(stderr,"try  gpio_test FC\n\n");

}

void dump_dipsw(int val)
{
        int i;
        val = (val & 0x000000FF);

        printf("DIP SW: ");
        for(i=0;i<8;i++)
        {
                printf("%i",val & 0x01);
                val >>= 1;
        }
        printf("\n");
}

/* Turn 4 LSB of X into 8 bit LED segment code */
unsigned char nyb_hex2led(int x)
{
        unsigned char led_tab[] = {
                0xFC, 0x60, 0xDA, 0xF2,
                0x66, 0xB6, 0xBE, 0xE0,
                0xFE, 0xF6, 0xEE, 0x3E,
                0x9C, 0x7A, 0x9E, 0x8E};

        return led_tab[x & 0xF];
}

/* Turn 8 LSB of x into 2 times 8 bit LED segment codes */
unsigned short hex2led(int x)
{
        return (nyb_hex2led(x & 0xF) << 8) | (nyb_hex2led((x >> 4) & 0xF));
}

int main(int argc, char *argv[])
{
        /* Open the device */
        int fd = open(GPIO_DEV, O_RDWR);

        struct xgpio_ioctl_data gpio_ioctl;
        // struct ibm_gpio_ioctl_data gpio_ioctl;
//      int     result;
//      int command;

        if(fd==-1) {
                fprintf(stderr,"Unable to open %s\n", GPIO_DEV);
                return -1;
        }

/*
        if(argc!=2)
        {
                usage();
                exit(1);
        }
*/
        gpio_ioctl.chan=0;

        /* Set the tristates */
        gpio_ioctl.mask=0x000000FF;
        ioctl(fd, XGPIO_TRISTATE,(void *)&gpio_ioctl);

        /* Get output data from command line if provided */

        if(argc==2)
                sscanf(argv[1],"%x",&(gpio_ioctl.data));
        else
                gpio_ioctl.data=time(NULL);

        /* Convert binary (16 LSB) into LED segment codes and shift into
           position on gpio */
        gpio_ioctl.data=hex2led(gpio_ioctl.data & 0xFF)<<8;

        ioctl(fd, XGPIO_OUT,(void *)&gpio_ioctl);

        /* Read some data */
        ioctl(fd, XGPIO_IN,(void *)&gpio_ioctl);

        dump_dipsw(gpio_ioctl.data);

        return 0;
}


...crashes in flames when run:

# gpio_test FC
[ 1366.864955] Oops: kernel access of bad area, sig: 11 [#5]
[ 1366.867560] NIP: c0108d50 LR: c00e68c4 CTR: 00000000
[ 1366.867560] REGS: c752fde0 TRAP: 0300   Tainted: G      D   (2.6.25-rc9)
[ 1366.867560] MSR: 00029030 <EE,ME,IR,DR>  CR: 93000033  XER: e000007f
[ 1366.867560] DEAR: c8fffffc, ESR: 00000000
[ 1366.867560] TASK = c7c37030[202] 'gpio_test' THREAD: c752e000
[ 1366.867560] GPR00: 00000000 c752fe90 c7c37030 c8fffffc 00000056 0000000c 
c752feb0 00000000
[ 1366.867560] GPR08: 00000000 11111111 ffffffe7 c7c5866c 00000000 10018dec 
ffff8432 ffdf1d0f
[ 1366.867560] GPR16: ffffffff ffffffff ffffffff ffffffff ffffffff 00000000 
100af244 10000858
[ 1366.867560] GPR24: 10000c00 00000002 10000478 800c5a03 c7c58000 c7c5866c 
800c5a03 c0200000
[ 1366.867560] NIP [c0108d50] XIo_In32+0x4/0xc
[ 1366.867560] LR [c00e68c4] XGpio_GetDataDirection+0x84/0xac
[ 1366.867560] Call Trace:
[ 1366.867560] [c752fe90] [c00e66a8] xgpio_getinst+0x48/0xb0 (unreliable)
[ 1366.867560] [c752fea0] [c00e6a8c] xgpio_ioctl+0x1a0/0x1fc
[ 1366.867560] [c752fed0] [c006740c] vfs_ioctl+0x6c/0x84
[ 1366.867560] [c752fee0] [c006778c] do_vfs_ioctl+0x368/0x39c
[ 1366.867560] [c752ff10] [c0067800] sys_ioctl+0x40/0x70
[ 1366.867560] [c752ff40] [c0002770] ret_from_syscall+0x0/0x3c
[ 1366.867560] Instruction dump:
[ 1366.867560] 7c634b78 7c031b78 4e800020 7c0006ac 88630000 5463063e 
4e800020 7c0006ac
[ 1366.867560] a0630000 5463043e 4e800020 7c0006ac <80630000> 4e800020 
7c0006ac 7c601e2c
Segmentation fault


# dmesg | grep gpio
[    0.120666] Registering device xilinx_gpio:0
[    0.121672] Registering device xilinx_gpio:1
[    0.122682] Registering device xilinx_gpio:2
[    0.292352] xgpio0 #0 at 0x81400000 mapped to 0xC9000000 device: 10,185 
using IRQ#7
[    0.293805] xgpio1 #1 at 0x81420000 mapped to 0xC9020000 device: 10,186 
using IRQ#6
[    0.295062] xgpio2 #2 at 0x81440000 mapped to 0xC9040000 device: 10,187 
using IRQ#5
[ 1366.867560] TASK = c7c37030[202] 'gpio_test' THREAD: c752e000
[ 1366.867560] [c752fe90] [c00e66a8] xgpio_getinst+0x48/0xb0 (unreliable)
[ 1366.867560] [c752fea0] [c00e6a8c] xgpio_ioctl+0x1a0/0x1fc



Another program using a different strategy also fails:

#include <fcntl.h>
#include <stdio.h>

int main (int argc, char *argv[]) {
 if (argc==2 || argc==3) {

  int fd = open(argv[1], O_RDWR | O_NDELAY );
  if (fd < 0) {
     fprintf(stderr, "GPIO OPEN FAIL\n");
     return -1;
  }

  unsigned long buff = 0;
  if (argc==2) {
   if (read(fd, &buff, 4) != 4)
      fprintf(stderr, "GPIO READ ERROR\n");
   else printf( "%x\n", buff);
  } else {
   buff=atoi(argv[2]);
   if (write(fd, &buff, 4) != 4)
      fprintf(stderr, "GPIO WRITE ERROR value %x\n", buff);
   else printf( "Written %x successfully\n", buff);
  }

  close(fd);
 } else {
  fprintf(stderr, "Usage: %s device [value] to read or write data to gpio 
device\n", argv[0]);
  return 1;
 }

 return 0;
}


# GpioReadWrite /dev/xgpio
GPIO READ ERROR
# GpioReadWrite /dev/xgpio 7
GPIO WRITE ERROR value 0

I wanted to avoid writing a kernel module, but apparently I've ran out of 
options...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
