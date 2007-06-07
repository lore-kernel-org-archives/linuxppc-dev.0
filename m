Return-Path: <C.vdKruit@fugro.nl>
Received: from smtp.eu2.fugro.com (smtp.eu2.fugro.com [212.189.46.152])
	by ozlabs.org (Postfix) with ESMTP id DF126DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 17:06:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC8272 LPT support
Date: Thu, 7 Jun 2007 09:06:40 +0200
Message-ID: <C89EFD3CD56F64468D3D206D683A8D22351BE6@ldam-msx2.fugro-nl.local>
In-Reply-To: <4666DB52.2020807@ovro.caltech.edu>
References: <C89EFD3CD56F64468D3D206D683A8D22351B7A@ldam-msx2.fugro-nl.local>
	<4666DB52.2020807@ovro.caltech.edu>
From: "Kruit, Chris van der [FINT]" <C.vdKruit@fugro.nl>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dave,

Thanks for the reply. It's really usefull. I probally come back later
with some more questions :)

Chris.

-----Original Message-----
From: David Hawkins [mailto:dwh@ovro.caltech.edu]=20
Sent: Wednesday, June 06, 2007 6:06 PM
To: Kruit, Chris van der [FINT]
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8272 LPT support

Hi Chris,

> I'm new to Linux and PowerPC.

Ok.

> Last days I did some research to find out if we could use a specific=20
> board for our new project.  I found a board with a MPC8272 processor;
it=20
> got all the IO we need, except for a LPT port that we use now for=20
> driving a HD44780 based display.
>=20
> Now the MPC8272 has a lot free GPIO pins which can be used for driving

> the HD44780 controller.
>=20
> Now my question is if there are drivers for these GPIO pins and if
there=20
> is a way too emulate a parallel port on GPIO pins.

Since you are using the parallel port as GPIO to drive
the HD44780 display, then you should really just use
the MPC8272 GPIO as ... GPIO :)

Depending on your application, you might even get away
without using a custom driver.

If the GPIO pin register you plan to use for controlling
the HD44780 display is not used by any other driver/process,
then user-space can read/write to the register without
needing any sort of locking. If the GPIO pins are
shared, then you'd need a kernel driver with locking, or
possibly user space app with mutex locking.

I've attached inline some /dev/mem code that I've used
on an EP9302 (ARM processor) development board. I see no
reason it won't work on a PPC.

Give it a shot; map your GPIO register, set up a GPIO
bank as output, and toggle the I/O. To interface to the
LCD controller, I think you'll only need an 8-bit bidirectional
bus, and two or three output control signals.

Cheers,
Dave



/*
  * mem_debug.c
  *
  * 5/10/07 D. W. Hawkins (dwh@ovro.caltech.edu)
  *
  * A debug console for read/write access to /dev/mem mapped
  * areas.
  */
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <signal.h>
#include <sys/mman.h>
#include <stdlib.h>
#include <unistd.h>

void display_help();
void change_mem(char *cmd);
void display_mem(char *cmd);
void process_command(char *cmd);

/* Mapped address and size */
static char        *mem_addr  =3D NULL;
static unsigned int mem_phys  =3D 0;
static unsigned int mem_pages =3D 0;
static unsigned int mem_size =3D 0;

static void show_usage()
{
	printf("\nUsage: mem_debug -a <address> -n <pages>\n"\
		 "  -h            Help (this message)\n"\
		 "  -a <address>  Hex address to start the map\n"\
		 "  -n <pages>    Number of pages to map\n\n");
}

