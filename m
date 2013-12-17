Return-Path: <neorf3k@gmail.com>
Received: from mail-wi0-x232.google.com (mail-wi0-x232.google.com
 [IPv6:2a00:1450:400c:c05::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9C6B22C0084
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Dec 2013 19:59:00 +1100 (EST)
Received: by mail-wi0-f178.google.com with SMTP id bz8so3308041wib.11
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Dec 2013 00:58:52 -0800 (PST)
From: neorf3k <neorf3k@gmail.com>
Content-Type: text/plain; charset=windows-1252
Date: Tue, 17 Dec 2013 09:58:45 +0100
Subject: Chip Select register with 8bit bus size...
To: linuxppc-dev@ozlabs.org
Message-Id: <589FC957-3C23-46C7-BA4D-A56732046A41@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a problem to communicate with a register, CS4, at at 0x10020000. =
In U-boot that reg has the value 0x45fab3c1, but when we try to access =
it we get:  0x10101010 and we are not able to write too.

With CS3 everything seems ok, we can read and write. CS3 is at: =
0x10000000.

The main/only differences between cs3 and cs4 are:

Chip Select: Lp_cs3
Bus size: 32 bit
Bus control: 2 wait state R/W ACK disabled
Allocated size 32Kbyte

Chip Select: Lp_cs4
Bus size: 8 bit
Bus control: 2 wait state R/W ACK disabled
Allocated size: 4 KByte

In userspace we use:
/*=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97=97=97=97=97=97=97*/
//code from memedit.c
int fd;
fd =3D open("/dev/mem", O_SYNC | O_RDWR);
mem =3D mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset =
& (~4095));
printf("/dev/mem[0x%08x] =3D 0x%08x", offset, *(unsigned =
int*)&mem[offset & 4095]);

//to write
*((unsigned int *)&mem[offset & 4095]) =3D input;
/*=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97=97=97=97=97=97=97*/

In our kernel module:
/*=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97=97=97=97=97=97=97*/
#define CS4_START	 0x10020000U
#define CS4_STOP	 0x10040000U
#define CS4_SIZE	 0x00020000U
#define CS3_START	 0x10000000U
#define CS3_STOP	 0x10020000U
#define CS3_SIZE	 0x00020000U

 void __iomem *cs3_ioaddr   =3D ioremap ((volatile unsigned =
long)(CS3_START), CS3_SIZE);
 printk("We read value at CS3: %x \n\n\n",in_be32(cs3_ioaddr+0x0018));
 out_be32(cs3_ioaddr+0x0018,0x00000001);
 printk("We read written value: %x \n\n\n",in_be32(cs3_ioaddr+0x0018));
/*=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=97=
=97=97=97=97=97=97=97=97*/

Platform is based on mpc5200b CPU and fpga is a Xilinx Virtex4.
Kernel we use: 2.6.33

Thanks again in advance=85

Lorenzo=
