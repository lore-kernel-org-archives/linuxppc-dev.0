Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
	[209.85.160.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05C63B6F76
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2011 00:33:18 +1000 (EST)
Received: by pwj3 with SMTP id 3so2080791pwj.15
	for <linuxppc-dev@ozlabs.org>; Fri, 08 Apr 2011 07:33:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416DCB6@039-SN1MPN1-004.039d.mgd.msft.net>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<C3A1EF35-6CB6-4674-8B0B-44CD1657FE87@boeing.com>
	<4D9CAD1F.6060500@garzik.org>
	<BANLkTinjn5nt4-0cSo6nUfG8Vt1UrL2Q0g@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416BDD0@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTin1KoJ8EsV49naEAZjmq=EZLHXZpQ@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D3E7@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=jLZrS+rOBOMq=v3aMCPjNAUjS4w@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416D8CC@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTim-KV=hfx3kN9vXDFcK_zjm3iOGxg@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416DA14@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=Kk76PbwRJtz=9B_-rsc_2Y0Vq2w@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416DCB6@039-SN1MPN1-004.039d.mgd.msft.net>
Date: Fri, 8 Apr 2011 16:33:15 +0200
Message-ID: <BANLkTim0CAUnqE7iqmRZOu6t4iqJ7nnrtQ@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
	Linux PPC <linuxppc-dev@ozlabs.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"Moffett, Kyle D" <Kyle.D.Moffett@boeing.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Prabhakar,

On Fri, Apr 8, 2011 at 2:35 PM, Kushwaha Prabhakar-B32579
<B32579@freescale.com> wrote:
> Hi Leon,
>
> Finally interrupt came :)
>
> For this continuously firing of interrupt. Can you please check the u-boo=
t code for following patch..
> =A0 =A0 =A0 =A0" p1_p2_rdb: to set SQW/INT pin of RTC as INT line
> =A0 =A0 =A0 =A0 Commit id: 39c2a6eb75fabd9745c5762c8dec9d1a85dabf00 "
>
Indeed, I confirm a 32.68 Hz square wave entering the interrupt pin,
now that will keep the system busy :-)

Will perform that u-boot fix on my P2020RDB later.

I'll report back whether this solves the setup problems, your IDSEL
patch seems to work.

Thanks for wading through the issues one by one!

Best regards,

Leon.


> This patch is already present at =A0u-boot@lists.denx.de. =A0Or you can a=
pply it on u-boot.
>
> Regards,
> Prabhakar
>
>> -----Original Message-----
>> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
>> Sent: Friday, April 08, 2011 5:49 PM
>> To: Kushwaha Prabhakar-B32579
>> Cc: Moffett, Kyle D; linux-ide@vger.kernel.org; Tejun Heo; Jeff Garzik;
>> Linux PPC; Gupta Maneesh-B18878
>> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>>
>> Hello Prabhakar,
>>
>> I have P1020E 1.0 silicon (0x80ec0010) on my P1020RDB.
>>
>> With the addition of the interrupt-map-mask (thanks, miscopied that) I
>> get interrupt #16.
>>
>> However, it keeps continously firing (*). I have verified that the
>> Sil3132 device itself has no interrupt pending (the interrupt status
>> register reads zero).
>>
>> root@p1020rdb:~# lspci -vvvn
>> ...
>> 0001:03:00.0 0104: 1095:3132 (rev 01)
>> =A0 =A0 =A0 Subsystem: 1095:7132
>> =A0 =A0 =A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- =
ParErr-
>> Stepping- SERR- FastB2B- DisINTx-
>> =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAb=
ort-
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> =A0 =A0 =A0 Latency: 0, Cache Line Size: 32 bytes
>> =A0 =A0 =A0 Interrupt: pin A routed to IRQ 16
>> ...
>>
>> (*)
>> [ =A0 =A02.877714] irq 16: nobody cared (try booting with the "irqpoll"
>> option)
>> [ =A0 =A02.884406] Call Trace:
>> [ =A0 =A02.886856] [dffeff50] [c000763c] show_stack+0x4c/0x178 (unreliab=
le)
>> [ =A0 =A02.893216] [dffeff90] [c007819c] __report_bad_irq+0x38/0xd0
>> [ =A0 =A02.898871] [dffeffb0] [c0078400] note_interrupt+0x1cc/0x22c
>> [ =A0 =A02.904528] [dffeffe0] [c0079320] handle_fasteoi_irq+0xd0/0x118
>> [ =A0 =A02.910444] [dffefff0] [c000cbb4] call_handle_irq+0x18/0x28
>> [ =A0 =A02.916012] [dfff1ec0] [c0004e0c] do_IRQ+0xa4/0x140
>> [ =A0 =A02.920888] [dfff1ef0] [c000e63c] ret_from_except+0x0/0x18
>> [ =A0 =A02.926376] --- Exception: 501 at __do_softirq+0x5c/0x158
>> [ =A0 =A02.926380] =A0 =A0 LR =3D call_do_softirq+0x14/0x24
>> [ =A0 =A02.936201] [dfff1fb0] [c00436d4] __do_softirq+0xc0/0x158 (unreli=
able)
>> [ =A0 =A02.942727] [dfff1ff0] [c000cb8c] call_do_softirq+0x14/0x24
>> [ =A0 =A02.948294] [c0633e70] [c0004c58] do_softirq+0x74/0x80
>> [ =A0 =A02.953429] [c0633e90] [c00434a0] irq_exit+0x7c/0x9c
>> [ =A0 =A02.958388] [c0633ea0] [c0004e38] do_IRQ+0xd0/0x140
>> [ =A0 =A02.963261] [c0633ed0] [c000e63c] ret_from_except+0x0/0x18
>> [ =A0 =A02.968746] --- Exception: 501 at cpu_idle+0xcc/0xdc
>> [ =A0 =A02.968749] =A0 =A0 LR =3D cpu_idle+0xcc/0xdc
>> [ =A0 =A02.977527] [c0633f90] [c0008744] cpu_idle+0x58/0xdc (unreliable)
>> [ =A0 =A02.983618] [c0633fb0] [c0002494] rest_init+0x64/0x78
>> [ =A0 =A02.988667] [c0633fc0] [c05c17ec] start_kernel+0x278/0x2dc
>> [ =A0 =A02.994147] [c0633ff0] [c00003a0] skpinv+0x2b8/0x2f4
>> [ =A0 =A02.999102] handlers:
>> [ =A0 =A03.001365] [<c029fc38>] (sil24_interrupt+0x0/0x8)
>> [ =A0 =A03.006162] Disabling IRQ #16
>>
>> Even after this, the interrupt handler keeps firing (verified by
>> printing the Sil3132 interrupt status register, which reads 0, no
>> interrupts pending).
>>
>> root@p1020rdb:~# cat /proc/interrupts
>> =A0 =A0 =A0 =A0 =A0 =A0CPU0
>> =A016: =A0 =A0 200001 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0 =A0 =
=A0sata_sil24
>> =A017: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0[EDAC] L2 err
>> =A018: =A0 =A0 =A0 5218 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0 =A0=
 =A0eth0_g1_tx
>> =A019: =A0 =A0 =A0 =A0 =A08 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0fsl-lbc
>> =A020: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0fsldma-chan
>> =A021: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0fsldma-chan
>> =A022: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0fsldma-chan
>> =A023: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0fsldma-chan
>> =A024: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0eth0_g1_rx
>> =A025: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0eth0_g1_er
>> =A028: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0ehci_hcd:usb1
>> =A029: =A0 =A0 =A0 =A0 65 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0 =
=A0 =A0eth0_g0_tx
>> =A030: =A0 =A0 =A0 7203 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0 =A0=
 =A0eth0_g0_rx
>> =A034: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0eth0_g0_er
>> =A042: =A0 =A0 =A0 2988 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0 =A0=
 =A0serial
>> =A043: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0i2c-mpc, i2c-mpc
>> =A045: =A0 =A0 =A0 =A0 =A00 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0=
 =A0 =A0of:talitos
>> =A072: =A0 =A0 =A012883 =A0 =A0OpenPIC =A0 =A0 =A0 =A0 Level =A0 =A0 =A0=
 =A0mmc0
