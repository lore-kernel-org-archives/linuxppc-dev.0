Return-Path: <mike@terascala.com>
Received: from hermes.terascala.com (terascala.com [75.147.14.129])
	by ozlabs.org (Postfix) with ESMTP id E189FB7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 02:44:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Regression detecting memory size on PPC440EPx
Date: Mon, 5 Oct 2009 11:44:07 -0400
Message-ID: <2C7DE72B9BD00F44BAECA5B0CBB873955CADF3@hermes.terascala.com>
In-Reply-To: <4ACA1300.6040105@lebon.org.ua>
From: "Mike Nuss" <mike@terascala.com>
To: "Mikhail Zolotaryov" <lebon@lebon.org.ua>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(top-posting corrected)

Mikhail Zolotaryov wrote:
> Mike Nuss wrote:
>> There was a fix a while back called "Correct memory size calculation
>> for Denali based boards" that corrected the data width detection in
>> the 4xx bootwrapper.=20
>>=20
>> This seems to have had the unintended consequence of exposing another
>> bug in the same code.  I have a board very similar to Sequoia, except
>> that it uses a DDR2 DIMM module.  It uses a single 256MB DIMM.  After
>> upgrading to the latest kernel, which includes the previously
>> mentioned fix, U-Boot works fine, but the kernel detects 512MB
>> instead, and of course, the kernel panics.=20
>>=20
>> The error seems to be in the calculation of row bits.  U-Boot's SPD
>> detection says that the DIMM uses 13 bits, but I added some
>> printf()s to the bootwrapper, and it is setting row to 14 instead.=20
>> I'm not too clear on how this code works; it calculates the row bits
>> by subtracting the row from max_row, and maybe max_row is wrong?
>
> Hi Mike,
>=20
> Address width calculation is based on the DDR-controller configuration
> set by the bootloader. It would be helpful for further discussion if
> you could send DDR0_00..DDR0_44 register values and memory
> configuration used (no of banks, bank size, I/O width) to check
> calculations. Thanks.=20
>=20
> P.S. Sequoia board also has DDR2 SDRAM from Micron.
>=20
> Best regards,
> Mikhail Zolotaryov

Thanks for your reply.

Here is the dump from U-Boot during intialization with DEBUG turned on
in the denali code:

  Register Dump:
        DDR0_00 =3D 0x0000190A        DDR0_01 =3D 0x010000FF
        DDR0_02 =3D 0x020C0E00        DDR0_03 =3D 0x02030602
        DDR0_04 =3D 0x0A020200        DDR0_05 =3D 0x02020308
        DDR0_06 =3D 0x0102C812        DDR0_07 =3D 0x000D0100
        DDR0_08 =3D 0x02C80001        DDR0_09 =3D 0x00011D5F
        DDR0_10 =3D 0x00000100        DDR0_11 =3D 0x0022C800
        DDR0_12 =3D 0x00000003        DDR0_14 =3D 0x00000000
        DDR0_17 =3D 0x19000000        DDR0_18 =3D 0x19191919
        DDR0_19 =3D 0x19191919        DDR0_20 =3D 0x0B0B0B0B
        DDR0_21 =3D 0x0B0B0B0B        DDR0_22 =3D 0x00267F0B
        DDR0_23 =3D 0x00000000        DDR0_24 =3D 0x01020001
        DDR0_25 =3D 0x20410000        DDR0_26 =3D 0x2DB40514
        DDR0_27 =3D 0x00008236        DDR0_28 =3D 0x00000000
        DDR0_31 =3D 0x00000000        DDR0_32 =3D 0x00000000
        DDR0_33 =3D 0x00000000        DDR0_34 =3D 0x00000000
        DDR0_35 =3D 0x00000000        DDR0_36 =3D 0x00000000
        DDR0_37 =3D 0x00000000        DDR0_38 =3D 0x00000000
        DDR0_39 =3D 0x00000000        DDR0_40 =3D 0x00000000
        DDR0_41 =3D 0x00000000        DDR0_42 =3D 0x00000006
        DDR0_43 =3D 0x030A0200        DDR0_44 =3D 0x00000003
