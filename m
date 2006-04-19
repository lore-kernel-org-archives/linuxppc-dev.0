Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 18FFC679F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Apr 2006 00:41:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Watchdog on MPC82xx
Date: Wed, 19 Apr 2006 09:29:09 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B85964A@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Bastos Fernandez Alexandre" <alebas@televes.com>,
	"linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On our 8265/8280 board, the max timeout of the watchdog timer was ~1.3
seconds, so it kept resetting before the heartbeat function got called
on boot.

I had to add a watchdog reset to time_init() because it woud pause there
for about 2 secondfs trying to see if there was a realtime clock.=20

> -----Original Message-----
> From: linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+runet=3Dinnovsys.com@ozlabs.or
> g] On Behalf Of Bastos Fernandez Alexandre
> Sent: Wednesday, April 19, 2006 06:14
> To: linuxppc-embedded list
> Subject: Re: Watchdog on MPC82xx
>=20
> Well,
>=20
> I have tested two different approaches which has been confirmed
> to be already working on MPC82xx boards.
>=20
> One, from Paul Bilke, is based on modifiying printk to service
> the WDT and reload the counter during boot time.
> So I have modified kernel/printk.c and tested with this:
>=20
> asmlinkage int printk(const char *fmt, ...)
> {
>     va_list args;
>     int r;
>=20
>     force_wdt_reload();
>     [...]
> }
>=20
> #define SWSR_ADDR (CPM_MAP_ADDR + 0x1000E)
>=20
> void force_wdt_reload(void)
> {
>     unsigned short *swsr_ptr =3D (unsigned short=20
> *)ioremap(SWSR_ADDR,0x2);
>=20
>     (*swsr_ptr) =3D (unsigned short) 0x556c;
>     (*swsr_ptr) =3D (unsigned short) 0xaa39;
> }
>=20
> Paul has reported changing printk works for him on several=20
> MPC82xx boards.
>=20
> Second one is from Mike Rapoport from Compulab. Is the heartbeat
> method. I have added and additional call in m82xx_board_setup()
> which should reset the WDT for the first time in setup_arch():
>=20
> static __inline__ void reset_8260_watchdog(void)
> {
>     cpm2_immr->im_siu_conf.siu_82xx.sc_swsr =3D 0x556c;
>     cpm2_immr->im_siu_conf.siu_82xx.sc_swsr =3D 0xaa39;
> }
>=20
> void __init
> m82xx_board_setup(void)
> {
>     volatile cpm2_map_t *immap =3D cpm2_immr;
>=20
>     reset_8260_watchdog();
>=20
>     ppc_md.heartbeat =3D m82xx_heartbeat;
>     ppc_md.heartbeat_reset =3D HZ/2;
>     ppc_md.heartbeat_count =3D 1;
>=20
> }
>=20
> Mike has reported the heartbeat method is working for him
> on MPC8247 and MPC8271 boards with kernel 2.6.12.3.
>=20
>=20
> I have tested both in a MCP8248 based board, with kernel
> 2.6.15 and u-boot 1.1.4 and I have no success. I can see
> the __log_buf after the reset caused by de WDT and there
> are several printk's done. I have put printk's to the
> reset_8260_watchdog(), and I can see them also, so I
> should suppose it is executed, but the board keeps reseting.
> Furthermore, u-boot is doing OK the WDT job (with changes done
> from Compulab).
>=20
> I have dissasambled that, and for example:
>=20
> c01c93b8 <m82xx_board_setup>:
> c01c93b8: 3d 40 c0 1e     lis     r10,-16354
> c01c93bc: 38 00 55 6c     li      r0,21868
> c01c93c0: 81 2a 81 8c     lwz     r9,-32372(r10)
> c01c93c4: 3d 09 00 01     addis   r8,r9,1
> c01c93c8: b0 08 00 0e     sth     r0,14(r8)
> c01c93cc: 81 68 0d 50     lwz     r11,3408(r8)
> c01c93d0: 81 2a 81 8c     lwz     r9,-32372(r10)
> c01c93d4: 75 60 08 00     andis.  r0,r11,2048
> c01c93d8: 38 00 aa 39     li      r0,-21959
> c01c93dc: 3d 29 00 01     addis   r9,r9,1
> c01c93e0: b0 09 00 0e     sth     r0,14(r9)
> c01c93e4: 41 82 00 44     beq-    c01c9428 <m82xx_board_setup+0x70>
>=20
> [...]
>=20
> which looks OK for me (but I am not an expert).
>=20
> So, could someone give me some guideline about what could
> be happening?. Should I downgrade to 2.6.12.3 and test?
> Is the WDT being reloaded at least one time and then
> failing to reset? Some idea on how to debug that?
>=20
> Thanks
>=20
>=20
> Alex BASTOS
>=20
> P.S. The __log_buf
>  3c353e4c 696e7578 20766572 73696f6e    <5>Linux version
>  20322e36 2e313520 28616c65 62617340     2.6.15 (alebas@
>  54523339 32292028 67636320 76657273    xxxx) (gcc vers
>  696f6e20 332e332e 32292023 33392050    ion 3.3.2) #39 P
>  5245454d 50542054 75652041 70722031    REEMPT Tue Apr 1
>  38203135 3a32353a 33392043 45535420    8 15:25:39 CEST
>  32303036 0a3c363e 54656c65 76657320    2006.<6>Televes
>  446f4338 32343820 436f6d70 75746572    XXX8248 Computer
>  2d6f6e2d 4d6f6475 6c652070 6f72740a    -on-Module port.
>  3c373e4f 6e206e6f 64652030 20746f74    <7>On node 0 tot
>  616c7061 6765733a 20313633 38340a3c    alpages: 16384.<
>  373e2020 444d4120 7a6f6e65 3a203136    7>  DMA zone: 16
>  33383420 70616765 732c204c 49464f20    384 pages, LIFO
>  62617463 683a330a 3c373e20 20444d41    batch:3.<7>  DMA
>  3332207a 6f6e653a 20302070 61676573    32 zone: 0 pages
>  2c204c49 464f2062 61746368 3a300a3c    , LIFO batch:0.<
>  373e2020 4e6f726d 616c207a 6f6e653a    7>  Normal zone:
>  20302070 61676573 2c204c49 464f2062     0 pages, LIFO b
>  61746368 3a300a3c 373e2020 48696768    atch:0.<7>  High
>  4d656d20 7a6f6e65 3a203020 70616765    Mem zone: 0 page
>  732c204c 49464f20 62617463 683a300a    s, LIFO batch:0.
>  3c343e42 75696c74 2031207a 6f6e656c    <4>Built 1 zonel
>  69737473 0a3c353e 4b65726e 656c2063    ists.<5>Kernel c
>  6f6d6d61 6e64206c 696e653a 20726f6f    ommand line: roo
>  743d2f64 65762f72 616d3020 72772063    t=3D/dev/ram0 rw c
>  6f6e736f 6c653d74 74794350 4d0a3c35    onsole=3DttyCPM.<5
>  3e596f75 20617265 20617420 4f6e650a    >You are at One.
>  3c343e50 49442068 61736820 7461626c    <4>PID hash tabl
>  6520656e 74726965 733a2035 31322028    e entries: 512 (
>  6f726465 723a2039 2c203831 00000000    order: 9, 81....
>  00000000 00000000 00000000 00000000    ................
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