>> LOC: =A0 =A0 =A016816 =A0 Local timer interrupts
>> SPU: =A0 =A0 =A027343 =A0 Spurious interrupts
>> CNT: =A0 =A0 =A0 =A0 =A00 =A0 Performance monitoring interrupts
>> MCE: =A0 =A0 =A0 =A0 =A00 =A0 Machine check exceptions
>>
>>
>> EIVPR0 register:
>>
>> root@p1020rdb:~# devmem2 0xffe50000
>> /dev/mem opened.
>> Memory mapped at address 0x48021000.
>> Value at address 0xFFE50000 (0x48021000): 0x80480000
>>
>> This means level sensitive, active low.
>>
>>
>> The external IRQ0 is pulled high, verified by scope.
>>
>>
>> Regards,
>>
>> Leon.
>>
>>
>> (*)The sata_sil24 interrupt handler keeps firing.
>>
>> [ =A0 =A06.929867] irq 16: nobody cared (try booting with the "irqpoll"
>> option)
>> [ =A0 =A06.936566] Call Trace:
>> [ =A0 =A06.939018] [dffeff50] [c000763c] show_stack+0x4c/0x178 (unreliab=
le)
>> [ =A0 =A06.945377] [dffeff90] [c007819c] __report_bad_irq+0x38/0xd0
>> [ =A0 =A06.951034] [dffeffb0] [c0078400] note_interrupt+0x1cc/0x22c
>> [ =A0 =A06.956690] [dffeffe0] [c0079320] handle_fasteoi_irq+0xd0/0x118
>> [ =A0 =A06.962606] [dffefff0] [c000cbb4] call_handle_irq+0x18/0x28
>> [ =A0 =A06.968174] [deee7e00] [c0004e0c] do_IRQ+0xa4/0x140
>> [ =A0 =A06.973051] [deee7e30] [c000e63c] ret_from_except+0x0/0x18
>> [ =A0 =A06.978545] --- Exception: 501 at find_next_zero_bit+0x8c/0xe0
>> [ =A0 =A06.978549] =A0 =A0 LR =3D alloc_fd+0x64/0x130
>> [ =A0 =A06.988283] [deee7ef0] [c00b9950] getname+0x28/0xf4 (unreliable)
>> [ =A0 =A06.994297] [deee7f10] [c00ab890] do_sys_open+0x5c/0x11c
>> [ =A0 =A06.999604] [deee7f40] [c000dfe8] ret_from_syscall+0x0/0x3c
>> [ =A0 =A07.005172] --- Exception: c01 at 0x48017a04
>> [ =A0 =A07.005175] =A0 =A0 LR =3D 0x48006a18
>> [ =A0 =A07.012560] handlers:
>> [ =A0 =A07.014823] [<c029fc38>] (sil24_interrupt+0x0/0x4fc)
>> [ =A0 =A07.019795] Disabling IRQ #16
>>
>>
>> On Fri, Apr 8, 2011 at 11:41 AM, Kushwaha Prabhakar-B32579
>> <B32579@freescale.com> wrote:
>> > Hi Leon,
>> >
>> > =A0interrupt-map-mask is missing for pcie@ffe0a000 node. Please see my
>> comment there...
>> > pcie@ffe0a000 node deals with mini-PCIe.
>> >
>> > one more thing, can you please tell P1020Si version. It will be there
>> on u-boot log.
>> >
>> > --Prabhakar
>> >
>> >> -----Original Message-----
>> >> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>> >> Sent: Friday, April 08, 2011 2:43 PM
>> >> To: Kushwaha Prabhakar-B32579
>> >> Cc: Moffett, Kyle D; linux-ide@vger.kernel.org; Tejun Heo; Jeff
>> Garzik;
>> >> Linux PPC; Gupta Maneesh-B18878
>> >> Subject: Re: known working sata_sil24.c setup on powerpc platforms?
>> >>
>> >> Hello Prabhakar,
>> >>
>> >> On Fri, Apr 8, 2011 at 10:31 AM, Kushwaha Prabhakar-B32579
>> >> <B32579@freescale.com> wrote:
>> >> > Hi Leon,
>> >> >
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>> >> >> Sent: Friday, April 08, 2011 1:55 PM
>> >> >> To: Kushwaha Prabhakar-B32579
>> >> >> Cc: Moffett, Kyle D; linux-ide@vger.kernel.org; Tejun Heo; Jeff
>> >> >> Garzik; Linux PPC; Gupta Maneesh-B18878
>> >> >> Subject: Re: known working sata_sil24.c setup on powerpc platforms=
?
>> >> >>
>> >> >> Hello Prabhakar,
>> >> >>
>> >> >> On Fri, Apr 8, 2011 at 5:44 AM, Kushwaha Prabhakar-B32579
>> >> >> <B32579@freescale.com> wrote:
>> >> >> >> -----Original Message-----
>> >> >> >> From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>> >> >> >> owner@vger.kernel.org] On Behalf Of Leon Woestenberg
>> >> >> >> Sent: Thursday, April 07, 2011 10:23 PM
>> >> >> >> To: Kushwaha Prabhakar-B32579
>> >> >> >> Cc: Moffett, Kyle D; Linux PPC; linux-ide@vger.kernel.org; Teju=
n
>> >> >> >> Heo; Jeff Garzik
>> >> >> >> Subject: Re: known working sata_sil24.c setup on powerpc
>> platforms?
>> >> >> >>
>> >> >> >> On Thu, Apr 7, 2011 at 6:48 AM, Kushwaha Prabhakar-B32579
>> >> >> >> <B32579@freescale.com> wrote:
>> >> >> >> > Can you please check p2020rdb.dts for IDSEL entries for pci0/=
1
>> >> node?
>> >> >> >> >
>> >> >> >> > In order to work in legacy mode, IDSEL entries are required.
>> >> >> >> >
>> >> >> >> No, the p1020rdb and p2020rdb do not have the IDSEL entries:
>> >> >> >> What would the correct IDSEL entries be?
>> >> >> >
>> >> >> > For legacy interrupt to work IDSEL values are required.. please
>> >> >> > find
>> >> >> the correct IDSEL values for pci0/1.
>> >> >> >
>> >> >> > =A0 =A0 =A0 =A0pci0: pcie@ffe09000 {
>> >> >> > ...
>> >> >> > Please try with this.. I am in process of pushing these IDSEL
>> >> >> > values to
>> >> >> upstream.
>> >> >> >
>> >> >>
>> >> >> Do you have these for P1020RDB =A0as well? I found a P1020RDB boar=
d
>> >> >> that has the CE10 errata fixed, so IRQ0 is properly pulled up.
>> >> >>
>> >> >
>> >> > =A0Same IDSEL values are valid for P1020RDB also.
>> >> >
>> >> I compiled the new device tree binary, the dump is below(*) and boote=
d
>> >> the P1020RDB from that.
>> >>
>> >> I verified using an oscilloscope that IRQ0 indeed remains high.
>> >>
>> >> However, no interrupt seems to come in from the sata_sil24 driver, se=
e
>> >> boot log (**).
>> >>
>> >> (*) dtb dump:
>> >> $ dtc -I dtb -O dts /tftpboot/p1020rdb/uImage.dtb
>> >>
>> >> =A0 =A0 =A0 pcie@ffe09000 {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8548-pcie";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <0x1>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0x3>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0 0xffe09000 0x0 0x1000>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-range =3D <0x0 0xff>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x2000000 0x0 0xa0000000 0x0 =
0xa0000000 0x0
>> >> 0x20000000 0x1000000 0x0 0x0 0x0 0xffc30000 0x0 0x10000>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0x1fca055>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x10 0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map-mask =3D <0xf800 0x0 0x0 0x=
7>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <0x0 0x0 0x0 0x1 0x2 0x=
4 0x1 0x0 0x0 0x0
>> 0x2
>> >> 0x2 0x5
>> >> 0x1 0x0 0x0 0x0 0x3 0x2 0x6 0x1 0x0 0x0 0x0 0x4 0x2 0x7 0x1>;
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcie@0 {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0 0x0 0x0 0x0 =
0x0>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0x3>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x2000000 0x0=
 0xa0000000 0x2000000 0x0
>> >> 0xa0000000 0x0 0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0
>> >> 0x100000>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> >> =A0 =A0 =A0 };
>> >>
>> >> =A0 =A0 =A0 pcie@ffe0a000 {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc8548-pcie";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <0x1>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0x3>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0 0xffe0a000 0x0 0x1000>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-range =3D <0x0 0xff>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x2000000 0x0 0xc0000000 0x0 =
0xc0000000 0x0
>> >> 0x20000000 0x1000000 0x0 0x0 0x0 0xffc20000 0x0 0x10000>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <0x1fca055>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x10 0x2>;
>> >
>> > interrupt-map-mask is missing here.. can you please check dts again.
>> >
>> >
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-map =3D <0x0 0x0 0x0 0x1 0x2 0x=
0 0x1 0x0 0x0 0x0
>> 0x2
>> >> 0x2 0x1
>> >> 0x1 0x0 0x0 0x0 0x3 0x2 0x2 0x1 0x0 0x0 0x0 0x4 0x2 0x3 0x1>;
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcie@0 {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0 0x0 0x0 0x0 =
0x0>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0x2>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0x3>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "pci";
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x2000000 0x0=
 0xc0000000 0x2000000 0x0
>> >> 0xc0000000 0x0 0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0
>> >> 0x100000>;
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>> >> =A0 =A0 =A0 };
>> >> };
>> >>
>> >> (**) boot log
>> >>
>> >> [ =A0 =A00.000000] Using P1020 RDB machine description
>> >> [ =A0 =A00.000000] Memory CAM mapping: 256/256 Mb, residual: 0Mb
>> >> [ =A0 =A00.000000] Linux version 2.6.38 (leon@lunar) (gcc version 4.3=
.3
>> >> (GCC) ) #6 Fri Apr 8 11:00:10 CEST 2011
>> >> [ =A0 =A00.000000] Found legacy serial port 0 for
>> /soc@ffe00000/serial@4500
>> >> [ =A0 =A00.000000] =A0 mem=3Dffe04500, taddr=3Dffe04500, irq=3D0, clk=
=3D399999996,
>> >> speed=3D0
>> >> [ =A0 =A00.000000] Found legacy serial port 1 for
>> /soc@ffe00000/serial@4600
>> >> [ =A0 =A00.000000] =A0 mem=3Dffe04600, taddr=3Dffe04600, irq=3D0, clk=
=3D399999996,
>> >> speed=3D0
>> >> [ =A0 =A00.000000] bootconsole [udbg0] enabled
>> >> [ =A0 =A00.000000] Found FSL PCI host bridge at 0x00000000ffe09000.
>> >> Firmware bus number: 0->255
>> >> [ =A0 =A00.000000] PCI host bridge /pcie@ffe09000 =A0ranges:
>> >> [ =A0 =A00.000000] =A0MEM 0x00000000a0000000..0x00000000bfffffff ->
>> >> 0x00000000a0000000
>> >> [ =A0 =A00.000000] =A0 IO 0x00000000ffc30000..0x00000000ffc3ffff ->
>> >> 0x0000000000000000
>> >> [ =A0 =A00.000000] /pcie@ffe09000: PCICSRBAR @ 0xfff00000
>> >> [ =A0 =A00.000000] Found FSL PCI host bridge at 0x00000000ffe0a000.
>> >> Firmware bus number: 0->0
>> >> [ =A0 =A00.000000] PCI host bridge /pcie@ffe0a000 =A0ranges:
>> >> [ =A0 =A00.000000] =A0MEM 0x00000000c0000000..0x00000000dfffffff ->
>> >> 0x00000000c0000000
>> >> [ =A0 =A00.000000] =A0 IO 0x00000000ffc20000..0x00000000ffc2ffff ->
>> >> 0x0000000000000000
>> >> [ =A0 =A00.000000] /pcie@ffe0a000: PCICSRBAR @ 0xfff00000
>> >> [ =A0 =A00.000000] MPC85xx RDB board from Freescale Semiconductor
>> >> [ =A0 =A00.000000] Top of RAM: 0x20000000, Total RAM: 0x20000000
>> >> [ =A0 =A00.000000] Memory hole size: 0MB
>> >> [ =A0 =A00.000000] Zone PFN ranges:
>> >> [ =A0 =A00.000000] =A0 DMA =A0 =A0 =A00x00000000 -> 0x00020000
>> >> [ =A0 =A00.000000] =A0 Normal =A0 empty
>> >> [ =A0 =A00.000000] =A0 HighMem =A0empty
>> >> [ =A0 =A00.000000] Movable zone start PFN for each node
>> >> [ =A0 =A00.000000] early_node_map[1] active PFN ranges
>> >> [ =A0 =A00.000000] =A0 =A0 0: 0x00000000 -> 0x00020000
>> >> [ =A0 =A00.000000] On node 0 totalpages: 131072
>> >> [ =A0 =A00.000000] free_area_init_node: node 0, pgdat c062d9bc,
>> >> node_mem_map c07e1000
>> >> [ =A0 =A00.000000] =A0 DMA zone: 1024 pages used for memmap
>> >> [ =A0 =A00.000000] =A0 DMA zone: 0 pages reserved
>> >> [ =A0 =A00.000000] =A0 DMA zone: 130048 pages, LIFO batch:31
>> >> [ =A0 =A00.000000] MMU: Allocated 1088 bytes of context maps for 255
>> contexts
>> >> [ =A0 =A00.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
>> >> [ =A0 =A00.000000] pcpu-alloc: [0] 0
>> >> [ =A0 =A00.000000] Built 1 zonelists in Zone order, mobility grouping=
 on.
>> >> Total pages: 130048
>> >> [ =A0 =A00.000000] Kernel command line: root=3D/dev/nfs rw
>> >> nfsroot=3D192.168.0.7:/nfsroot/p1020rdb
>> >> ip=3D192.168.0.20:192.168.0.7:::P1020RDB:eth0:off console=3DttyS0,115=
200
>> >> ramdisk_size=3D200000 cache-sram-size=3D0x10000
>> >> [ =A0 =A00.000000] PID hash table entries: 2048 (order: 1, 8192 bytes=
)
>> >> [ =A0 =A00.000000] Dentry cache hash table entries: 65536 (order: 6,
>> 262144
>> >> bytes)
>> >> [ =A0 =A00.000000] Inode-cache hash table entries: 32768 (order: 5, 1=
31072
>> >> bytes)
>> >> [ =A0 =A00.000000] High memory: 0k
>> >> [ =A0 =A00.000000] Memory: 511604k/524288k available (6112k kernel co=
de,
>> >> 12684k reserved, 256k data, 1686k bss, 220k init)
>> >> [ =A0 =A00.000000] Kernel virtual memory layout:
>> >> [ =A0 =A00.000000] =A0 * 0xfffcf000..0xfffff000 =A0: fixmap
>> >> [ =A0 =A00.000000] =A0 * 0xff800000..0xffc00000 =A0: highmem PTEs
>> >> [ =A0 =A00.000000] =A0 * 0xff7da000..0xff800000 =A0: early ioremap
>> >> [ =A0 =A00.000000] =A0 * 0xe1000000..0xff7da000 =A0: vmalloc & iorema=
p
>> >> [ =A0 =A00.000000] SLUB: Genslabs=3D15, HWalign=3D32, Order=3D0-3, Mi=
nObjects=3D0,
>> >> CPUs=3D1, Nodes=3D1
>> >> [ =A0 =A00.000000] NR_IRQS:512
>> >> [ =A0 =A00.000000] mpic: Setting up MPIC " OpenPIC =A0" version 1.2 a=
t
>> >> ffe40000, max 2 CPUs
>> >> [ =A0 =A00.000000] mpic: ISU size: 256, shift: 8, mask: ff
>> >> [ =A0 =A00.000000] mpic: Initializing for 256 sources
>> >> [ =A0 =A00.000000] time_init: decrementer frequency =3D 50.000000 MHz
>> >> [ =A0 =A00.000000] time_init: processor frequency =A0 =3D 799.999992 =
MHz
>> >> [ =A0 =A00.000000] clocksource: timebase mult[5000000] shift[22]
>> registered
>> >> [ =A0 =A00.000000] clockevent: decrementer mult[ccccccc] shift[32] cp=
u[0]
>> >> [ =A0 =A00.000000] Console: colour dummy device 80x25
>> >> [ =A0 =A00.010728] pid_max: default: 32768 minimum: 301
>> >> [ =A0 =A00.015483] Mount-cache hash table entries: 512
>> >> [ =A0 =A00.021404] devtmpfs: initialized
>> >> [ =A0 =A00.025042] NET: Registered protocol family 16
>> >> [ =A0 =A00.031180] irq: irq 47 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 47
>> >> [ =A0 =A00.031507] PCI: Probing PCI hardware
>> >> [ =A0 =A00.035144] pci_bus 0000:00: scanning bus
>> >> [ =A0 =A00.035167] pci 0000:00:00.0: [1957:0100] type 1 class 0x000b2=
0
>> >> [ =A0 =A00.035188] pci 0000:00:00.0: calling quirk_mmio_always_on+0x0=
/0x24
>> >> [ =A0 =A00.035197] pci 0000:00:00.0: ignoring class b20 (doesn't matc=
h
>> >> header type 01)
>> >> [ =A0 =A00.042429] pci 0000:00:00.0: calling
>> >> fixup_hide_host_resource_fsl+0x0/0x54
>> >> [ =A0 =A00.042440] pci 0000:00:00.0: calling
>> >> pcibios_fixup_resources+0x0/0x110
>> >> [ =A0 =A00.042456] pci 0000:00:00.0: calling
>> quirk_fsl_pcie_header+0x0/0x50
>> >> [ =A0 =A00.042473] pci 0000:00:00.0: calling
>> >> quirk_resource_alignment+0x0/0x19c
>> >> [ =A0 =A00.042488] pci 0000:00:00.0: supports D1 D2
>> >> [ =A0 =A00.042496] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3h=
ot
>> >> D3cold
>> >> [ =A0 =A00.042505] pci 0000:00:00.0: PME# disabled
>> >> [ =A0 =A00.042525] pci_bus 0000:00: fixups for bus
>> >> [ =A0 =A00.042539] pci 0000:00:00.0: scanning [bus 00-00] behind brid=
ge,
>> pass
>> >> 0
>> >> [ =A0 =A00.042546] pci 0000:00:00.0: bus configuration invalid,
>> reconfiguring
>> >> [ =A0 =A00.042556] pci 0000:00:00.0: scanning [bus 00-00] behind brid=
ge,
>> pass
>> >> 1
>> >> [ =A0 =A00.042577] pci_bus 0000:01: scanning bus
>> >> [ =A0 =A00.042584] pci_bus 0000:01: fixups for bus
>> >> [ =A0 =A00.042591] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> >> [ =A0 =A00.047728] pci 0000:00:00.0: =A0 bridge window [io =A00x0000-=
0x0000]
>> >> (disabled)
>> >> [ =A0 =A00.047738] pci 0000:00:00.0: =A0 bridge window [mem
>> >> 0x00000000-0x000fffff] (disabled)
>> >> [ =A0 =A00.047748] pci 0000:00:00.0: =A0 bridge window [mem
>> >> 0x00000000-0x000fffff pref] (disabled)
>> >> [ =A0 =A00.047760] pci_bus 0000:01: bus scan returning with max=3D01
>> >> [ =A0 =A00.047769] pci_bus 0000:00: bus scan returning with max=3D01
>> >> [ =A0 =A00.047902] pci_bus 0001:02: scanning bus
>> >> [ =A0 =A00.047920] pci 0001:02:00.0: [1957:0100] type 1 class 0x000b2=
0
>> >> [ =A0 =A00.047932] pci 0001:02:00.0: calling quirk_mmio_always_on+0x0=
/0x24
>> >> [ =A0 =A00.047941] pci 0001:02:00.0: ignoring class b20 (doesn't matc=
h
>> >> header type 01)
>> >> [ =A0 =A00.055166] pci 0001:02:00.0: calling
>> >> fixup_hide_host_resource_fsl+0x0/0x54
>> >> [ =A0 =A00.055177] pci 0001:02:00.0: calling
>> >> pcibios_fixup_resources+0x0/0x110
>> >> [ =A0 =A00.055188] pci 0001:02:00.0: calling
>> quirk_fsl_pcie_header+0x0/0x50
>> >> [ =A0 =A00.055202] pci 0001:02:00.0: calling
>> >> quirk_resource_alignment+0x0/0x19c
>> >> [ =A0 =A00.055215] pci 0001:02:00.0: supports D1 D2
>> >> [ =A0 =A00.055222] pci 0001:02:00.0: PME# supported from D0 D1 D2 D3h=
ot
>> >> D3cold
>> >> [ =A0 =A00.055230] pci 0001:02:00.0: PME# disabled
>> >> [ =A0 =A00.055254] pci_bus 0001:02: fixups for bus
>> >> [ =A0 =A00.055265] pci 0001:02:00.0: scanning [bus 01-01] behind brid=
ge,
>> pass
>> >> 0
>> >> [ =A0 =A00.055272] pci 0001:02:00.0: bus configuration invalid,
>> reconfiguring
>> >> [ =A0 =A00.055282] pci 0001:02:00.0: scanning [bus 00-00] behind brid=
ge,
>> pass
>> >> 1
>> >> [ =A0 =A00.055302] pci_bus 0001:03: scanning bus
>> >> [ =A0 =A00.055334] pci 0001:03:00.0: [1095:3132] type 0 class 0x00010=
4
>> >> [ =A0 =A00.055346] pci 0001:03:00.0: calling quirk_mmio_always_on+0x0=
/0x24
>> >> [ =A0 =A00.055376] pci 0001:03:00.0: reg 10: [mem 0xc0000000-0xc00000=
7f
>> >> 64bit]
>> >> [ =A0 =A00.055401] pci 0001:03:00.0: reg 18: [mem 0xc0004000-0xc0007f=
ff
>> >> 64bit]
>> >> [ =A0 =A00.055420] pci 0001:03:00.0: reg 20: [io =A00x1000-0x107f]
>> >> [ =A0 =A00.055448] pci 0001:03:00.0: reg 30: [mem 0x00000000-0x0007ff=
ff
>> pref]
>> >> [ =A0 =A00.055461] pci 0001:03:00.0: calling
>> >> pcibios_fixup_resources+0x0/0x110
>> >> [ =A0 =A00.055473] pci 0001:03:00.0: calling
>> >> quirk_resource_alignment+0x0/0x19c
>> >> [ =A0 =A00.055513] pci 0001:03:00.0: supports D1 D2
>> >> [ =A0 =A00.055537] pci 0001:03:00.0: disabling ASPM on pre-1.1 PCIe
>> >> device. =A0You can enable it with 'pcie_aspm=3Dforce'
>> >> [ =A0 =A00.065457] pci_bus 0001:03: fixups for bus
>> >> [ =A0 =A00.065464] pci 0001:02:00.0: PCI bridge to [bus 03-ff]
>> >> [ =A0 =A00.070655] pci 0001:02:00.0: =A0 bridge window [io =A00x0000-=
0x0000]
>> >> (disabled)
>> >> [ =A0 =A00.070664] pci 0001:02:00.0: =A0 bridge window [mem 0xc000000=
0-
>> >> 0xc00fffff]
>> >> [ =A0 =A00.070674] pci 0001:02:00.0: =A0 bridge window [mem
>> >> 0x10000000-0x000fffff pref] (disabled)
>> >> [ =A0 =A00.070707] pci_bus 0001:03: bus scan returning with max=3D03
>> >> [ =A0 =A00.070716] pci_bus 0001:02: bus scan returning with max=3D03
>> >> [ =A0 =A00.070891] PCI 0000:00 Cannot reserve Legacy IO [io =A00xff7e=
d000-
>> >> 0xff7edfff]
>> >> [ =A0 =A00.070900] PCI 0001:02 Cannot reserve Legacy IO [io =A00xff7d=
b000-
>> >> 0xff7dbfff]
>> >> [ =A0 =A00.070922] pci 0000:00:00.0: PCI bridge to [bus 01-01]
>> >> [ =A0 =A00.076063] pci 0000:00:00.0: =A0 bridge window [io =A00xff7ed=
000-
>> >> 0xff7fcfff]
>> >> [ =A0 =A00.082827] pci 0000:00:00.0: =A0 bridge window [mem 0xa000000=
0-
>> >> 0xbfffffff]
>> >> [ =A0 =A00.089596] pci 0000:00:00.0: =A0 bridge window [mem pref disa=
bled]
>> >> [ =A0 =A00.095676] pci 0000:00:00.0: enabling device (0106 -> 0107)
>> >> [ =A0 =A00.101321] pci 0001:02:00.0: BAR 9: can't assign mem pref (si=
ze
>> >> 0x100000)
>> >> [ =A0 =A00.108175] pci 0001:03:00.0: BAR 6: assigned [mem
>> >> 0xc0080000-0xc00fffff pref]
>> >> [ =A0 =A00.115377] pci 0001:02:00.0: PCI bridge to [bus 03-03]
>> >> [ =A0 =A00.120584] pci 0001:02:00.0: =A0 bridge window [io =A00xff7db=
000-
>> >> 0xff7eafff]
>> >> [ =A0 =A00.127355] pci 0001:02:00.0: =A0 bridge window [mem 0xc000000=
0-
>> >> 0xdfffffff]
>> >> [ =A0 =A00.134124] pci 0001:02:00.0: =A0 bridge window [mem pref disa=
bled]
>> >> [ =A0 =A00.140203] pci 0001:02:00.0: enabling device (0106 -> 0107)
>> >> [ =A0 =A00.145845] pci_bus 0000:00: resource 0 [io =A00xff7ed000-0xff=
7fcfff]
>> >> [ =A0 =A00.145854] pci_bus 0000:00: resource 1 [mem 0xa0000000-0xbfff=
ffff]
>> >> [ =A0 =A00.145863] pci_bus 0000:01: resource 0 [io =A00xff7ed000-0xff=
7fcfff]
>> >> [ =A0 =A00.145872] pci_bus 0000:01: resource 1 [mem 0xa0000000-0xbfff=
ffff]
>> >> [ =A0 =A00.145880] pci_bus 0001:02: resource 0 [io =A00xff7db000-0xff=
7eafff]
>> >> [ =A0 =A00.145889] pci_bus 0001:02: resource 1 [mem 0xc0000000-0xdfff=
ffff]
>> >> [ =A0 =A00.145897] pci_bus 0001:03: resource 0 [io =A00xff7db000-0xff=
7eafff]
>> >> [ =A0 =A00.145906] pci_bus 0001:03: resource 1 [mem 0xc0000000-0xdfff=
ffff]
>> >> [ =A0 =A00.145942] Registering qe_ic with sysfs...
>> >> [ =A0 =A00.149031] bio: create slab <bio-0> at 0
>> >> [ =A0 =A00.153197] vgaarb: loaded
>> >> [ =A0 =A00.156055] SCSI subsystem initialized
>> >> [ =A0 =A00.159772] libata version 3.00 loaded.
>> >> [ =A0 =A00.159905] usbcore: registered new interface driver usbfs
>> >> [ =A0 =A00.165357] usbcore: registered new interface driver hub
>> >> [ =A0 =A00.170666] usbcore: registered new device driver usb
>> >> [ =A0 =A00.175707] Freescale Elo / Elo Plus DMA driver
>> >> [ =A0 =A00.180293] Advanced Linux Sound Architecture Driver Version
>> 1.0.23.
>> >> [ =A0 =A00.186845] Switching to clocksource timebase
>> >> [ =A0 =A00.194746] NET: Registered protocol family 2
>> >> [ =A0 =A00.199032] Switched to NOHz mode on CPU #0
>> >> [ =A0 =A00.203314] IP route cache hash table entries: 4096 (order: 2,
>> 16384
>> >> bytes)
>> >> [ =A0 =A00.210610] TCP established hash table entries: 16384 (order: =
5,
>> >> 131072 bytes)
>> >> [ =A0 =A00.218015] TCP bind hash table entries: 16384 (order: 4, 6553=
6
>> bytes)
>> >> [ =A0 =A00.224585] TCP: Hash tables configured (established 16384 bin=
d
>> 16384)
>> >> [ =A0 =A00.231022] TCP reno registered
>> >> [ =A0 =A00.234149] UDP hash table entries: 256 (order: 0, 4096 bytes)
>> >> [ =A0 =A00.239974] UDP-Lite hash table entries: 256 (order: 0, 4096 b=
ytes)
>> >> [ =A0 =A00.246527] NET: Registered protocol family 1
>> >> [ =A0 =A00.251004] RPC: Registered udp transport module.
>> >> [ =A0 =A00.255632] RPC: Registered tcp transport module.
>> >> [ =A0 =A00.260308] RPC: Registered tcp NFSv4.1 backchannel transport
>> module.
>> >> [ =A0 =A00.266758] pci 0000:00:00.0: calling quirk_cardbus_legacy+0x0=
/0x50
>> >> [ =A0 =A00.266778] pci 0000:00:00.0: calling
>> >> quirk_usb_early_handoff+0x0/0x724
>> >> [ =A0 =A00.266794] pci 0001:02:00.0: calling quirk_cardbus_legacy+0x0=
/0x50
>> >> [ =A0 =A00.266804] pci 0001:02:00.0: calling
>> >> quirk_usb_early_handoff+0x0/0x724
>> >> [ =A0 =A00.266818] pci 0001:03:00.0: calling quirk_cardbus_legacy+0x0=
/0x50
>> >> [ =A0 =A00.266829] pci 0001:03:00.0: calling
>> >> quirk_usb_early_handoff+0x0/0x724
>> >> [ =A0 =A00.266839] PCI: CLS 32 bytes, default 32
>> >> [ =A0 =A00.267012] irq: irq 42 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 42
>> >> [ =A0 =A00.267213] irq: irq 19 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 19
>> >> [ =A0 =A00.267604] irq: irq 16 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 16
>> >> [ =A0 =A00.267761] irq: irq 43 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 43
>> >> [ =A0 =A00.268030] irq: irq 59 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 59
>> >> [ =A0 =A00.268323] irq: irq 20 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 20
>> >> [ =A0 =A00.268335] of:fsl-elo-dma ffe21300.dma: #0 (fsl,eloplus-dma-
>> channel),
>> >> irq 20
>> >> [ =A0 =A00.275419] irq: irq 21 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 21
>> >> [ =A0 =A00.275430] of:fsl-elo-dma ffe21300.dma: #1 (fsl,eloplus-dma-
>> channel),
>> >> irq 21
>> >> [ =A0 =A00.282530] irq: irq 22 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 22
>> >> [ =A0 =A00.282540] of:fsl-elo-dma ffe21300.dma: #2 (fsl,eloplus-dma-
>> channel),
>> >> irq 22
>> >> [ =A0 =A00.289648] irq: irq 23 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 23
>> >> [ =A0 =A00.289659] of:fsl-elo-dma ffe21300.dma: #3 (fsl,eloplus-dma-
>> channel),
>> >> irq 23
>> >> [ =A0 =A00.297270] irq: irq 28 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 28
>> >> [ =A0 =A00.297360] irq: irq 72 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 72
>> >> [ =A0 =A00.297450] irq: irq 45 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 45
>> >> [ =A0 =A00.297469] irq: irq 58 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 58
>> >> [ =A0 =A00.297630] irq: irq 224 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 224
>> >> [ =A0 =A00.297649] irq: irq 225 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 225
>> >> [ =A0 =A00.297668] irq: irq 226 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 226
>> >> [ =A0 =A00.297686] irq: irq 227 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 227
>> >> [ =A0 =A00.297705] irq: irq 228 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 228
>> >> [ =A0 =A00.297723] irq: irq 229 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 229
>> >> [ =A0 =A00.297742] irq: irq 230 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 230
>> >> [ =A0 =A00.297760] irq: irq 231 on host /soc@ffe00000/pic@40000 mappe=
d to
>> >> virtual irq 231
>> >> [ =A0 =A00.297849] Setting up Freescale MSI support
>> >> [ =A0 =A00.298123] audit: initializing netlink socket (disabled)
>> >> [ =A0 =A00.303462] type=3D2000 audit(0.236:1): initialized
>> >> [ =A0 =A00.314074] squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> >> [ =A0 =A00.320368] Installing knfsd (copyright (C) 1996
>> okir@monad.swb.de).
>> >> [ =A0 =A00.326841] NTFS driver 2.1.30 [Flags: R/O].
>> >> [ =A0 =A00.331296] JFFS2 version 2.2. (NAND) =A9 2001-2006 Red Hat, I=
nc.
>> >> [ =A0 =A00.337596] msgmni has been set to 1001
>> >> [ =A0 =A00.341965] Block layer SCSI generic (bsg) driver version 0.4
>> >> loaded (major 253)
>> >> [ =A0 =A00.349288] io scheduler noop registered (default)
>> >> [ =A0 =A00.431003] Serial: 8250/16550 driver, 2 ports, IRQ sharing en=
abled
>> >> [ =A0 =A00.438061] serial8250.0: ttyS0 at MMIO 0xffe04500 (irq =3D 42=
) is a
>> >> 16550A
>> >> [ =A0 =A00.444791] console [ttyS0] enabled, bootconsole disabled
>> >> [ =A0 =A00.456105] serial8250.0: ttyS1 at MMIO 0xffe04600 (irq =3D 42=
) is a
>> >> 16550A
>> >> [ =A0 =A00.463482] Generic non-volatile memory driver v1.1
>> >> [ =A0 =A00.470831] brd: module loaded
>> >> [ =A0 =A00.475184] loop: module loaded
>> >> [ =A0 =A00.478439] nbd: registered device at major 43
>> >> [ =A0 =A00.485462] st: Version 20101219, fixed bufsize 32768, s/g seg=
s 256
>> >> [ =A0 =A00.492145] sata_sil24 0001:03:00.0: version 1.1 built on Apr =
=A08
>> >> 2011 11:00:08
>> >> [ =A0 =A00.492182] ata_host_alloc: ENTER
>> >> [ =A0 =A00.495504] ata_port_alloc: ENTER
>> >> [ =A0 =A00.498821] ata_port_alloc: ENTER
>> >> [ =A0 =A00.502525] __ata_port_freeze: ata4294967295 port frozen
>> >> [ =A0 =A00.508187] __ata_port_freeze: ata4294967295 port frozen
>> >> [ =A0 =A00.513580] ------------[ cut here ]------------
>> >> [ =A0 =A00.518188] WARNING: at drivers/ata/libata-core.c:6082
>> >> [ =A0 =A00.523316] Modules linked in:
>> >> [ =A0 =A00.526364] NIP: c02876b0 LR: c0287690 CTR: c0248934
>> >> [ =A0 =A00.531323] REGS: df837d00 TRAP: 0700 =A0 Not tainted =A0(2.6.=
38)
>> >> [ =A0 =A00.537058] MSR: 00029000 <EE,ME,CE> =A0CR: 20424022 =A0XER: 2=
0000000
>> >> [ =A0 =A00.543158] TASK =3D df838000[1] 'swapper' THREAD: df836000
>> >> [ =A0 =A00.548373] GPR00: 00000001 df837db0 df838000 00000000 00003cb=
6
>> >> ffffffff c0249690 00080000
>> >> [ =A0 =A00.556736] GPR08: c073b9bc ffffffff 0007ffff 00003cb6 2042402=
2
>> >> 66013a2a 1ff91d00 c056c170
>> >> [ =A0 =A00.565097] GPR16: c0546e94 00000001 00002040 00000400 0000000=
8
>> >> 0000020c e109e040 df807060
>> >> [ =A0 =A00.573459] GPR24: dfa58490 c06160d8 00000080 c029fc0c 0000000=
0
>> >> c07d4a58 dfa58490 00000000
>> >> [ =A0 =A00.582013] NIP [c02876b0] ata_host_activate+0x48/0x11c
>> >> [ =A0 =A00.587232] LR [c0287690] ata_host_activate+0x28/0x11c
>> >> [ =A0 =A00.592360] Call Trace:
>> >> [ =A0 =A00.594801] [df837db0] [c0287690] ata_host_activate+0x28/0x11c
>> >> (unreliable)
>> >> [ =A0 =A00.601771] [df837de0] [c029faf8] sil24_init_one+0x420/0x534
>> >> [ =A0 =A00.607428] [df837e60] [c021d73c] local_pci_probe+0x24/0x34
>> >> [ =A0 =A00.612997] [df837e70] [c021d984] pci_device_probe+0x84/0xa8
>> >> [ =A0 =A00.618652] [df837ea0] [c0258a44] driver_probe_device+0xa8/0x1=
c8
>> >> [ =A0 =A00.624653] [df837ec0] [c0258c20] __driver_attach+0xbc/0xc0
>> >> [ =A0 =A00.630231] [df837ee0] [c02580ec] bus_for_each_dev+0x70/0xac
>> >> [ =A0 =A00.635885] [df837f10] [c0258844] driver_attach+0x24/0x34
>> >> [ =A0 =A00.641281] [df837f20] [c0257864] bus_add_driver+0xc4/0x294
>> >> [ =A0 =A00.646849] [df837f50] [c0258f98] driver_register+0x84/0x178
>> >> [ =A0 =A00.652504] [df837f70] [c021dc08] __pci_register_driver+0x4c/0=
xdc
>> >> [ =A0 =A00.658597] [df837f90] [c05ddfe4] sil24_init+0x24/0x34
>> >> [ =A0 =A00.663733] [df837fa0] [c0001dc0] do_one_initcall+0x34/0x1c8
>> >> [ =A0 =A00.669388] [df837fd0] [c05c11ec] kernel_init+0xcc/0x174
>> >> [ =A0 =A00.674696] [df837ff0] [c000cf98] kernel_thread+0x4c/0x68
>> >> [ =A0 =A00.680086] Instruction dump:
>> >> [ =A0 =A00.683045] 7cda3378 7cf93b78 7c7e1b78 4bfffc91 7c7f1b79 40820=
0d8
>> >> 2f9c0000 409e0034
>> >> [ =A0 =A00.690798] 7f69fe70 7d20da78 7c004850 54000ffe <0f000000> 800=
10034
>> >> 7fc3f378 7f24cb78
>> >> [ =A0 =A00.698738] ---[ end trace ab638653f78364ad ]---
>> >> [ =A0 =A00.703813] scsi0 : sata_sil24
>> >> [ =A0 =A00.707083] scsi1 : sata_sil24
>> >> [ =A0 =A00.710242] ata1: SATA max UDMA/100 host m128@0xc0000000 port
>> >> 0xc0004000
>> >> [ =A0 =A00.716951] ata2: SATA max UDMA/100 host m128@0xc0000000 port
>> >> 0xc0006000
>> >> [ =A0 =A00.724592] ef000000.nor: Found 1 x16 devices at 0x0 in 16-bit
>> >> bank. Manufacturer ID 0x000001 Chip ID 0x002101
>> >> [ =A0 =A00.734612] Amd/Fujitsu Extended Query Table at 0x0040
>> >> [ =A0 =A00.739787] =A0 Amd/Fujitsu Extended Query version 1.3.
>> >> [ =A0 =A00.744839] number of CFI chips: 1
>> >> [ =A0 =A00.748325] ata_port_schedule_eh: port EH scheduled
>> >> [ =A0 =A00.753217] ata_scsi_error: ENTER
>> >> [ =A0 =A00.756539] ata_eh_link_autopsy: ENTER
>> >> [ =A0 =A00.760286] ata_eh_recover: ENTER
>> >> [ =A0 =A00.763606] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 =A00.768317] RedBoot partition parsing not available
>> >> [ =A0 =A00.773212] Creating 5 MTD partitions on "ef000000.nor":
>> >> [ =A0 =A00.778526] 0x000000000000-0x000000040000 : "NOR (RO) Vitesse-=
7385
>> >> Firmware"
>> >> [ =A0 =A00.786280] 0x000000040000-0x000000080000 : "NOR (RO) DTB Imag=
e"
>> >> [ =A0 =A00.792876] 0x000000080000-0x000000400000 : "NOR (RO) Linux Ke=
rnel
>> >> Image"
>> >> [ =A0 =A00.800257] 0x000000400000-0x000000f00000 : "NOR (RW) JFFS2 Ro=
ot
>> File
>> >> System"
>> >> [ =A0 =A00.808001] 0x000000f00000-0x000001000000 : "NOR (RO) U-Boot I=
mage"
>> >> [ =A0 =A00.815110] fsl-lbc ffe05000.localbus: read_byte beyond end of
>> buffer
>> >> [ =A0 =A00.821564] fsl-lbc ffe05000.localbus: read_byte beyond end of
>> buffer
>> >> [ =A0 =A00.828002] fsl-lbc ffe05000.localbus: read_byte beyond end of
>> buffer
>> >> [ =A0 =A00.834443] NAND device: Manufacturer ID: 0xec, Chip ID: 0x75
>> >> (Samsung NAND 32MiB 3,3V 8-bit)
>> >> [ =A0 =A00.843174] Bad block table found at page 65504, version 0x01
>> >> [ =A0 =A00.843513] Bad block table found at page 65472, version 0x01
>> >> [ =A0 =A00.843876] RedBoot partition parsing not available
>> >> [ =A0 =A00.848772] Creating 6 MTD partitions on "ffa00000.flash":
>> >> [ =A0 =A00.854259] 0x000000000000-0x000000100000 : "NAND (RO) U-Boot
>> Image"
>> >> [ =A0 =A00.861299] 0x000000100000-0x000000200000 : "NAND (RO) DTB Ima=
ge"
>> >> [ =A0 =A00.868010] 0x000000200000-0x000000600000 : "NAND (RO) Linux K=
ernel
>> >> Image"
>> >> [ =A0 =A00.875530] 0x000000600000-0x000000a00000 : "NAND (RO) Compres=
sed
>> RFS
>> >> Image"
>> >> [ =A0 =A00.883216] 0x000000a00000-0x000001100000 : "NAND (RW) JFFS2 R=
oot
>> >> File System"
>> >> [ =A0 =A00.891042] 0x000001100000-0x000002000000 : "NAND (RW) Writabl=
e
>> User
>> >> area"
>> >> [ =A0 =A00.898571] eLBC NAND device at 0xffa00000, bank 1
>> >> [ =A0 =A00.904384] Fixed MDIO Bus: probed
>> >> [ =A0 =A00.907964] irq: irq 29 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 29
>> >> [ =A0 =A00.907986] irq: irq 30 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 30
>> >> [ =A0 =A00.908005] irq: irq 34 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 34
>> >> [ =A0 =A00.908035] irq: irq 17 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 17
>> >> [ =A0 =A00.908054] irq: irq 18 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 18
>> >> [ =A0 =A00.908074] irq: irq 24 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 24
>> >> [ =A0 =A00.908588] eth0: Gianfar Ethernet Controller Version 1.2,
>> >> 00:04:9f:01:1f:49
>> >> [ =A0 =A00.915646] eth0: Running with NAPI enabled
>> >> [ =A0 =A00.919826] eth0: RX BD ring size for Q[0]: 256
>> >> [ =A0 =A00.924353] eth0: RX BD ring size for Q[1]: 256
>> >> [ =A0 =A00.928879] eth0: RX BD ring size for Q[2]: 256
>> >> [ =A0 =A00.933406] eth0: RX BD ring size for Q[3]: 256
>> >> [ =A0 =A00.937932] eth0: RX BD ring size for Q[4]: 256
>> >> [ =A0 =A00.942458] eth0: RX BD ring size for Q[5]: 256
>> >> [ =A0 =A00.946984] eth0: RX BD ring size for Q[6]: 256
>> >> [ =A0 =A00.951512] eth0: RX BD ring size for Q[7]: 256
>> >> [ =A0 =A00.956037] eth0: TX BD ring size for Q[0]: 256
>> >> [ =A0 =A00.960564] eth0: TX BD ring size for Q[1]: 256
>> >> [ =A0 =A00.965090] eth0: TX BD ring size for Q[2]: 256
>> >> [ =A0 =A00.969616] eth0: TX BD ring size for Q[3]: 256
>> >> [ =A0 =A00.974143] eth0: TX BD ring size for Q[4]: 256
>> >> [ =A0 =A00.978668] eth0: TX BD ring size for Q[5]: 256
>> >> [ =A0 =A00.983197] eth0: TX BD ring size for Q[6]: 256
>> >> [ =A0 =A00.987725] eth0: TX BD ring size for Q[7]: 256
>> >> [ =A0 =A00.992327] irq: irq 35 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 35
>> >> [ =A0 =A00.992348] irq: irq 36 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 36
>> >> [ =A0 =A00.992367] irq: irq 40 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 40
>> >> [ =A0 =A00.992397] irq: irq 51 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 51
>> >> [ =A0 =A00.992417] irq: irq 52 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 52
>> >> [ =A0 =A00.992436] irq: irq 67 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 67
>> >> [ =A0 =A00.992938] eth1: Gianfar Ethernet Controller Version 1.2,
>> >> 00:04:9f:01:1f:4a
>> >> [ =A0 =A00.999992] eth1: Running with NAPI enabled
>> >> [ =A0 =A01.004172] eth1: RX BD ring size for Q[0]: 256
>> >> [ =A0 =A01.008699] eth1: RX BD ring size for Q[1]: 256
>> >> [ =A0 =A01.013226] eth1: RX BD ring size for Q[2]: 256
>> >> [ =A0 =A01.017753] eth1: RX BD ring size for Q[3]: 256
>> >> [ =A0 =A01.022280] eth1: RX BD ring size for Q[4]: 256
>> >> [ =A0 =A01.026806] eth1: RX BD ring size for Q[5]: 256
>> >> [ =A0 =A01.031333] eth1: RX BD ring size for Q[6]: 256
>> >> [ =A0 =A01.035860] eth1: RX BD ring size for Q[7]: 256
>> >> [ =A0 =A01.040387] eth1: TX BD ring size for Q[0]: 256
>> >> [ =A0 =A01.044914] eth1: TX BD ring size for Q[1]: 256
>> >> [ =A0 =A01.049441] eth1: TX BD ring size for Q[2]: 256
>> >> [ =A0 =A01.053967] eth1: TX BD ring size for Q[3]: 256
>> >> [ =A0 =A01.058495] eth1: TX BD ring size for Q[4]: 256
>> >> [ =A0 =A01.063022] eth1: TX BD ring size for Q[5]: 256
>> >> [ =A0 =A01.067552] eth1: TX BD ring size for Q[6]: 256
>> >> [ =A0 =A01.072079] eth1: TX BD ring size for Q[7]: 256
>> >> [ =A0 =A01.076679] irq: irq 31 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 31
>> >> [ =A0 =A01.076700] irq: irq 32 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 32
>> >> [ =A0 =A01.076719] irq: irq 33 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 33
>> >> [ =A0 =A01.076748] irq: irq 25 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 25
>> >> [ =A0 =A01.076768] irq: irq 26 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 26
>> >> [ =A0 =A01.076787] irq: irq 27 on host /soc@ffe00000/pic@40000 mapped=
 to
