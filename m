Date: Wed, 19 Sep 2001 16:46:10 -0400
To: linuxppc-dev@lists.linuxppc.org
Subject: Accessing PCI IORESOURCE_IO
Message-ID: <20010919164610.A346@kybl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Tomas Jura <tjura@binghamton.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Can anybody explain me how to access PCI card resource
of type IORESOURCE_IO on PPC ?

My video card can work only with 4MB memory instead 6MB (
vram:6144 not helps ) and I think that solution is in the
non memory maped register on ATY chip.

thanks
Tomas

P.S. I tried following way (which failed):

rp=&pdev->resource[1];
addr = rp->start;
if( request_region( addr, 32, "atyfb" ) == 0 ){
  for( i = 0 ; i < 32; i++)
    printk( " %X",( unsigned ) inb( addr+i ) );
  printk( "\n" );
  release_region( addr, 32 );
} else
  printk("cannot request region 0x%lX\n", addr );

Resource 0, Flags 0x200, start 0x81000000, size 0x1000000
Resource 1, Flags 0x101, start 0xC00, size 0x100
Resource 2, Flags 0x200, start 0x80800000, size 0x1000
atyfb: using auxiliary register aperture
atyfb: 3D RAGE PRO (PQFP, PCI) [0x4750 rev 0x7c] 6M SGRAM,
14.31818 MHz XTAL, 23
0 MHz PLL, 100 Mhz MCLK
BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
6b2ea040 87010182 08651a79 e0000c01     03000600      001807ee   03c007cf


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