int main(int argc, char *argv[])
{
	int opt;       /* getopt processing         */
	int fd;        /* /dev/mem file descriptor  */
	char buf[200]; /* command processing buffer */
	int len =3D 200;
	int page_size =3D getpagesize();
	int status;

	while ((opt =3D getopt(argc, argv, "a:hn:")) !=3D -1) {
		switch (opt) {
			case 'a':
				status =3D sscanf(optarg, "%X",
&mem_phys);
				if (status !=3D 1) {
					printf("Parse error for -a
option\n");
					show_usage();
					return -1;
				}
				break;
			case 'h':
				show_usage();
				return -1;
			case 'n':
				mem_pages =3D atoi(optarg);
				break;
			default:
				show_usage();
				return -1;
		}
	}
	if (mem_phys !=3D (mem_phys/page_size)*page_size) {
		printf("Error: the address must be page-aligned
(0x%X)\n",
				page_size);
		return -1;
	}
	if (mem_pages =3D=3D 0) {
		mem_pages =3D 1;
	}
	mem_size =3D mem_pages*page_size;

	/* Startup */
	printf("\n------------------------\n");
	printf("/dev/mem debug interface\n");
	=
printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D\n\n");

	/* Open /dev/mem and map it */
	printf(" * open /dev/mem\n");
	fd =3D open("/dev/mem", O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("Open /dev/mem failed - %s\n",
			strerror(errno));
		return -1;
	}
	printf(" * map %d page(s) (%d-bytes) at address 0x%.8X\n",
			mem_pages, mem_size, mem_phys);
	mem_addr =3D (char *)mmap(
		0,
		mem_size,
		PROT_READ|PROT_WRITE,
		MAP_SHARED,
		fd,
		mem_phys);
	if (mem_addr =3D=3D (char *)MAP_FAILED) {
		printf("Error: mmap failed\n");
		close(fd);
		return -1;
	}

	/* Display help */
	display_help();

	/* Process commands */
	while (1) {
		printf("CMD> ");
		fflush(stdout);
		fgets(buf,len,stdin);
		process_command(buf);
	}

	/* Cleanup */
	munmap((void *)mem_addr, mem_pages*page_size);
	close(fd);
	return 0;
}

/*--------------------------------------------------------------------
  * User interface
  *--------------------------------------------------------------------
  */
void display_help()
{
	printf("\n  ?              Help\n");
	printf("  dw addr len    Display len words starting from
addr\n");
	printf("  db addr len    Display len bytes starting from
addr\n");
	printf("  cw addr val    Change word at addr to val\n");
	printf("  cb addr val    Change byte at addr to val\n");
	printf("  q              Quit\n");
	printf("\n  Notes:\n");
	printf("    * addr, len, and val are interpreted as hex
values\n");
	printf("    * addresses are always byte based\n");
	printf("    * addresses are offsets relative to the base
address\n\n");
}

void process_command(char *cmd)
{
	if (cmd[0] =3D=3D '\0') {
		return;
	}
	switch (cmd[0]) {
		case '?':
			display_help();
			break;
		case 'd':
		case 'D':
			display_mem(cmd);
			break;
		case 'c':
		case 'C':
			change_mem(cmd);
			break;
		case 'q':
		case 'Q':
			exit(0);
		default:
			break;
	}

	return;
}

void display_mem(char *cmd)
{
	char width =3D 0;
	int addr =3D 0;
	int len =3D 0;
	int status;
	int i, data;

	/* d, db, dw */
	status =3D sscanf(cmd, "%*c%c %x %x", &width, &addr, &len);
	if (status !=3D 3) {
		printf("syntax error (use ? for help)\n");
		return;
	}
	if (len > mem_size) {
		len =3D mem_size;
	}
	/* Convert to offset if required */
	if (addr >=3D mem_phys) {
		addr -=3D mem_phys;
	}
	if (addr >=3D mem_size) {
		printf("Illegal address\n");
		return;
	}
	switch (width) {
		case 'b':
			for (i =3D 0; i < len; i++) {
				if ((i%16) =3D=3D 0) {
					printf("\n%.8X: ", mem_phys +
addr + i);
				}
				data =3D (int)(mem_addr[addr+i]) & 0xFF;
				printf("%.02X ", data);
			}
			printf("\n");
			break;
		default:
			for (i =3D 0; i < len; i+=3D4) {
				if ((i%16) =3D=3D 0) {
					printf("\n%.8X: ", mem_phys +
addr + i);
				}
				data =3D *(int *)(mem_addr + addr + i);
				printf("%.08X ", data);
			}
			printf("\n");
			break;
	}
	printf("\n");
	return;
}

void change_mem(char *cmd)
{
	char width =3D 0;
	int addr =3D 0;
	int data =3D 0;
	int status;

	/* c, cb, cw */
	status =3D sscanf(cmd, "%*c%c %x %x", &width, &addr, &data);
	if (status !=3D 3) {
		printf("syntax error (use ? for help)\n");
		return;
	}
	/* Convert to offset if required */
	if (addr >=3D mem_phys) {
		addr -=3D mem_phys;
	}
	if (addr >=3D mem_size) {
		printf("Illegal address\n");
		return;
	}
	switch (width) {
		case 'b':
			mem_addr[addr] =3D data & 0xFF;
			break;
		default:
			*(int *)(mem_addr + addr) =3D data;
			break;
	}
	return;
}