>> >> virtual irq 27
>> >> [ =A0 =A01.077315] eth2: Gianfar Ethernet Controller Version 1.2,
>> >> 00:04:9f:01:1f:4b
>> >> [ =A0 =A01.084370] eth2: Running with NAPI enabled
>> >> [ =A0 =A01.088551] eth2: RX BD ring size for Q[0]: 256
>> >> [ =A0 =A01.093077] eth2: RX BD ring size for Q[1]: 256
>> >> [ =A0 =A01.097604] eth2: RX BD ring size for Q[2]: 256
>> >> [ =A0 =A01.102130] eth2: RX BD ring size for Q[3]: 256
>> >> [ =A0 =A01.106657] eth2: RX BD ring size for Q[4]: 256
>> >> [ =A0 =A01.111184] eth2: RX BD ring size for Q[5]: 256
>> >> [ =A0 =A01.115712] eth2: RX BD ring size for Q[6]: 256
>> >> [ =A0 =A01.120238] eth2: RX BD ring size for Q[7]: 256
>> >> [ =A0 =A01.124765] eth2: TX BD ring size for Q[0]: 256
>> >> [ =A0 =A01.129291] eth2: TX BD ring size for Q[1]: 256
>> >> [ =A0 =A01.133818] eth2: TX BD ring size for Q[2]: 256
>> >> [ =A0 =A01.138344] eth2: TX BD ring size for Q[3]: 256
>> >> [ =A0 =A01.142871] eth2: TX BD ring size for Q[4]: 256
>> >> [ =A0 =A01.147398] eth2: TX BD ring size for Q[5]: 256
>> >> [ =A0 =A01.151925] eth2: TX BD ring size for Q[6]: 256
>> >> [ =A0 =A01.156452] eth2: TX BD ring size for Q[7]: 256
>> >> [ =A0 =A01.161023] ucc_geth: QE UCC Gigabit Ethernet Controller
>> >> [ =A0 =A01.166721] Freescale PowerQUICC MII Bus: probed
>> >> [ =A0 =A01.171369] irq: irq 3 on host /soc@ffe00000/pic@40000 mapped =
to
>> >> virtual irq 37
>> >> [ =A0 =A01.171760] irq: irq 2 on host /soc@ffe00000/pic@40000 mapped =
to
>> >> virtual irq 38
>> >> [ =A0 =A01.172142] Freescale PowerQUICC MII Bus: probed
>> >> [ =A0 =A01.178127] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI=
)
>> Driver
>> >> [ =A0 =A01.184817] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Dr=
iver
>> >> [ =A0 =A01.191162] /soc@ffe00000/usb@22000: Invalid 'dr_mode' propert=
y,
>> >> fallback to host mode
>> >> [ =A0 =A01.199169] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host
>> >> Controller
>> >> [ =A0 =A01.205996] fsl-ehci fsl-ehci.0: new USB bus registered, assig=
ned
>> >> bus number 1
>> >> [ =A0 =A01.235156] fsl-ehci fsl-ehci.0: irq 28, io mem 0xffe22000
>> >> [ =A0 =A01.251134] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
>> >> [ =A0 =A01.257090] hub 1-0:1.0: USB hub found
>> >> [ =A0 =A01.260860] hub 1-0:1.0: 1 port detected
>> >> [ =A0 =A01.264959] Initializing USB Mass Storage driver...
>> >> [ =A0 =A01.269918] usbcore: registered new interface driver usb-stora=
ge
>> >> [ =A0 =A01.275929] USB Mass Storage support registered.
>> >> [ =A0 =A01.280797] of:mpc-i2c ffe03000.i2c: timeout 1000000 us
>> >> [ =A0 =A01.286321] of:mpc-i2c ffe03100.i2c: timeout 1000000 us
>> >> [ =A0 =A01.291698] EDAC MC: Ver: 2.1.0 Apr =A08 2011
>> >> [ =A0 =A01.295999] Freescale(R) MPC85xx EDAC driver, (C) 2006 Montavi=
sta
>> >> Software
>> >> [ =A0 =A01.303043] mpc85xx_mc_err_probe: No ECC DIMMs discovered
>> >> [ =A0 =A01.308913] EDAC DEVICE0: Giving out device to module
>> >> 'MPC85xx_edac' controller 'mpc85xx_l2_err': DEV 'mpc85xx_l2_err'
>> >> (INTERRUPT)
>> >> [ =A0 =A01.320684] MPC85xx_edac acquired irq 16 for L2 Err
>> >> [ =A0 =A01.325561] MPC85xx_edac L2 err registered
>> >> [ =A0 =A01.329874] sdhci: Secure Digital Host Controller Interface dr=
iver
>> >> [ =A0 =A01.336056] sdhci: Copyright(c) Pierre Ossman
>> >> [ =A0 =A01.340590] mmc0: SDHCI controller on ffe2e000.sdhci
>> >> [ffe2e000.sdhci] using DMA
>> >> [ =A0 =A01.348286] of:talitos ffe30000.crypto: hwrng
>> >> [ =A0 =A01.352766] of:talitos ffe30000.crypto: authenc-hmac-sha1-cbc-=
aes-
>> >> talitos
>> >> [ =A0 =A01.359618] of:talitos ffe30000.crypto: authenc-hmac-sha1-cbc-=
3des-
>> >> talitos
>> >> [ =A0 =A01.366583] of:talitos ffe30000.crypto: authenc-hmac-sha256-cb=
c-
>> aes-
>> >> talitos
>> >> [ =A0 =A01.473638] of:talitos ffe30000.crypto: authenc-hmac-sha256-cb=
c-
>> 3des-
>> >> talitos
>> >> [ =A0 =A01.480747] of:talitos ffe30000.crypto: authenc-hmac-md5-cbc-a=
es-
>> >> talitos
>> >> [ =A0 =A01.487513] of:talitos ffe30000.crypto: authenc-hmac-md5-cbc-3=
des-
>> >> talitos
>> >> [ =A0 =A01.494358] of:talitos ffe30000.crypto: cbc-aes-talitos
>> >> [ =A0 =A01.499643] of:talitos ffe30000.crypto: cbc-3des-talitos
>> >> [ =A0 =A01.505015] of:talitos ffe30000.crypto: md5-talitos
>> >> [ =A0 =A01.509952] of:talitos ffe30000.crypto: sha1-talitos
>> >> [ =A0 =A01.514976] of:talitos ffe30000.crypto: sha224-talitos
>> >> [ =A0 =A01.520174] of:talitos ffe30000.crypto: sha256-talitos
>> >> [ =A0 =A01.525372] of:talitos ffe30000.crypto: sha384-talitos
>> >> [ =A0 =A01.530573] of:talitos ffe30000.crypto: sha512-talitos
>> >> [ =A0 =A01.536275] usbcore: registered new interface driver usbhid
>> >> [ =A0 =A01.541850] usbhid: USB HID core driver
>> >> [ =A0 =A01.545983] ALSA device list:
>> >> [ =A0 =A01.548958] =A0 No soundcards found.
>> >> [ =A0 =A01.553108] IPv4 over IPv4 tunneling driver
>> >> [ =A0 =A01.557922] TCP cubic registered
>> >> [ =A0 =A01.561155] Initializing XFRM netlink socket
>> >> [ =A0 =A01.565847] NET: Registered protocol family 10
>> >> [ =A0 =A01.574266] IPv6 over IPv4 tunneling driver
>> >> [ =A0 =A01.579967] NET: Registered protocol family 17
>> >> [ =A0 =A01.584454] Registering the dns_resolver key type
>> >> [ =A0 =A01.590372] drivers/rtc/hctosys.c: unable to open rtc device (=
rtc0)
>> >> [ =A0 =A02.102073] ADDRCONF(NETDEV_UP): eth0: link is not ready
>> >> [ =A0 =A02.939140] sil24_softreset: ENTER
>> >> [ =A0 =A02.955143] ata_dev_classify: found ATA device by sig
>> >> [ =A0 =A02.960194] sil24_softreset: EXIT, class=3D1
>> >> [ =A0 =A02.964295] ata_eh_thaw_port: ata1 port thawed
>> >> [ =A0 =A02.968734] ata_std_postreset: ENTER
>> >> [ =A0 =A02.972314] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl =
0)
>> >> [ =A0 =A02.978315] ata_std_postreset: EXIT
>> >> [ =A0 =A02.981804] ata_eh_revalidate_and_attach: ENTER
>> >> [ =A0 =A02.986333] ata1.00: ata_dev_read_id: ENTER
>> >> [ =A0 =A02.986342] ata_sg_setup: ENTER, ata1
>> >> [ =A0 =A02.989996] ata_sg_setup: 1 sg elements mapped
>> >> [ =A0 =A02.994431] max_sge now 1
>> >> [ =A0 =A02.997041] max_sge now 1
>> >> [ =A0 =A03.147167] IP-Config: Guessing netmask 255.255.255.0
>> >> [ =A0 =A03.152315] IP-Config: Complete:
>> >> [ =A0 =A03.155546] =A0 =A0 =A0device=3Deth0, addr=3D192.168.0.20,
>> >> mask=3D255.255.255.0, gw=3D255.255.255.255,
>> >> [ =A0 =A03.163391] =A0 =A0 =A0host=3DP1020RDB, domain=3D, nis-domain=
=3D(none),
>> >> [ =A0 =A03.168962] =A0 =A0 =A0bootserver=3D192.168.0.7, rootserver=3D=
192.168.0.7,
>> >> rootpath=3D
>> >> [ =A0 =A04.147148] PHY: 0:01 - Link is Up - 1000/Full
>> >> [ =A0 =A04.151702] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
>> >> [ =A0 =A07.999132] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 =A08.003672] ata_sg_clean: unmapping 1 sg elements
>> >> [ =A0 =A08.008369] ata1.00: qc timeout (cmd 0xec)
>> >> [ =A0 =A08.012474] ata1.00: failed to IDENTIFY (I/O error, err_mask=
=3D0x4)
>> >> [ =A0 =A08.018566] ata_eh_revalidate_and_attach: EXIT rc=3D-5
>> >> [ =A0 =A08.023534] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 10.167138] sil24_softreset: ENTER
>> >> [ =A0 10.183147] ata_dev_classify: found ATA device by sig
>> >> [ =A0 10.188197] sil24_softreset: EXIT, class=3D1
>> >> [ =A0 10.192298] ata_eh_thaw_port: ata1 port thawed
>> >> [ =A0 10.196737] ata_std_postreset: ENTER
>> >> [ =A0 10.200316] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
>> >> [ =A0 10.206318] ata_std_postreset: EXIT
>> >> [ =A0 10.209806] ata_eh_revalidate_and_attach: ENTER
>> >> [ =A0 10.214335] ata1.00: ata_dev_read_id: ENTER
>> >> [ =A0 10.214344] ata_sg_setup: ENTER, ata1
>> >> [ =A0 10.217998] ata_sg_setup: 1 sg elements mapped
>> >> [ =A0 14.539135] eth0: no IPv6 routers present
>> >> [ =A0 20.219208] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 20.223743] ata_sg_clean: unmapping 1 sg elements
>> >> [ =A0 20.228439] ata1.00: qc timeout (cmd 0xec)
>> >> [ =A0 20.232540] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0=
x4)
>> >> [ =A0 20.238631] ata_eh_revalidate_and_attach: EXIT rc=3D-5
>> >> [ =A0 20.243600] ata1: limiting SATA link speed to 1.5 Gbps
>> >> [ =A0 20.248739] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 22.447139] sil24_softreset: ENTER
>> >> [ =A0 22.463149] ata_dev_classify: found ATA device by sig
>> >> [ =A0 22.468199] sil24_softreset: EXIT, class=3D1
>> >> [ =A0 22.472300] ata_eh_thaw_port: ata1 port thawed
>> >> [ =A0 22.476739] ata_std_postreset: ENTER
>> >> [ =A0 22.480318] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10=
)
>> >> [ =A0 22.486406] ata_std_postreset: EXIT
>> >> [ =A0 22.489893] ata_eh_revalidate_and_attach: ENTER
>> >> [ =A0 22.494421] ata1.00: ata_dev_read_id: ENTER
>> >> [ =A0 22.494428] ata_sg_setup: ENTER, ata1
>> >> [ =A0 22.498080] ata_sg_setup: 1 sg elements mapped
>> >> [ =A0 52.499142] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 52.503678] ata_sg_clean: unmapping 1 sg elements
>> >> [ =A0 52.508374] ata1.00: qc timeout (cmd 0xec)
>> >> [ =A0 52.512477] ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0=
x4)
>> >> [ =A0 52.518570] ata_eh_revalidate_and_attach: EXIT rc=3D-5
>> >> [ =A0 52.523536] __ata_port_freeze: ata1 port frozen
>> >> [ =A0 54.739148] sil24_softreset: ENTER
>> >> [ =A0 54.755149] ata_dev_classify: found ATA device by sig
>> >> [ =A0 54.760209] sil24_softreset: EXIT, class=3D1
>> >> [ =A0 54.764312] ata_eh_thaw_port: ata1 port thawed
>> >> [ =A0 54.768751] ata_std_postreset: ENTER
>> >> [ =A0 54.772330] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 10=
)
>> >> [ =A0 54.778419] ata_std_postreset: EXIT
>> >> [ =A0 54.781906] ata_eh_revalidate_and_attach: ENTER
>> >> [ =A0 54.786435] ata_eh_recover: EXIT, rc=3D0
>> >> [ =A0 54.790184] ata_scsi_error: EXIT
>> >> [ =A0 54.793440] ata_port_schedule_eh: port EH scheduled
>> >> [ =A0 54.798330] ata_scsi_error: ENTER
>> >> [ =A0 54.801651] ata_eh_link_autopsy: ENTER
>> >> [ =A0 54.805398] ata_eh_recover: ENTER
>> >> [ =A0 54.808717] __ata_port_freeze: ata2 port frozen
>> >> [ =A0 56.883149] ata_eh_thaw_port: ata2 port thawed
>> >> [ =A0 56.887593] ata_std_postreset: ENTER
>> >> [ =A0 56.891171] ata2: SATA link down (SStatus 0 SControl 0)
>> >> [ =A0 56.896392] ata_std_postreset: EXIT
>> >> [ =A0 56.899880] ata_eh_revalidate_and_attach: ENTER
>> >> [ =A0 56.904409] ata_eh_recover: EXIT, rc=3D0
>> >> [ =A0 56.908157] ata_scsi_error: EXIT
>> >> [ =A0 56.931100] VFS: Mounted root (nfs filesystem) on device 0:15.
>> >> [ =A0 56.937349] devtmpfs: mounted
>> >> [ =A0 56.940365] Freeing unused kernel memory: 220k init
>> >>
>> >>
>> >> [ =A0 =A00.518188] WARNING: at drivers/ata/libata-core.c:6082
>> >>
>> >> which means that pdev->irq is 0
>> >>
>> >> lspci -vvvn:
>> >>
>> >> root@p1020rdb:~# lspci -nvv
>> >> 0000:00:00.0 0604: 1957:0100 (rev 10)
>> >> =A0 =A0 =A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p-
>> ParErr-
>> >> Stepping- SERR+ FastB2B- DisINTx-
>> >> =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort-
>> >> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >> =A0 =A0 =A0 Latency: 0
>> >> =A0 =A0 =A0 Region 0: Memory at <ignored> (32-bit, non-prefetchable)
>> >> =A0 =A0 =A0 Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-=
latency=3D0
>> >> =A0 =A0 =A0 I/O behind bridge: 00000000-00000fff
>> >> =A0 =A0 =A0 Memory behind bridge: a0000000-bfffffff
>> >> =A0 =A0 =A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort-
>> >> <TAbort- <MAbort- <SERR- <PERR-
>> >> =A0 =A0 =A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- Fast=
B2B-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- Disc=
TmrSERREn-
>> >> =A0 =A0 =A0 Capabilities: [44] Power Management version 2
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D=
0mA
>> >> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D=
0 PME-
>> >> =A0 =A0 =A0 Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCap: MaxPayload 256 bytes, PhantFunc 0=
, Latency L0s
>> >> <64ns, L1 <1us
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtTag- RBE- FLReset-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCtl: Report errors: Correctable- Non-F=
atal+ Fatal+
>> >> Unsupported+
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RlxdOrd+ ExtTag- PhantFun=
c- AuxPwr- NoSnoop+
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MaxPayload 128 bytes, Max=
ReadReq 512 bytes
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevSta: CorrErr- UncorrErr- FatalErr- Uns=
uppReq- AuxPwr-
>> >> TransPend-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCap: Port #0, Speed 2.5GT/s, Width x4,=
 ASPM L0s,
