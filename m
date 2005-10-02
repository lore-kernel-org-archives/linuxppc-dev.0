Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28FE26838C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Oct 2005 00:25:50 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="leTmhZ1akr"
Message-ID: <17215.59283.623355.83952@astp0002.localdomain>
Date: Sun, 2 Oct 2005 16:58:43 +0300
To: Sam Song <samlinuxppc@yahoo.com.cn>
In-Reply-To: <20051001035828.88701.qmail@web15806.mail.cnb.yahoo.com>
References: <433C398E.30408@orkun.us>
	<20051001035828.88701.qmail@web15806.mail.cnb.yahoo.com>
Cc: Jonathan Masel <jmasel@arabellasw.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Available user-level tool for I2C device?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--leTmhZ1akr
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

>>>>> Sam Song writes:

    Sam> Tolunay Orkun <listmember@orkun.us> wrote:
    Tolunay> I've a hwclock.c implementation for DS1307/DS1338. I do not
    Tolunay> know how close DS1337 was but it should not be too
    Tolunay> difficult to adapt.

    Sam> Tolunay, thank you so much for providing me this closest
    Sam> stuff. It can just work right on DS1337 on my board. I just
    Sam> added alarm register operation in it.  After finshing LM75
    Sam> porting on this board, I'd like to try to get a common i2c
    Sam> utility just like "imd" and "imm" in u-boot.

You can try the tool which I wrote to test SPI-connected MMC card and
different I2C chips (EEPROMs, temperature sensors, etc.). As it was
discussed on the list, our implementation of SPI uses I2C infrastructure
so the same tool works for both I2C and SPI. I attached to this mail the
source, brief documentation, and some examples.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================

--leTmhZ1akr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline;
	filename="i2cspi.c"
Content-Transfer-Encoding: 7bit

/*
 * Copyright (C) 2005 Arabella Software Ltd.
 * Yuli Barcohen <yuli@arabellasw.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
 * USA.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <unistd.h>
#include <ctype.h>
#include <getopt.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>

#define READ  0x1234
#define WRITE 0x5678
#define XCHG  0xABCD

__u8 dat[16 * 1024];

struct i2c_msg msgs[256];

struct i2c_rdwr_ioctl_data xchg = {
   msgs,				/* pointers to i2c_msgs */
   sizeof(msgs)/sizeof(struct i2c_msg)	/* number of i2c_msgs */
};

static struct option long_options[] = {
   {"bus",      1, 0, 'b'},
   {"data-out", 1, 0, 'd'},
   {"data-len", 1, 0, 'l'},
   {"in-file",  1, 0, 'i'},
   {"out-file", 1, 0, 'o'},
   {"raw",      0, 0, 'r'},
   {"verbose",  0, 0, 'v'},
   {"help",     0, 0, 'h'},
   {0, 0, 0, 0}
};

