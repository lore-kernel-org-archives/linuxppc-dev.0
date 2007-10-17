Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 45610DDE98
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 14:14:34 +1000 (EST)
Message-ID: <47158C69.2070903@ovro.caltech.edu>
Date: Tue, 16 Oct 2007 21:15:37 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Dell Query <dell.query@yahoo.com>
Subject: Re: PPC440EPx GPIO control help
References: <400754.83957.qm@web45604.mail.sp1.yahoo.com>
In-Reply-To: <400754.83957.qm@web45604.mail.sp1.yahoo.com>
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

Hi Dell,

> I am a Linux and PPC newbie.

Ok.

> I have a PPC440EPx Sequoia Evaluation board that runs on Linux 2.6.21. 
> What I would want to do is to control (write and read values to) its 
> GPIO. Perhaps similar to Turbo C's outputb(0x378,0x01) to write and 
> inportb(0x378) to read. I read the PPC440EPx manual but I find it 
> difficult to understand.
> 
> Could anyone show me any tutorial or some sample codes?

I copied the code below from some test code I wrote for a TS7300
board (uses an ARM EP9302 processor). However, since its user-space
code it should work fine.

Generally for manipulating I/Os you write a custom driver. However,
when getting to know a processor, it sometimes helps to cheat and
just write to registers directly.

The code below uses /dev/mem to map a page or more of the processor
address space into your process. Go find the byte address of your
GPIO registers and pass that as the argument.

Google for /dev/mem and you'll find lots of code that looks more
or less like this. This code just gives you a minimal console so
that you can mess with multiple registers.

BTW, you can really screw yourself if you mess with registers
you shouldn't, eg. memory controller settings etc. So be careful.

 From the looks of the code, it provides options for
32-bit access or 8-bit access.

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