>> >> Latency L0 <2us,
>> >> L1 unlimited
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClockPM- Surprise- LLActR=
ep- BwNot-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCtl: ASPM Disabled; RCB 128 bytes Disa=
bled- Retrain-
>> >> CommClk-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtSynch- ClockPM- AutWid=
Dis- BWInt- AutBWInt-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- T=
rain- SlotClk-
>> >> DLActive-
>> >> BWMgmt- ABWMgmt-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 RootCtl: ErrCorrectable- ErrNon-Fatal- Er=
rFatal-
>> PMEIntEna-
>> >> CRSVisible-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 RootCap: CRSVisible-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 RootSta: PME ReqID 0000, PMEStatus- PMEPe=
nding-
>> >> =A0 =A0 =A0 Capabilities: [100] Advanced Error Reporting
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESta: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UEMsk: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- Cmp=
ltAbrt-
>> >> UnxCmplt- RxOF+
>> >> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CESta: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEMsk: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 AERCap: First Error Pointer: 00, GenCap+ =
CGenEn- ChkCap+
>> >> ChkEn-
>> >> =A0 =A0 =A0 Kernel driver in use: pcieport
>> >>
>> >> 0001:02:00.0 0604: 1957:0100 (rev 10)
>> >> =A0 =A0 =A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p-
>> ParErr-
>> >> Stepping- SERR+ FastB2B- DisINTx-
>> >> =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort-
>> >> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >> =A0 =A0 =A0 Latency: 0, Cache Line Size: 32 bytes
>> >> =A0 =A0 =A0 Region 0: Memory at <ignored> (32-bit, non-prefetchable)
>> >> =A0 =A0 =A0 Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-=
latency=3D0
>> >> =A0 =A0 =A0 I/O behind bridge: 00000000-00000fff
>> >> =A0 =A0 =A0 Memory behind bridge: c0000000-dfffffff
>> >> =A0 =A0 =A0 Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort-
>> >> <TAbort- <MAbort- <SERR- <PERR-
>> >> =A0 =A0 =A0 BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- Fast=
B2B-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 PriDiscTmr- SecDiscTmr- DiscTmrStat- Disc=
TmrSERREn-
>> >> =A0 =A0 =A0 Capabilities: [44] Power Management version 2
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D=
0mA
>> >> PME(D0+,D1+,D2+,D3hot+,D3cold+)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D=
0 PME-
>> >> =A0 =A0 =A0 Capabilities: [4c] Express (v1) Root Port (Slot-), MSI 00
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCap: MaxPayload 256 bytes, PhantFunc 0=
, Latency L0s
>> >> <64ns, L1 <1us
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtTag- RBE- FLReset-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCtl: Report errors: Correctable- Non-F=
atal+ Fatal+
>> >> Unsupported+
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RlxdOrd+ ExtTag- PhantFun=
c- AuxPwr- NoSnoop+
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MaxPayload 128 bytes, Max=
ReadReq 512 bytes
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevSta: CorrErr- UncorrErr- FatalErr- Uns=
uppReq- AuxPwr-
>> >> TransPend-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCap: Port #0, Speed 2.5GT/s, Width x4,=
 ASPM L0s,
