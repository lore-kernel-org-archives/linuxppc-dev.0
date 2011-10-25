Return-Path: <willy.jacobs@nl.thalesgroup.com>
From: JACOBS Willy <willy.jacobs@nl.thalesgroup.com>
To: "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>
Date: Tue, 25 Oct 2011 16:37:35 +0200
Subject: MPC8548 core "freezes"
Message-ID: <4CE4CD7158AFEE44A025CA3D42C323811B16E1D65A@spvw1505.ONE-05.GRP>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We discover on our own developed board based on a MPC8548, a FPGA connected
through the PCIe bus which the PQ3, and running U-BOOT, Linux 2.6.33.7 (+ R=
T
patches), and a Wind River 2.0 root file system on irregular occurrences th=
at the
PQ3 "freezes". The main application running on the PQ3 transfer data betwee=
n the
FPGA/PCIe (bi-directional over several PCIe lanes) and the MOTTSECs (at gig=
abit
speed). =20
With a Wind River Probe we can connected to the PQ3 JTAG, and to look
into the PQ3 registers. In the erroneous state we always see:

- all the CPU e500 core registers have the value 0
- the L1 I/D caches are disabled
- the L2 cache is still enabled
- the DDR SDRAM logic is disabled (DDR_SDRAM_CFG[MEN_EN] =3D 0); the other =
DDR_SDRAM_CFG bits contains the programmed value
- the contents of the remaining peripheral registers look OK

We have already swapped boards, without any success.
On the same boards we have also other applications running without this "fr=
eeze" problem.
Because no exception are generated it's very difficult to catch the root ca=
use.
So any help is appreciated.

U-Boot 2009.01.01 (Oct 08 2010 - 08:35:06)

CPU:   8548, Version: 2.1, (0x80310021)
Core:  E500, Version: 2.2, (0x80210022)
Clock Configuration:
       CPU:1333.333 MHz, CCB:533.333 MHz,
       DDR:266.667 MHz (533.333 MT/s data rate), LBC:66.667 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
I2C:   ready
Board: thales,payarapc8548, 12nc: 955683208506, snr: 0014
DRAM:      DDR:  2 GB
FLASH: 128 MB
L2:    512 KB enabled
    PCI: 32 bit, 66 MHz, async, host, arbiter
               Scanning PCI bus 00
PCI on bus 00 - 00

    PCIE connected to slot as Root Complex (base address e000a000)
PCIE on bus 1 - 1
In:    serial
Out:   serial
Err:   serial
Net:   tsec0, tsec1, tsec2 [PRIME]

--- willy



------------------------------------------------------------------------------------------------------------
Disclaimer:

If you are not the intended recipient of this email, please notify the sender and delete it. 
Any unauthorized copying, disclosure or distribution of this email or its attachment(s) is forbidden. 
Thales Nederland BV will not accept liability for any damage caused by this email or its attachment(s). 
Thales Nederland BV is seated in Hengelo and is registered at the Chamber of Commerce under number 06061578.
------------------------------------------------------------------------------------------------------------