dram_size =3D 268435456

  Register Dump:
        DDR0_00 =3D 0x00C0190A        DDR0_01 =3D 0x010000FF
        DDR0_02 =3D 0x020C0E01        DDR0_03 =3D 0x02030602
        DDR0_04 =3D 0x0A020200        DDR0_05 =3D 0x02020308
        DDR0_06 =3D 0x0102C812        DDR0_07 =3D 0x000D0100
        DDR0_08 =3D 0x02C80001        DDR0_09 =3D 0x00011D5E
        DDR0_10 =3D 0x00000100        DDR0_11 =3D 0x0022C800
        DDR0_12 =3D 0x00000003        DDR0_14 =3D 0x00000000
        DDR0_17 =3D 0x1E014800        DDR0_18 =3D 0x1E1E1E1E
        DDR0_19 =3D 0x1E1E1E1E        DDR0_20 =3D 0x0B0B0B0B
        DDR0_21 =3D 0x0B0B0B0B        DDR0_22 =3D 0x00267E0B
        DDR0_23 =3D 0x00000000        DDR0_24 =3D 0x01020001
        DDR0_25 =3D 0x20410000        DDR0_26 =3D 0x2DB40514
        DDR0_27 =3D 0x00008236        DDR0_28 =3D 0x00000000
        DDR0_31 =3D 0x00000000        DDR0_32 =3D 0x00000000
        DDR0_33 =3D 0x00000000        DDR0_34 =3D 0x00000000
        DDR0_35 =3D 0x00000000        DDR0_36 =3D 0x00000000
        DDR0_37 =3D 0x00000000        DDR0_38 =3D 0x00000000
        DDR0_39 =3D 0x00000000        DDR0_40 =3D 0x00000000
        DDR0_41 =3D 0x00000000        DDR0_42 =3D 0x00000006
        DDR0_43 =3D 0x030A0200        DDR0_44 =3D 0x00000003
Zeroing SDRAM...Completed
256 MB (ECC not enabled, 333 MHz, CL3)


Here is the memory configuration:
SPD data revision            1.2
Bytes used                   0x80
Serial memory size           0x100
Memory type                  DDR2
Row address bits             13
Column address bits          10
Number of ranks              1
Module data width            64 bits
Interface signal levels      SSTL 1.8 V
SDRAM cycle time             3.0 ns
SDRAM access time            0.45 ns
EDC configuration            None
Self refresh, rate           7.8 us
SDRAM width (primary)        16
Burst length(s)              8 4
Number of banks              4
CAS latency(s)               5 4 3
Module attributes:
  0 PLLs on DIMM
  Supports 50 ohm ODT
  Supports weak driver
SDRAM cycle time (2nd highest CAS latency)        3.75 ns
SDRAM access from clock (2nd highest CAS latency) 0.45 ns
SDRAM cycle time (3rd highest CAS latency)        5.0 ns
SDRAM access from clock (3rd highest CAS latency) 0.45 ns
Minimum row precharge        15.00 ns
Row active to row active min 10.00 ns
RAS to CAS delay min         15.00 ns
Minimum RAS pulse width      45 ns
Density of each row          256 MiB
Command and Address setup    0.20 ns
Command and Address hold     0.27 ns
Data signal input setup      0.10 ns
Data signal input hold       0.17 ns
Manufacturer's JEDEC ID      2C 00 00 00 00 00 00 00
Manufacturing Location       08
Manufacturer's Part Number   34 48 54 46 33 32 36 34 48 59 2D 36 36 37
44 33 20 20
Revision Code                03 00
Manufacturing Date           07 32
Assembly Serial Number       D3 23 09 9E


Here is the bootwrapper output on startup (everything except the last
line is from printf()s added by me):

real_cs:1
cs:1
dpath bytes:8
row:14
col:10
banks:4
memsize:536870912
memsize (errata):536866816
Memory <- <0x0 0x0 0x1ffff000> (511MB)

Note 511MB is obviously wrong. "row" differs from "Row address bits"
from U-Boot, which is where I guess the problem lies.

Thanks,
Mike