>> >> Latency L0 <2us,
>> >> L1 unlimited
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClockPM- Surprise- LLActR=
ep- BwNot-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCtl: ASPM Disabled; RCB 128 bytes Disa=
bled- Retrain-
>> >> CommClk-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtSynch- ClockPM- AutWid=
Dis- BWInt- AutBWInt-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- T=
rain- SlotClk-
>> >> DLActive-
>> >> BWMgmt- ABWMgmt-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 RootCtl: ErrCorrectable- ErrNon-Fatal- Er=
rFatal-
>> PMEIntEna-
>> >> CRSVisible-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 RootCap: CRSVisible-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 RootSta: PME ReqID 0000, PMEStatus- PMEPe=
nding-
>> >> =A0 =A0 =A0 Capabilities: [100] Advanced Error Reporting
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESta: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UEMsk: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- Cmp=
ltAbrt-
>> >> UnxCmplt- RxOF+
>> >> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CESta: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEMsk: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 AERCap: First Error Pointer: 00, GenCap+ =
CGenEn- ChkCap+
>> >> ChkEn-
>> >> =A0 =A0 =A0 Kernel driver in use: pcieport
>> >>
>> >> 0001:03:00.0 0104: 1095:3132 (rev 01)
>> >> =A0 =A0 =A0 Subsystem: 1095:7132
>> >> =A0 =A0 =A0 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoo=
p-
>> ParErr-
>> >> Stepping- SERR- FastB2B- DisINTx-
>> >> =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >=
TAbort-
>> >> <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >> =A0 =A0 =A0 Latency: 0, Cache Line Size: 32 bytes
>> >> =A0 =A0 =A0 Interrupt: pin A routed to IRQ 0
>> >> =A0 =A0 =A0 Region 0: Memory at c0000000 (64-bit, non-prefetchable)
>> [size=3D128]
>> >> =A0 =A0 =A0 Region 2: Memory at c0004000 (64-bit, non-prefetchable)
>> [size=3D16K]
>> >> =A0 =A0 =A0 Region 4: I/O ports at 1000 [size=3D128]
>> >> =A0 =A0 =A0 [virtual] Expansion ROM at c0080000 [disabled] [size=3D51=
2K]
>> >> =A0 =A0 =A0 Capabilities: [54] Power Management version 2
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D=
0mA PME(D0-,D1-
>> ,D2-
>> >> ,D3hot-,D3cold-)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D=
1 PME-
>> >> =A0 =A0 =A0 Capabilities: [5c] MSI: Mask- 64bit+ Count=3D1/1 Enable-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address: 0000000000000000 =A0Data: 0000
>> >> =A0 =A0 =A0 Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCap: MaxPayload 1024 bytes, PhantFunc =
0, Latency L0s
>> >> <64ns, L1 <1us
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtTag- AttnBtn- AttnInd-=
 PwrInd- RBE- FLReset-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCtl: Report errors: Correctable- Non-F=
