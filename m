Date: Thu, 5 Dec 2002 16:14:37 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux on PowerPC Developers Mail List <linuxppc-dev@lists.linuxppc.org>
Subject: questions about porting an 8240 arch to linux
Message-ID: <20021205161437.A16705@crystal.2d3d.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

!!! Here's what I have:

* Board based on Motorola MPC8240 processor (based on 603e core)
* 32M sdram
* 250mhz processor
* board is based on PowerPC microprocessor command hardware reference
platform (CHRP).

!!! Here's what I figured out/did so far. Please correct me if I did
something wrong.

1. used 2.4.18 w/ 2.4.18-ppc patch applied (got it from ftp.kernel.org)
2. added my arch to arch/ppc/config.in
3. added a embed_config() section to arch/ppc/boot/simple/embed_config.c for
my arch with the following hardcoded parameters:

------------< snip <------< snip <------< snip <------------
    bd->bi_intfreq = 250 * 1000000;
    bd->bi_busfreq = 33 * 1000000;
    bd->bi_memsize = 32 * 1024 * 1024;
    bd->bi_baudrate = 9600;
------------< snip <------< snip <------< snip <------------

i have no idea what bus bi_busfreq refers to so I assumed PCI running at
33mhz. what is this bus frequency?

4. add an include for my arch header in include/asm-ppc/mpc8xx.h
5. defined the following bd_t structure in my arch header:

------------< snip <------< snip <------< snip <------------
typedef struct {
    unsigned int bi_intfreq;        /* cpu frequency (hz) */
    unsigned int bi_busfreq;        /* bus frequency (hz) */
    unsigned int bi_memsize;        /* size of memory (bytes) */
    unsigned int bi_baudrate;
} bd_t;
------------< snip <------< snip <------< snip <------------

6. defined IMAP_ADDR, IMAP_SIZE, NR_8259_INTS in my arch header

!!! things I still need to figure out or don't have a clue about:

1. what is IMAP_ADDR, IMAP_SIZE. I searched for IMMR in the MPC8240
reference manual and couldn't find anything - I have no idea what IMAP_ADDR
should be and I assumed IMAP_SIZE should be 64k like the other platforms.

2. what uart should I use? the user manual claims the board has a 8250
compatible uart, but if I compile in the standard linux 16550 uart support,
it exports the same symbols as those in arch/ppc/boot/simple/m8xx_tty.c
which is compiled when I select M8XX support. I disabled the 16550 support
for now and defined NR_8259_INTS to 16 (what should this be?) for now just
to get it to compile.

3. do I need to setup any registers before branching to the kernel?

--

Regards
 Abraham

It's no use crying over spilt milk -- it only makes it salty for the cat.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
