Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 7082367A5C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 02:04:14 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A6474FD@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Tue, 18 Jan 2005 10:01:49 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Subject: RE: Linux 2.6-10.rc3  8xx: debugging (over-writing)  content of b
	d_in fo structure  in the kernel booting code
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

my "custom" bd_info structure (passed from my custom bootloader) looks as
following:

typedef struct bd_info {
        unsigned long   bi_memstart;    /* start of DRAM memory */
        unsigned long   bi_memsize;     /* size  of DRAM memory in bytes */
        unsigned long   bi_flashstart;  /* start of FLASH memory */
        unsigned long   bi_flashsize;   /* size  of FLASH memory */
        unsigned long   bi_flashoffset; /* reserved area for startup monitor
*/
        unsigned long   bi_sramstart;   /* start of SRAM memory */
        unsigned long   bi_sramsize;    /* size  of SRAM memory */
        unsigned long   bi_immr_base;   /* base of IMMR register */
        unsigned long   bi_bootflags;   /* boot / reboot flag (for LynxOS)
*/
        unsigned long   bi_ip_addr;     /* IP Address */
        unsigned char   bi_enetaddr[6]; /* Ethernet adress */
        unsigned short  bi_ethspeed;    /* Ethernet speed in Mbps */
        unsigned long   bi_intfreq;     /* Internal Freq, in MHz */
        unsigned long   bi_busfreq;     /* Bus Freq, in MHz */
        unsigned long   bi_baudrate;    /* Console Baudrate */
        unsigned char   bi_run_bank;    /* Running Bank */

} bd_t;

My embed_config(bd_t **bdp) function (in
arch/ppc/boot/simple/embed_config.c)
does the following (using above structure) :

 bd->bi_baudrate = 38400; /* changed from 115200 for debug - Alex */
 bd->bi_memstart = 0;
 bd->bi_memsize = (32 * 1024 * 1024);
 bd->bi_intfreq = 50000000;
 bd->bi_busfreq = 50000000;

Then we have, as Hans noted to me, the cpm_setbrg() function
 (in arch/ppc/8xx_io/commproc.c):

/* Set a baud rate generator.  This needs lots of work.  There are
 * four BRGs, any of which can be wired to any channel.
 * The internal baud rate clock is the system clock divided by 16.
 * This assumes the baudrate is 16x oversampled by the uart.
 */
#define BRG_INT_CLK             (((bd_t *)__res)->bi_intfreq)
#define BRG_UART_CLK            (BRG_INT_CLK/16)
#define BRG_UART_CLK_DIV16      (BRG_UART_CLK/16)

void
cpm_setbrg(uint brg, uint rate)
{
        volatile uint   *bp;

        /* This is good enough to get SMCs running.....
        */
        bp = (uint *)&cpmp->cp_brgc1;
        bp += brg;
        /* The BRG has a 12-bit counter.  For really slow baud rates (or
         * really fast processors), we may have to further divide by 16.
         */
        if (((BRG_UART_CLK / rate) - 1) < 4096)
                *bp = (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN;
        else
                *bp = (((BRG_UART_CLK_DIV16 / rate) - 1) << 1) |
                                                CPM_BRG_EN | CPM_BRG_DIV16;
}

So what could go wrong here in terms of setting the baudrate for the serial
uart 
(which "presumably" causes printing 3 good characters and then garbage
during kernel booting) ?