atal- Fatal-
>> >> Unsupported-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RlxdOrd- ExtTag- PhantFun=
c- AuxPwr- NoSnoop-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MaxPayload 128 bytes, Max=
ReadReq 1024 bytes
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevSta: CorrErr- UncorrErr- FatalErr- Uns=
uppReq- AuxPwr-
>> >> TransPend-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCap: Port #0, Speed 2.5GT/s, Width x1,=
 ASPM L0s,
>> >> Latency L0
>> >> unlimited, L1 unlimited
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClockPM- Surprise- LLActR=
ep- BwNot-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disab=
led- Retrain-
>> >> CommClk-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtSynch- ClockPM- AutWid=
Dis- BWInt- AutBWInt-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- T=
rain- SlotClk+
>> >> DLActive-
>> >> BWMgmt- ABWMgmt-
>> >> =A0 =A0 =A0 Capabilities: [100] Advanced Error Reporting
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESta: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UEMsk: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- Cmp=
ltAbrt-
>> >> UnxCmplt- RxOF+
>> >> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CESta: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEMsk: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 AERCap: First Error Pointer: 00, GenCap+ =
CGenEn- ChkCap+
>> >> ChkEn-
>> >> =A0 =A0 =A0 Kernel driver in use: sata_sil24
>> >>
>> >> root@p1020rdb:~#
>> >>
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D=
0mA PME(D0-,D1-
>> ,D2-
>> >> ,D3hot-,D3cold-)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 PME-Enable- DSel=3D0 DScale=3D=
1 PME-
>> >> =A0 =A0 =A0 Capabilities: [5c] MSI: Mask- 64bit+ Count=3D1/1 Enable-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address: 0000000000000000 =A0Data: 0000
>> >> =A0 =A0 =A0 Capabilities: [70] Express (v1) Legacy Endpoint, MSI 00
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCap: MaxPayload 1024 bytes, PhantFunc =
0, Latency L0s
>> >> <64ns, L1 <1us
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtTag- AttnBtn- AttnInd-=
 PwrInd- RBE- FLReset-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCtl: Report errors: Correctable- Non-F=
