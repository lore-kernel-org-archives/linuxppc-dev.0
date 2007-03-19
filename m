Return-Path: <aldo.lab@gmail.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.227])
	by ozlabs.org (Postfix) with ESMTP id 85E1EDDED6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 19:37:04 +1100 (EST)
Received: by hu-out-0506.google.com with SMTP id 16so5690544hue
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Mar 2007 01:37:01 -0700 (PDT)
Message-ID: <6e41d1460703190137w3d95493fq6b4359c6a2e9dd59@mail.gmail.com>
Date: Mon, 19 Mar 2007 09:37:01 +0100
From: "aldo lab" <aldo.lab@gmail.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Subject: Re: m8260_map_io
In-Reply-To: <45FAE45D.7000908@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
References: <6e41d1460703161136q7afb3077r49b11cb9a123c124@mail.gmail.com>
	<45FAE45D.7000908@ru.mvista.com>
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

Hi Sergei,

There are several option that you can set for internal register of mpc8280 =
:

13=9615 ISB Initial internal space base select. Defines the initial
value of IMMR[0=9614] and determines the
base address of the internal memory space.
000 0x0000_0000
001 0x00F0_0000
010 0x0F00_0000
011 0x0FF0_0000
100 0xF000_0000
101 0xF0F0_0000
110 0xFF00_0000
111 0xFFF0_0000
See Section 4.3.2.7, "Internal Memory Map Register (IMMR)."

and 0xe0000000 is not mentioned so I'm not sure that you said is correct.
Infact the line of code that map internal register is :

/* Map IMMR region to a 256MB BAT */
> > 207         addr =3D (cpm2_immr !=3D NULL) ? (uint)cpm2_immr : CPM_MAP_=
ADDR;
> > 208         io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);

and for ADS the value is 0xf000000
instead what I was referring is:


    /* Map I/O region to a 256MB BAT */
> > 211         io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _P=
AGE_IO);

where IO_VIRT_ADDR is equal to 0xe0000000, you can find it in
include/asm-ppc/mpc8260.h

59
60 /* Map 256MB I/O region
61  */
62 #ifndef IO_PHYS_ADDR
63 #define IO_PHYS_ADDR    0xe0000000
64 #endif
65 #ifndef IO_VIRT_ADDR
66 #define IO_VIRT_ADDR    IO_PHYS_ADDR
67 #endif
68

Reading manual of pq2fads-zu and other manual like mpc8272ads the
0xe0000000 region is marked as empty.

Regards
AS


On 3/16/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> aldo lab wrote:
>
> > I've seen a region of 256MB starting from 0xe0000000 that is io
> > blocking with a BAT filled with Inhibit cache and guarded.
> > do you know which is the reason of this mapping because is not so
> > clear from the code.
> >
> > 201 static void __init
> > 202 m8260_map_io(void)
> > 203 {
> > 204         uint addr;
> > 205
> > 206         /* Map IMMR region to a 256MB BAT */
> > 207         addr =3D (cpm2_immr !=3D NULL) ? (uint)cpm2_immr : CPM_MAP_=
ADDR;
> > 208         io_block_mapping(addr, addr, 0x10000000, _PAGE_IO);
> > 209
> > 210         /* Map I/O region to a 256MB BAT */
> > 211         io_block_mapping(IO_VIRT_ADDR, IO_PHYS_ADDR, 0x10000000, _P=
AGE_IO);
> > 212 }
> > 213
>
>    MPC82xx SoC registers are mapped there.
>
> > Thank you
> > Aldo
>
> WBR, Sergei
>
