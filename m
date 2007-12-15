Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DDAABDDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Dec 2007 06:56:09 +1100 (EST)
Message-ID: <47643138.3040703@ovro.caltech.edu>
Date: Sat, 15 Dec 2007 11:55:36 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "R. Ebersole (VTI - new)" <rje@valleytech.com>
Subject: Re: mmap + segfaults on MPC8349E
References: <475B5680.30303@valleytech.com> <475B68AE.5000302@ovro.caltech.edu>
	<475DED86.1040409@valleytech.com>
	<475DF30A.1080202@ovro.caltech.edu>
	<476376DA.9010608@valleytech.com>
In-Reply-To: <476376DA.9010608@valleytech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
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

> Attached is the driver code that was in use when we had the problem.
> (FPGA_orig.7z)
> 
> We think that we *may* have resolved the issue.
> We have not, yet, completed testing the resolution, however.
> 
> Attached is the updated version of the driver (FPGArw.7z).
> So far, this version appears OK when using mmap() without
> MAP_FIXED.  We open() the device O_RDWR | O_SYNC.
> 
> We were going to switch to using pread(), pwrite(), and ioctl() to
> access the FPGA's registers, but we are going to hold off on that
> for now.

I had a look at a few of the user-space examples I have written
for accessing via mmap() for my own drivers, and the standard
/dev/mem driver. I've include a generic /dev/mem interface program
that I've used on a TS-7300 board (ARM-based board from Technologic
Systems). Its inline below. It should work fine on a PowerPC too.

My example code has always used open with O_RDWR and in some
cases (O_RDWR | O_SYNC) (as in the code below). The call to
mmap() uses prot set to (PROT_READ|PROT_WRITE) to match the open
mode, and for the flags MAP_SHARED, never MAP_FIXED.

 From the man page for mmap()

http://linux.die.net/man/2/mmap

   MAP_FIXED
     Do not select a different address than the one specified.
     If the memory region specified by start and len overlaps pages
     of any existing mapping(s), then the overlapped part of the
     existing mapping(s) will be discarded. If the specified address
     cannot be used, mmap() will fail. If MAP_FIXED is specified,
     start must be a multiple of the page size. Use of this option
     is discouraged.

So I'm not sure why you would choose this option.

I can't say what problems selecting this option would create, as I've
never tried. It would take some walking through the kernel code to
see where this flag is used.

Did you really see a difference between the driver code versions, or
was it changing MAP_FIXED to MAP_SHARED that did the trick?

If you test with the /dev/mem driver below and have no problems,
then I would recommend using the /dev/mem mmap() routine in your
custom driver.

To track down which code change causes the SEGFAULT would require
finding out the source of the SEGFAULT. So if you can code up
something that consistently causes the error, then you should be
able to debug the kernel to see what is causing it. I haven't had
to debug this sort of thing, so can't offer much advice. If its
hard to trigger the error, then do something deliberate; generate
a parity error (eg. by reading a specific FPGA register), generate
a bus timeout, etc. If that has the same effect on your code, then
perhaps the driver can be instrumented to give you a little more
debug information.

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
static char        *mem_addr  = NULL;
static unsigned int mem_phys  = 0;
static unsigned int mem_pages = 0;
static unsigned int mem_size = 0;

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
	int len = 200;
	int page_size = getpagesize();
	int status;

	while ((opt = getopt(argc, argv, "a:hn:")) != -1) {
		switch (opt) {
			case 'a':
				status = sscanf(optarg, "%X", &mem_phys);
				if (status != 1) {
					printf("Parse error for -a option\n");
					show_usage();
					return -1;
				}
				break;
			case 'h':
				show_usage();
				return -1;
			case 'n':
				mem_pages = atoi(optarg);
				break;
			default:
				show_usage();
				return -1;
		}
	}
	if (mem_phys != (mem_phys/page_size)*page_size) {
		printf("Error: the address must be page-aligned (0x%X)\n",
				page_size);
		return -1;
	}
	if (mem_pages == 0) {
		mem_pages = 1;
	}
	mem_size = mem_pages*page_size;

	/* Startup */
	printf("\n------------------------\n");
	printf("/dev/mem debug interface\n");
	printf("========================\n\n");

	/* Open /dev/mem and map it */
	printf(" * open /dev/mem\n");
	fd = open("/dev/mem", O_RDWR | O_SYNC);
	if (fd < 0) {
		printf("Open /dev/mem failed - %s\n",
			strerror(errno));
		return -1;
	}
	printf(" * map %d page(s) (%d-bytes) at address 0x%.8X\n",
			mem_pages, mem_size, mem_phys);
	mem_addr = (char *)mmap(
		0,
		mem_size,
		PROT_READ|PROT_WRITE,
		MAP_SHARED,
		fd,
		mem_phys);
	if (mem_addr == (char *)MAP_FAILED) {
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
	printf("  dw addr len    Display len words starting from  addr\n");
	printf("  db addr len    Display len bytes starting from addr\n");
	printf("  cw addr val    Change word at addr to val\n");
	printf("  cb addr val    Change byte at addr to val\n");
	printf("  q              Quit\n");
	printf("\n  Notes:\n");
	printf("    * addr, len, and val are interpreted as hex values\n");
	printf("    * addresses are always byte based\n");
	printf("    * addresses are offsets relative to the base address\n\n");
}

void process_command(char *cmd)
{
	if (cmd[0] == '\0') {
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
	char width = 0;
	int addr = 0;
	int len = 0;
	int status;
	int i, data;

	/* d, db, dw */
	status = sscanf(cmd, "%*c%c %x %x", &width, &addr, &len);
	if (status != 3) {
		printf("syntax error (use ? for help)\n");
		return;
	}
	if (len > mem_size) {
		len = mem_size;
	}
	/* Convert to offset if required */
	if (addr >= mem_phys) {
		addr -= mem_phys;
	}
	if (addr >= mem_size) {
		printf("Illegal address\n");
		return;
	}
	switch (width) {
		case 'b':
			for (i = 0; i < len; i++) {
				if ((i%16) == 0) {
					printf("\n%.8X: ", mem_phys + addr + i);
				}
				data = (int)(mem_addr[addr+i]) & 0xFF;
				printf("%.02X ", data);
			}
			printf("\n");
			break;
		default:
			for (i = 0; i < len; i+=4) {
				if ((i%16) == 0) {
					printf("\n%.8X: ", mem_phys + addr + i);
				}
				data = *(int *)(mem_addr + addr + i);
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
	char width = 0;
	int addr = 0;
	int data = 0;
	int status;

	/* c, cb, cw */
	status = sscanf(cmd, "%*c%c %x %x", &width, &addr, &data);
	if (status != 3) {
		printf("syntax error (use ? for help)\n");
		return;
	}
	/* Convert to offset if required */
	if (addr >= mem_phys) {
		addr -= mem_phys;
	}
	if (addr >= mem_size) {
		printf("Illegal address\n");
		return;
	}
	switch (width) {
		case 'b':
			mem_addr[addr] = data & 0xFF;
			break;
		default:
			*(int *)(mem_addr + addr) = data;
			break;
	}
	return;
}