atal- Fatal-
>> >> Unsupported-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RlxdOrd- ExtTag- PhantFun=
c- AuxPwr- NoSnoop-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MaxPayload 128 bytes, Max=
ReadReq 1024 bytes
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevSta: CorrErr- UncorrErr- FatalErr- Uns=
uppReq- AuxPwr-
>> >> TransPend-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCap: Port #0, Speed 2.5GT/s, Width x1,=
 ASPM L0s,
>> >> Latency L0
>> >> unlimited, L1 unlimited
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClockPM- Surprise- LLActR=
ep- BwNot-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCtl: ASPM Disabled; RCB 64 bytes Disab=
led- Retrain-
>> >> CommClk-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtSynch- ClockPM- AutWid=
Dis- BWInt- AutBWInt-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkSta: Speed 2.5GT/s, Width x1, TrErr- T=
rain- SlotClk+
>> >> DLActive-
>> >> BWMgmt- ABWMgmt-
>> >> =A0 =A0 =A0 Capabilities: [100] Advanced Error Reporting
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESta: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UEMsk: =A0DLP- SDES- TLP- FCP- CmpltTO- C=
mpltAbrt-
>> >> UnxCmplt- RxOF-
>> >> MalfTLP- ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- Cmp=
ltAbrt-
>> >> UnxCmplt- RxOF+
>> >> MalfTLP+ ECRC- UnsupReq- ACSViol-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CESta: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEMsk: =A0RxErr- BadTLP- BadDLLP- Rollove=
r- Timeout-
>> >> NonFatalErr-
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 AERCap: First Error Pointer: 00, GenCap+ =
CGenEn- ChkCap+
>> >> ChkEn-
>> >> =A0 =A0 =A0 Kernel driver in use: sata_sil24
>> >> =A0 =A0 =A0 Kernel modules: sata_sil24
>> >>
>> >>
>> >> --
>> >> Leon
>> >
>> >
>> >
>>
>>
>>
>> --
>> Leon
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>



--=20
Leon
