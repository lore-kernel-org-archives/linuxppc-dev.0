Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 51510679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 19:05:12 +1000 (EST)
Message-ID: <1145445235.44461b733f242@webmail.televes.com:443>
Date: Wed, 19 Apr 2006 13:13:55 +0200
From: Bastos Fernandez Alexandre <alebas@televes.com>
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Watchdog on MPC82xx
References: <1144835330.443ccd021b40a@webmail.televes.com:443>
	<1144842264.443ce818d6822@webmail.televes.com:443>
In-Reply-To: <1144842264.443ce818d6822@webmail.televes.com:443>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Well,

I have tested two different approaches which has been confirmed
to be already working on MPC82xx boards.

One, from Paul Bilke, is based on modifiying printk to service
the WDT and reload the counter during boot time.
So I have modified kernel/printk.c and tested with this:

asmlinkage int printk(const char *fmt, ...)
{
    va_list args;
    int r;

    force_wdt_reload();
    [...]
}

#define SWSR_ADDR (CPM_MAP_ADDR + 0x1000E)

void force_wdt_reload(void)
{
    unsigned short *swsr_ptr = (unsigned short *)ioremap(SWSR_ADDR,0x2);

    (*swsr_ptr) = (unsigned short) 0x556c;
    (*swsr_ptr) = (unsigned short) 0xaa39;
}

Paul has reported changing printk works for him on several MPC82xx boards.

Second one is from Mike Rapoport from Compulab. Is the heartbeat
method. I have added and additional call in m82xx_board_setup()
which should reset the WDT for the first time in setup_arch():

static __inline__ void reset_8260_watchdog(void)
{
    cpm2_immr->im_siu_conf.siu_82xx.sc_swsr = 0x556c;
    cpm2_immr->im_siu_conf.siu_82xx.sc_swsr = 0xaa39;
}

void __init
m82xx_board_setup(void)
{
    volatile cpm2_map_t *immap = cpm2_immr;

    reset_8260_watchdog();

    ppc_md.heartbeat = m82xx_heartbeat;
    ppc_md.heartbeat_reset = HZ/2;
    ppc_md.heartbeat_count = 1;

}

Mike has reported the heartbeat method is working for him
on MPC8247 and MPC8271 boards with kernel 2.6.12.3.


I have tested both in a MCP8248 based board, with kernel
2.6.15 and u-boot 1.1.4 and I have no success. I can see
the __log_buf after the reset caused by de WDT and there
are several printk's done. I have put printk's to the
reset_8260_watchdog(), and I can see them also, so I
should suppose it is executed, but the board keeps reseting.
Furthermore, u-boot is doing OK the WDT job (with changes done
from Compulab).

I have dissasambled that, and for example:

c01c93b8 <m82xx_board_setup>:
c01c93b8: 3d 40 c0 1e     lis     r10,-16354
c01c93bc: 38 00 55 6c     li      r0,21868
c01c93c0: 81 2a 81 8c     lwz     r9,-32372(r10)
c01c93c4: 3d 09 00 01     addis   r8,r9,1
c01c93c8: b0 08 00 0e     sth     r0,14(r8)
c01c93cc: 81 68 0d 50     lwz     r11,3408(r8)
c01c93d0: 81 2a 81 8c     lwz     r9,-32372(r10)
c01c93d4: 75 60 08 00     andis.  r0,r11,2048
c01c93d8: 38 00 aa 39     li      r0,-21959
c01c93dc: 3d 29 00 01     addis   r9,r9,1
c01c93e0: b0 09 00 0e     sth     r0,14(r9)
c01c93e4: 41 82 00 44     beq-    c01c9428 <m82xx_board_setup+0x70>

[...]

which looks OK for me (but I am not an expert).

So, could someone give me some guideline about what could
be happening?. Should I downgrade to 2.6.12.3 and test?
Is the WDT being reloaded at least one time and then
failing to reset? Some idea on how to debug that?

Thanks


Alex BASTOS

P.S. The __log_buf
 3c353e4c 696e7578 20766572 73696f6e    <5>Linux version
 20322e36 2e313520 28616c65 62617340     2.6.15 (alebas@
 54523339 32292028 67636320 76657273    xxxx) (gcc vers
 696f6e20 332e332e 32292023 33392050    ion 3.3.2) #39 P
 5245454d 50542054 75652041 70722031    REEMPT Tue Apr 1
 38203135 3a32353a 33392043 45535420    8 15:25:39 CEST
 32303036 0a3c363e 54656c65 76657320    2006.<6>Televes
 446f4338 32343820 436f6d70 75746572    XXX8248 Computer
 2d6f6e2d 4d6f6475 6c652070 6f72740a    -on-Module port.
 3c373e4f 6e206e6f 64652030 20746f74    <7>On node 0 tot
 616c7061 6765733a 20313633 38340a3c    alpages: 16384.<
 373e2020 444d4120 7a6f6e65 3a203136    7>  DMA zone: 16
 33383420 70616765 732c204c 49464f20    384 pages, LIFO
 62617463 683a330a 3c373e20 20444d41    batch:3.<7>  DMA
 3332207a 6f6e653a 20302070 61676573    32 zone: 0 pages
 2c204c49 464f2062 61746368 3a300a3c    , LIFO batch:0.<
 373e2020 4e6f726d 616c207a 6f6e653a    7>  Normal zone:
 20302070 61676573 2c204c49 464f2062     0 pages, LIFO b
 61746368 3a300a3c 373e2020 48696768    atch:0.<7>  High
 4d656d20 7a6f6e65 3a203020 70616765    Mem zone: 0 page
 732c204c 49464f20 62617463 683a300a    s, LIFO batch:0.
 3c343e42 75696c74 2031207a 6f6e656c    <4>Built 1 zonel
 69737473 0a3c353e 4b65726e 656c2063    ists.<5>Kernel c
 6f6d6d61 6e64206c 696e653a 20726f6f    ommand line: roo
 743d2f64 65762f72 616d3020 72772063    t=/dev/ram0 rw c
 6f6e736f 6c653d74 74794350 4d0a3c35    onsole=ttyCPM.<5
 3e596f75 20617265 20617420 4f6e650a    >You are at One.
 3c343e50 49442068 61736820 7461626c    <4>PID hash tabl
 6520656e 74726965 733a2035 31322028    e entries: 512 (
 6f726465 723a2039 2c203831 00000000    order: 9, 81....
 00000000 00000000 00000000 00000000    ................