int main(int argc, char *argv[])
{
   int opt, lopt_idx = 0;
   int raw = 0, verbose = 0, len = 0;
   char *data = NULL, *busdev = NULL, *infile = NULL, *outfile = NULL;
   long slave;
   int din = 0, dout = 1, dev;
   ssize_t count;
   char buf[128], hex[3];
   int i, j, k, m;
   int cur_msg = -1, ichar, ochar;
   unsigned l, p, cur_cmd = READ;

   while ((opt = getopt_long(argc, argv, "b:d:l:i:o:rvh", long_options, &lopt_idx)) != -1)
   {
      switch (opt)
      {
	 case 'b':
	    busdev = strdup(optarg);
	    break;
	 case 'd':
	    data = strdup(optarg);
	    if (data == NULL)
	    {
	       perror(NULL);
	       return 1;
	    }
	    break;
	 case 'l':
	    len = atoi(optarg);
	    break;
	 case 'i':
	    infile = strdup(optarg);
	    break;
	 case 'o':
	    outfile = strdup(optarg);
	    break;
	 case 'r':
	    raw = 1;
	    break;
	 case 'v':
	    verbose = 1;
	    break;
	 case 'h':
	    return 0;
      }
   }

   if (optind >= argc)
   {
      fprintf(stderr, "No slave address specified\n");
      return 2;
   }

   slave = strtol(argv[optind], NULL, 16);

   if (infile)
   {
      din = open(infile, O_RDONLY);
      if (din < 0)
      {
	 perror(infile);
	 return 3;
      }
   }

   if (outfile)
   {
      dout = open(outfile, O_WRONLY | O_CREAT | O_TRUNC,
		  S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
      if (dout < 0)
      {
	 perror(outfile);
	 close(din);
	 return 4;
      }
   }

   if (busdev == NULL)
      if (access("/dev/.devfsd", F_OK))
	 busdev = "/dev/i2c-0";
      else
	 busdev = "/dev/i2c/0";

   dev = open(busdev, O_RDWR);
   if (dev < 0)
   {
      perror(busdev);
      close(din);
      close(dout);
      return 5;
   }

   ioctl(dev, I2C_SLAVE, slave);

   hex[2] = 0;
   ochar = 0;
   while (count = read(din, buf, sizeof(buf)))
   {
      ichar = 0;
      while (ichar < count)
      {
	 switch (buf[ichar++])
	 {
	    case 'r': /* Read from the slave */
	       msgs[++cur_msg].addr = cur_cmd = READ;
	       sscanf(buf + ichar, "%u%n", &l, &k);
	       msgs[cur_msg].len = l;
	       msgs[cur_msg].buf = dat + ochar;
	       msgs[cur_msg].flags = I2C_M_RD;
	       ochar += l;
	       ichar += k;
	       break;

	    case 'w': /* Write to the slave */
	       msgs[++cur_msg].addr = cur_cmd = WRITE;
	       msgs[cur_msg].buf = dat + ochar;
	       msgs[cur_msg].len = 0;
	       msgs[cur_msg].flags = 0;
	       break;

	    case 'x': /* Data eXchange (I2C_RDWR) */
	       cur_cmd = XCHG;
	       msgs[++cur_msg].addr = slave;
	       msgs[cur_msg].buf = dat + ochar;
	       msgs[cur_msg].len = 0;
	       sscanf(buf + ichar, "%x%n", &l, &k);
	       msgs[cur_msg].flags = l;
	       ichar += k;
	       break;

	    case 'p': /* Pattern for eXchange timing */
	       if (cur_cmd == XCHG)
	       {
		  sscanf(buf + ichar, "%u%x%n", &l, &p, &k);
		  memset(dat + ochar, p, l);
		  msgs[cur_msg].len += l;
		  ochar += l;
		  ichar += k;
	       }
	       else
	       {
		  fprintf(stderr, "eXchage command required before Pattern\n");
		  goto finish;
	       }
	       break;

	    case 'u': /* rUn */
	       m = 0;
	       while (m <= cur_msg)
	       {
		  if (msgs[m].addr == READ)
		     read(dev, msgs[m].buf, msgs[m].len);
		  else if (msgs[m].addr == WRITE)
		     write(dev, msgs[m].buf, msgs[m].len);
		  else
		  {
		     xchg.msgs  = msgs + m;
		     xchg.nmsgs = 1;
		     m++;
		     while (m <= cur_msg)
		     {
			if ((msgs[m].addr != READ) && (msgs[m].addr != WRITE))
			{
			   xchg.nmsgs++;
			   m++;
			}
			else
			   break;
		     }
		     m--;

		     ioctl(dev, I2C_RDWR, &xchg);
		  }

		  m++;
	       }
	       for (m = 0; m <= cur_msg; m++)
	       {
		  if (msgs[m].flags & I2C_M_RD)
		     if (raw)
			write(dout, msgs[m].buf, msgs[m].len);
		     else
		     {
			for (i = 0; i < msgs[m].len; i++)
			{
			   sprintf(hex, "%2.2X", (unsigned)(msgs[m].buf[i]));
			   write(dout, hex, 2);
			}
			write(dout, "\n", 1);
		     }
	       }
	       cur_msg = -1;
	       ochar = 0;
	       break;

	    case ' ':
	    case '\t':
	    case '\n':
	    case '\r':
	       break;

	    default:
	       if (cur_cmd == READ)
	       {
		  fprintf(stderr, "Write or eXchage command required: %1.1s\n",
			  buf + ichar - 1);
		  goto finish;
	       }

	       if (isxdigit(buf[ichar - 1]) && isxdigit(buf[ichar]))
	       {
		  hex[0] = buf[ichar - 1];
		  hex[1] = buf[ichar++];
		  dat[ochar++] = (char)strtoul(hex, NULL, 16);
		  msgs[cur_msg].len++;
	       }
	       else
	       {
		  fprintf(stderr, "Illegal digit %2.2s\n", buf + ichar - 1);
		  goto finish;
	       }
	 }
      }
   }

  finish:
   close(din);
   close(dout);
   close(dev);

   return 0;
}

--leTmhZ1akr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline;
	filename="i2cspi.txt"
Content-Transfer-Encoding: 7bit

                              Using i2cspi

i2cspi takes I2C/SPI-related commands from a file (or standard input),
executes them and writes output read from the I2C/SPI peripherals to a
file (or standard output).

To run i2cspi, type the following:

   i2cspi [-b devname] [-i file] [-o file] [-r] slaveadr

where

   slaveadr	is the address of the I2C peripheral to be accessed.

Optional parameters (where supplied) are used as follows:

   -b devname	selects the bus; "devname" is the full device name of
                the I2C bus. Default is /dev/i2c-0.
   -i file	sets the input file to "file". If not specified, the
                standard input is used.
   -o file	sets the output file to "file". If not specified, the
                standard output is used.
   -r	        specifies raw mode (binary data is dumped raw to output
                instead of formatted by printf via %x). Rarely required. 

i2cspi input file format

The input file for i2cspi is a string of I2C/SPI commands entered as
ASCII text. All white-space (including carriage-returns, tabs, etc) are
taken as delimiters and otherwise ignored, so the commands may be
entered line-by-line or on a single line separated by white space. The
command letters do not need delimiters - they may appear immediately
before or after a numeric value (x1 is equivalent to x 1).

The following commands may be used in i2cspi:

   r n          read n (decimal number) bytes from the slave. In typical
                cases, this is rarely used since a write usually needs
                to precede a read operation.

   w seq	write a sequence of hex bytes to the peripheral. Each
                byte is represented by two hex characters; the sequence
                is terminated by white space. For most SPI peripherals,
                this command is only rarely used.

   x flags seq [p n]	this is the data exchange operation and is the
                        most commonly used SPI operation. Data is
                        written and read to the peripheral in
                        parallel. Note that the same number of clocks
                        are required for both read and write operation,
                        so you need to pad any write sequence to the
                        length of the read sequence that you wish to
                        read. Parameters for the 'x' command are as
                        follows:

      flags	are a hex number and as defined in the Linux I2C
                infrastructure. The two flags of relevance are:

         0x0001 - read data returning from the peripheral in parallel to
                  writing
         0x4000 - do not de-select the peripheral after the operation
                  has completed

      seq	is a sequence of hex bytes (2 characters per byte). If
      [p n] is specified, the sequence is repeated 'n' (decimal)
      times. This is useful for long sequences.

   u EXECUTE ALL PRECEDING COMMANDS. DO NOT FORGET THE 'U' COMMANDS
     SINCE WITHOUT IT NOTHING WILL HAPPEN! IN PARTICULAR, WE DO NOT
     ASSUME 'U' AT EOF, SO MAKE SURE YOUR INPUT FILE ENDS WITH A 'U'
     COMMAND.

--leTmhZ1akr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline;
	filename="examples"
Content-Transfer-Encoding: 7bit

# Reset MMC card and switch it to SPI mode
echo w400000000095u | i2cspi -b /dev/i2c/1 1

# Poll until the card passes reset and reports ready state
while true; do echo x1 410000000001p8 ffu | i2cspi -b /dev/i2c/1 1; sleep 10; done

# Read OCR
echo x1 7a0000000001ffffffffffffffu | i2cspi -b /dev/i2c/1 1

# Read CSD
echo x1 490000000001 p32 ffu | i2cspi -b /dev/i2c/1 1

# Read CID
echo x1 4a0000000001 p32 ffu | i2cspi -b /dev/i2c/1 1


--leTmhZ1akr--
