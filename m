MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: monochromatic lcd on mpc823
Date: Thu, 21 Feb 2002 17:04:30 -0300
Message-ID: <7B3538F053C06142BF0AA9DF2D764AC6064305@MAILSRV1.aquarius.cpqd.com.br>
From: "Sergio Massami Sakai" <Sakai@cpqd.com.br>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

Have someone tried to set the lcd controller driver for MPC823 to use a monochromatic lcd?
I´m trying to do that, initially with 1bit/pixel mode, but I had some problems.

I´ve created a configuration for my LCD and changed the SCCR to set the clock. The sync signals are OK for this display now.
The problem is: I tried to set some pixels in the framebuffer but I´ve got no response in the LCD interface data pins.

Looking at the color map default configurations I think that there isn´t specific configurations for monochrome operation modes.
I tried to change my color map according to the MPC823 reference manual but nothing hapenned.

Does anyone have some idea about what could be the problem?

I´m using denx kernel 2.4.4-2001-05-12 and a FADS board.
I´m a newbie at Linux framebuffer programming (and at Linux kernel programming...) so it´s possible that I´m doing something wrong in my test.
I´m using an extremely simple program to test the LCD controller output (just fill all fb bits with 0 or 1) as follows.
The data pins are always low, except FD0 that is always high (device open/close, fb filled with 0/1)

PS: I had some doubts about the MPC823 LCD controller manual. I´m not sure if each bit (or 2-4.. bit group), representing a pixel, is in a separated word or not (ex. for 8 pixels in 2 bits/pixel mode are represented in the framebuffer: 1111111111111111 or 0000000000000011, 0000000000000011,....). I´m working with the "not separated words" hypothesis.

************************************************************

#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>

#ifndef bool
#define bool unsigned char
#endif
#ifndef FALSE
#define FALSE 0
#endif
#ifndef TRUE
#define TRUE 1
#endif


int fbfd = 0;
struct fb_var_screeninfo vinfo;
struct fb_fix_screeninfo finfo;
long int screensize = 0;
char *fbp = 0;
long int location = 0;

bool open_dev() {
	/* Open the file for reading and writing */
	fbfd = open("/dev/fb0", O_RDWR);
	if (!fbfd) {
		printf("Error: cannot open framebuffer device.\n");
		return FALSE;
	}
	printf("The framebuffer device was opened successfully.\n");
	return TRUE;
} /* open_dev */

void close_dev() {
	munmap(fbp, screensize);
	close(fbfd);
} /* close_dev */

bool get_info() {
	/* Get fixed screen information */
	if (ioctl(fbfd, FBIOGET_FSCREENINFO, &finfo)) {
		printf("Error reading fixed information.\n");
		return FALSE;
	}
	/* Get variable screen information */
	if (ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo)) {
		printf("Error reading variable information.\n");
		return FALSE;
	}
	/* Figure out the size of the screen in bytes */
	screensize = (vinfo.xres * vinfo.yres * vinfo.bits_per_pixel) / 8;
	return TRUE;
} /* get_info */

bool get_map() {
	/* Map the device to memory */
	fbp = (char *)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED,
		fbfd, 0);
	if ((int)fbp == -1) {
		printf("Error: failed to map framebuffer device to memory.\n");
		return FALSE;
	}
	printf("The framebuffer device was mapped to memory successfully.\n");
	printf("fbp: %d\n",(int)fbp);
	return TRUE;
} /* get_map */


void fill_map_char(unsigned int size,char value) {
	int i;
	for (i=0;i<size;i++)
		fbp[i] = value;
} /* fill_map_char */

void print_menu() {
	printf("MENU:\n");
	printf("1-Init\n");
	printf("2-Fill 0\n");
	printf("3-Fill 1\n");
	printf("4-Exit\n");
} /* print_menu */

bool choice_menu() {
	char opt;
	bool open = FALSE;
	scanf("%c",&opt);
	switch(opt){
		case '1':	//init
			open_dev();
			get_info();
			get_map();
			break;
		case '2':	//0
			if (open)
				fill_map_char(screensize,(char)0x00);
			break;
		case '3':	//1
			if (open) {
				fill_map_char(screensize,(char)0xFF);
			}
			break;
		case '4':	//exit
			if (open)
				close_dev();
			return FALSE;
		case '\n' :
		default :
			break;
	}
	return TRUE;
} /* choice_menu */

int main()
{
	print_menu();
	while (choice_menu()) {}

	return 0;
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
