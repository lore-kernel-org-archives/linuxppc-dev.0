Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x22d.google.com (mail-ea0-x22d.google.com
 [IPv6:2a00:1450:4013:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C84CC2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2013 03:27:36 +1100 (EST)
Received: by mail-ea0-f173.google.com with SMTP id g15so359440eak.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2013 08:27:32 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131114100917.31f674d7@crub>
Date: Fri, 15 Nov 2013 17:27:30 +0100
Message-Id: <51E043E6-19FB-4655-9B3C-3B81F868DC47@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
 <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
 <20131114100917.31f674d7@crub>
To: Anatolij Gustschin <agust@denx.de>
Cc: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>,
 linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello again, I=92ve tried this code, but we are not able to change cs4 =
reg value=85 what could be?

=97

#define MALab_DEVICE_NAME	"MALab"
#define MPC5xxx_MM_CS4_START	(MBAR_BASE + 0x0024)
#define MPC5xxx_MM_CS4_STOP	(MBAR_BASE + 0x0028)
#define MPC5xxx_MM_IPBI	 (MBAR_BASE + 0x0054)

#define MALab_MM_START	 0x10020000U
#define MALab_MM_END	 0x10020FFFU
#define MALab_MM_SIZE	 0x00001000U

int init_module(void) { ...
    u16 cs4_start_value;
    u16 cs4_stop_value;
    u32 cs4_enable_value;
   =20
    u8 rvoice_ioaddr_value;

   =20
    // reserve a page of memory for our hardware /proc/iomem
    if ( check_region(MALab_MM_START,MALab_MM_SIZE) ) {
        printk (KERN_ALERT "LED init_module: memory already in use\n");
        return -EBUSY;
    }

   =20
    request_mem_region(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);

   =20
    void __iomem *cs0_reg   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x0300), 4);
    void __iomem *cs3_reg   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x030C), 4);
   =20
    void __iomem *ipbi_cr =3D ioremap ((volatile unsigned =
long)(MPC5xxx_MM_IPBI), 4);
    void __iomem *cs4_start  =3D ioremap ((volatile unsigned =
long)(MPC5xxx_MM_CS4_START + 2), 2);
    void __iomem *cs4_stop   =3D ioremap ((volatile unsigned =
long)(MPC5xxx_MM_CS4_STOP + 2), 2);
   =20
    void __iomem *cs4_enable   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x0310), 4);
    void __iomem *cs_ctrl_reg   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x0318), 4);
    void __iomem *rvoice_ioaddr   =3D ioremap ((volatile unsigned =
long)(MALab_MM_START), MALab_MM_SIZE);
   =20
    //disable CSO

    out_be32(cs0_reg, 0x0004ed00);

   =20
    //disable CS3

    out_be32(cs3_reg, 0x0002cf00);

    // enable LocalBus chip select CS4
    out_be32(ipbi_cr, 0x00290001);

    cs4_start_value=3Din_be16(cs4_start);
    cs4_start_value=3DMALab_MM_START >>16;
    out_be16(cs4_start, cs4_start_value);
    cs4_stop_value=3Din_be16(cs4_stop);
    cs4_stop_value=3DMALab_MM_END >>16;
    out_be16(cs4_stop, cs4_stop_value);

    //enable CS4 and WSE
    out_be32(ipbi_cr, 0x00100001);

    // LocalBus Chip Select 4 Configuration Register
    out_be32(cs4_enable, 0x0002DC00);

    //Enable Chip Select Control Register
    out_be32(cs_ctrl_reg, 0x01000000);

   =20
    rvoice_ioaddr_value=3Din_8(rvoice_ioaddr);
    rvoice_ioaddr_value=3D0xAA;

    printk("rvoice_ioaddr_value---before : %x \n",in_8(rvoice_ioaddr));
    out_8(rvoice_ioaddr, rvoice_ioaddr_value);
    printk("rvoice_ioaddr_value---after : %x \n",in_8(rvoice_ioaddr));
   =20
    =85 }


=97=97

Thank you

Lorenzo


On 14/nov/2013, at 10:09 AM, Anatolij Gustschin <agust@denx.de> wrote:

> Hi,
>=20
> you mention the 0x1002000 as address, this is an address in SDRAM. In
> the previous email you mentioned 0x10020000 as the address. Please =
check
> what is passed to ioremap() as the first argument. Usually the mapping
> and the access to a 8-bit wide register would happen as follows:
>=20
>   u8 regval;
>=20
>   /* map 4kbyte reg. space */
>   virt_base =3D ioremap(0x10020000, 0x1000);
>   if (!virt_base) {
>     printk("fpga ioremap failed\n");
>     return;
>   }
>=20
>   regval =3D in_8(virt_base);
>=20
>   printk("reg. value 0x%02x\n", regval);
>=20
>=20
>=20
> thanks,
>=20
> Anatolij
>=20
>=20
> On Thu, 14 Nov 2013 09:38:35 +0100
> neorf3k <neorf3k@gmail.com> wrote:
>=20
>> Thank you again=85
>> we have checked, and the settings in Chip Select 4 Configuration, =
seems to be ok=85
>>=20
>> The strange thing is the return value from ioremap(). In U-Boot =
return value from address 0x1002000 is 0x45f80360=85 if we try to map it =
in our module, then we use ioremap(), return value is 0x10101010. So =
maybe the register address is mapped wrong=85 what could i fix it?
>> Then, after we have setted up the reg at 0x1002000 and we boot linux=85=
 the 0x1002000 doesn=92t change its value=85=20
>>=20
>> Thanks again=85
>>=20
>> Lorenzo
>>=20
>> On 13/nov/2013, at 07:06 PM, Anatolij Gustschin <agust@denx.de> =
wrote:
>>=20
>>> On Wed, 13 Nov 2013 14:48:24 +0100
>>> neorf3k <neorf3k@gmail.com> wrote:
>>>=20
>>>> Yes, that is a device on the lpb via an fpga. We  have tried to =
configure
>>>> the chip select 4 configuration register at address MBAR + 0x0310, =
and it
>>>> seems to be ok. what do you mean with =93chip select parameters=94?
>>>=20
>>> I meant the settings you can set up in the Chip Select 1=967 =
Configuration
>>> Registers, like address and data bus size, wait-states, etc.
>>>=20
>>>> We have been able to edit it in U-BOOT, and the board (that chip) =
now works=85
>>>> The strange thing, is that when we read in linux, at that address, =
we see
>>>> other content value=85
>>>> Suggestions?
>>>=20
>>> if you can access the register under U-Boot and read out the
>>> expected values, then the access should work under Linux too,
>>> assuming the chip select config is not overwritten somewhere
>>> while booting and the register address range is mapped correctly.
>>> I don't know your code, so I would first check if the register
>>> mapping is done correctly, i.e. check the return value of ioremap()
>>> for errors, then check if the chip select configuration is still
>>> valid when the kernel is up. Also verify that your fpga is not
>>> in the reset state when Linux is running.
>>>=20
>>> thanks,
>>>=20
>>> Anatolij
>>=20
>>=20
