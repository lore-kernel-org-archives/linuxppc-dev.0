Return-Path: <curieux.khetan@gmail.com>
Received: from mail-wg0-x22c.google.com (mail-wg0-x22c.google.com
 [IPv6:2a00:1450:400c:c00::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 847FD2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 22:48:30 +1100 (EST)
Received: by mail-wg0-f44.google.com with SMTP id a1so7117890wgh.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 03:48:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52BBF1CB.3070006@gmail.com>
References: <CAERE9PrGaOJS3YTBv61=JCEGyPxGnqr_8j=eKrnn7Y9vi8dMug@mail.gmail.com>
 <52BBF1CB.3070006@gmail.com>
Date: Thu, 26 Dec 2013 17:18:23 +0530
Message-ID: <CAERE9Prr_C31D96zuYbV0KQ7b_j8Te0A2DO8C+6YtetF0e6M_w@mail.gmail.com>
Subject: Re: MPC8641 based custom board kernel Bug
From: Ashish Khetan <curieux.khetan@gmail.com>
To: wyang <w90p710@gmail.com>
Content-Type: multipart/alternative; boundary=089e013c622009065404ee6e8e1a
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 kernelnewbies@kernelnewbies.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e013c622009065404ee6e8e1a
Content-Type: text/plain; charset=ISO-8859-1

i tried to dig more inside mpic_alloc fails. the function
of_find_matching_node calls inside from mpic_alloc() should return the node
at which pic is connected but it returns NULL. but why? In device tree i am
using the following.. may be it will helpful.
/dts-v1/;

/ {
    model = "MPC8641HPCN";
    compatible = "fsl,mpc8641hpcn";
    #address-cells = <0x1>;
    #size-cells = <0x1>;

    aliases {
        ethernet0 = "/soc8641@f8000000/ethernet@24000";
        ethernet1 = "/soc8641@f8000000/ethernet@25000";
        ethernet2 = "/soc8641@f8000000/ethernet@26000";
        ethernet3 = "/soc8641@f8000000/ethernet@27000";
        serial0 = "/soc8641@f8000000/serial@4500";
    };

    cpus {
        #address-cells = <0x1>;
        #size-cells = <0x0>;

        PowerPC,8641@0 {
            device_type = "cpu";
            reg = <0x0>;
            d-cache-line-size = <0x20>;
            i-cache-line-size = <0x20>;
            d-cache-size = <0x8000>;
            i-cache-size = <0x8000>;
            timebase-frequency = <0x0>;
            bus-frequency = <0x0>;
            clock-frequency = <0x0>;
        };
    };

    memory {
        device_type = "memory";
        reg = <0x0 0x20000000>;
    };

    localbus@f8005000 {
        #address-cells = <0x2>;
        #size-cells = <0x1>;
        compatible = "fsl,mpc8641-localbus", "simple-bus";
        reg = <0xf8005000 0x1000>;
        interrupts = <0x13 0x2>;
        interrupt-parent = <0x1>;
        ranges = <0x0 0x0 0xff000000 0x1000000>;

        flash@0,0 {
            compatible = "cfi-flash";
            reg = <0x0 0x0 0x800000>;
            bank-width = <0x2>;
            device-width = <0x2>;
            #address-cells = <0x1>;
            #size-cells = <0x1>;
        };
    };

    soc8641@f8000000 {
        #address-cells = <0x1>;
        #size-cells = <0x1>;
        device_type = "soc";
        compatible = "simple-bus";
        ranges = <0x0 0xf8000000 0x100000>;
        bus-frequency = <0x0>;

        mcm-law@0 {
            compatible = "fsl,mcm-law";
            reg = <0x0 0x1000>;
            fsl,num-laws = <0xa>;
        };

        mcm@1000 {
            compatible = "fsl,mpc8641-mcm", "fsl,mcm";
            reg = <0x1000 0x1000>;
            interrupts = <0x11 0x2>;
            interrupt-parent = <0x1>;
        };

        dma@21300 {
            #address-cells = <0x1>;
            #size-cells = <0x1>;
            compatible = "fsl,mpc8641-dma", "fsl,eloplus-dma";
            reg = <0x21300 0x4>;
            ranges = <0x0 0x21100 0x200>;
            cell-index = <0x0>;

            dma-channel@0 {
                compatible = "fsl,mpc8641-dma-channel",
"fsl,eloplus-dma-channel";
                reg = <0x0 0x80>;
                cell-index = <0x0>;
                interrupt-parent = <0x1>;
                interrupts = <0x14 0x2>;
            };

            dma-channel@80 {
                compatible = "fsl,mpc8641-dma-channel",
"fsl,eloplus-dma-channel";
                reg = <0x80 0x80>;
                cell-index = <0x1>;
                interrupt-parent = <0x1>;
                interrupts = <0x15 0x2>;
            };

            dma-channel@100 {
                compatible = "fsl,mpc8641-dma-channel",
"fsl,eloplus-dma-channel";
                reg = <0x100 0x80>;
                cell-index = <0x2>;
                interrupt-parent = <0x1>;
                interrupts = <0x16 0x2>;
            };

            dma-channel@180 {
                compatible = "fsl,mpc8641-dma-channel",
"fsl,eloplus-dma-channel";
                reg = <0x180 0x80>;
                cell-index = <0x3>;
                interrupt-parent = <0x1>;
                interrupts = <0x17 0x2>;
            };
        };

        ethernet@24000 {
            #address-cells = <0x1>;
            #size-cells = <0x1>;
            cell-index = <0x0>;
            device_type = "network";
            model = "TSEC";
            compatible = "gianfar";
            reg = <0x24000 0x1000>;
            ranges = <0x0 0x24000 0x1000>;
            local-mac-address = [00 00 00 00 00 00];
            interrupts = <0x1d 0x2 0x1e 0x2 0x22 0x2>;
            interrupt-parent = <0x1>;
            tbi-handle = <0x2>;
            phy-handle = <0x3>;
            phy-connection-type = "rgmii-id";

            mdio@520 {
                #address-cells = <0x1>;
                #size-cells = <0x0>;
                compatible = "fsl,gianfar-mdio";
                reg = <0x520 0x20>;

                ethernet-phy@0 {
                    interrupt-parent = <0x1>;
                    interrupts = <0xa 0x1>;
                    reg = <0x0>;
                    device_type = "ethernet-phy";
                    linux,phandle = <0x3>;
                };

                ethernet-phy@1 {
                    interrupt-parent = <0x1>;
                    interrupts = <0xa 0x1>;
                    reg = <0x1>;
                    device_type = "ethernet-phy";
                    linux,phandle = <0x5>;
                };

                ethernet-phy@2 {
                    interrupt-parent = <0x1>;
                    interrupts = <0xa 0x1>;
                    reg = <0x2>;
                    device_type = "ethernet-phy";
                    linux,phandle = <0x7>;
                };

                ethernet-phy@3 {
                    interrupt-parent = <0x1>;
                    interrupts = <0xa 0x1>;
                    reg = <0x3>;
                    device_type = "ethernet-phy";
                    linux,phandle = <0x9>;
                };

                tbi-phy@11 {
                    reg = <0x11>;
                    device_type = "tbi-phy";
                    linux,phandle = <0x2>;
                };
            };
        };

        ethernet@25000 {
            #address-cells = <0x1>;
            #size-cells = <0x1>;
            cell-index = <0x1>;
            device_type = "network";
            model = "TSEC";
            compatible = "gianfar";
            reg = <0x25000 0x1000>;
            ranges = <0x0 0x25000 0x1000>;
            local-mac-address = [00 00 00 00 00 00];
            interrupts = <0x23 0x2 0x24 0x2 0x28 0x2>;
            interrupt-parent = <0x1>;
            tbi-handle = <0x4>;
            phy-handle = <0x5>;
            phy-connection-type = "rgmii-id";

            mdio@520 {
                #address-cells = <0x1>;
                #size-cells = <0x0>;
                compatible = "fsl,gianfar-tbi";
                reg = <0x520 0x20>;

                tbi-phy@11 {
                    reg = <0x11>;
                    device_type = "tbi-phy";
                    linux,phandle = <0x4>;
                };
            };
        };

        ethernet@26000 {
            #address-cells = <0x1>;
            #size-cells = <0x1>;
            cell-index = <0x2>;
            device_type = "network";
            model = "TSEC";
            compatible = "gianfar";
            reg = <0x26000 0x1000>;
            ranges = <0x0 0x26000 0x1000>;
            local-mac-address = [00 00 00 00 00 00];
            interrupts = <0x1f 0x2 0x20 0x2 0x21 0x2>;
            interrupt-parent = <0x1>;
            tbi-handle = <0x6>;
            phy-handle = <0x7>;
            phy-connection-type = "rgmii-id";

            mdio@520 {
                #address-cells = <0x1>;
                #size-cells = <0x0>;
                compatible = "fsl,gianfar-tbi";
                reg = <0x520 0x20>;

                tbi-phy@11 {
                    reg = <0x11>;
                    device_type = "tbi-phy";
                    linux,phandle = <0x6>;
                };
            };
        };

        ethernet@27000 {
            #address-cells = <0x1>;
            #size-cells = <0x1>;
            cell-index = <0x3>;
            device_type = "network";
            model = "TSEC";
            compatible = "gianfar";
            reg = <0x27000 0x1000>;
            ranges = <0x0 0x27000 0x1000>;
            local-mac-address = [00 00 00 00 00 00];
            interrupts = <0x25 0x2 0x26 0x2 0x27 0x2>;
            interrupt-parent = <0x1>;
            tbi-handle = <0x8>;
            phy-handle = <0x9>;
            phy-connection-type = "rgmii-id";

            mdio@520 {
                #address-cells = <0x1>;
                #size-cells = <0x0>;
                compatible = "fsl,gianfar-tbi";
                reg = <0x520 0x20>;

                tbi-phy@11 {
                    reg = <0x11>;
                    device_type = "tbi-phy";
                    linux,phandle = <0x8>;
                };
            };
        };

        serial@4500 {
            cell-index = <0x0>;
            device_type = "serial";
            compatible = "ns16550";
            reg = <0x4500 0x100>;
            clock-frequency = <0x0>;
            interrupts = <0x2a 0x2>;
            interrupt-parent = <0x1>;
        };

        pic@40000 {
            interrupt-controller;
            #address-cells = <0x0>;
            #interrupt-cells = <0x2>;
            reg = <0x40000 0x40000>;
            compatible = "chrp,open-pic";
            device_type = "open-pic";
            linux,phandle = <0x1>;
            phandle = <0x1>;
        };

        global-utilities@e0000 {
            compatible = "fsl,mpc8641-guts";
            reg = <0xe0000 0x1000>;
            fsl,has-rstcr;
        };
    };

    chosen {
        linux,stdout-path = "/soc8641/serial0: serial@4500";
    };
};




On Thu, Dec 26, 2013 at 2:37 PM, wyang <w90p710@gmail.com> wrote:

>  On 12/26/2013 01:09 PM, Ashish Khetan wrote:
>
>   Hi,
>  I was trying to port Linux-3.12 for MPC8641 based custom designed board
> for evaluation purpose. I have been facing a kernel bug at mpic
> initialization. Is somebody have faced this kind of bugs or can give me any
> pointer for further steps how to solve kernel bugs will be really helpful.
> here is the snapshot for the bug that may be helpful to address the bug.
> Using MPC86xx HPCN machine description
> Total memory = 512MB; using 1024kB for hash table (at cff00000)
> Linux version 3.12.0 (ashish@ashish-VirtualBox) (gcc version 4.7.2 (GCC)
> ) #2 We
> d Dec 25 16:04:36 IST 2013
> Found initrd at 0xde975000:0xdfec428a
> bootconsole [udbg0] enabled
> setup_arch: bootmem
> mpc86xx_hpcn_setup_arch()
> MPC86xx HPCN board from Freescale Semiconductor
> arch: exit
> Zone ranges:
>   DMA      [mem 0x00000000-0x1fffffff]
>   Normal   empty
>   HighMem  empty
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x00000000-0x1fffffff]
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
> Kernel command line: root=/dev/ram0 rw rootfs console=ttyS0,115200
> PID hash table entries: 2048 (order: 1, 8192 bytes)
> Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Sorting __ex_table...
> Memory: 424980K/524288K available (4172K kernel code, 208K rwdata, 1304K
> rodata,
>  196K init, 149K bss, 99308K reserved, 0K highmem)
> Kernel virtual memory layout:
>   * 0xfffcf000..0xfffff000  : fixmap
>   * 0xff800000..0xffc00000  : highmem PTEs
>   * 0xff7fe000..0xff800000  : early ioremap
>   * 0xe1000000..0xff7fe000  : vmalloc & ioremap
> SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> NR_IRQS:512 nr_irqs:512 16
> ------------[ cut here ]------------
> kernel BUG at arch/powerpc/platforms/86xx/pic.c:42!
>
>
> It hints that mpic_alloc() fails. Maybe, you should spend some time
> investigating why it fails. :-)
>
> Thanks
> Wei
>
>  Oops: Exception in kernel mode, sig: 5 [#1]
> MPC86xx HPCN
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.12.0 #2
> task: c05903e0 ti: c05b4000 task.ti: c05b4000
> NIP: c0567438 LR: c0567430 CTR: c0567400
> REGS: c05b5ee0 TRAP: 0700   Not tainted  (3.12.0)
> MSR: 00021032 <ME,IR,DR,RI>  CR: 24000042  XER: 20000000
>
> GPR00: c0567430 c05b5f90 c05903e0 00000000 c04e4ff8 c051e588 0000008f
> 00000002
> GPR08: c042789c 00000001 0000006f 00000000 22000048 bebffffd 11a7b4e5
> 200c8000
> GPR16: ffbeffff ffffffff 00000000 00000024 00000000 1fec56f8 1fec59a7
> 00000000
> GPR24: 00000000 1fff97e8 40000000 1ffcc6a0 c0bff080 c05c2490 c05c2628
> c0585b60
> NIP [c0567438] mpc86xx_init_irq+0x38/0x108
> LR [c0567430] mpc86xx_init_irq+0x30/0x108
> Call Trace:
> [c05b5f90] [c0567430] mpc86xx_init_irq+0x30/0x108 (unreliable)
> [c05b5fb0] [c0562784] init_IRQ+0x24/0x38
> [c05b5fc0] [c055fde4] start_kernel+0x1bc/0x2ec
> [c05b5ff0] [00003444] 0x3444
> Instruction dump:
> 3d00c04f 38800000 38a01002 38c00000 38e00100 39088f8c 38600000 90010024
> bfa10014 4bffec35 7c690034 5529d97e <0f090000> 3fa0c04f 4bfff391 38600000
> ---[ end trace 31fd0ba7d8756001 ]---
>
> Kernel panic - not syncing: Attempted to kill the idle task!
> Rebooting in 180 seconds..
>
>
>  Thanks & Regards
>  Ashish Khetan
>
>
> _______________________________________________
> Linuxppc-dev mailing listLinuxppc-dev@lists.ozlabs.orghttps://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
>

--089e013c622009065404ee6e8e1a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>i tried to dig more inside mpic_alloc fails. the func=
tion of_find_matching_node calls inside from mpic_alloc() should return the=
 node at which pic is connected but it returns NULL. but why? In device tre=
e i am using the following.. may be it will helpful.<br>
/dts-v1/;<br><br>/ {<br>=A0=A0=A0 model =3D &quot;MPC8641HPCN&quot;;<br>=A0=
=A0=A0 compatible =3D &quot;fsl,mpc8641hpcn&quot;;<br>=A0=A0=A0 #address-ce=
lls =3D &lt;0x1&gt;;<br>=A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br><br>=A0=
=A0=A0 aliases {<br>=A0=A0=A0 =A0=A0=A0 ethernet0 =3D &quot;/soc8641@f80000=
00/ethernet@24000&quot;;<br>
=A0=A0=A0 =A0=A0=A0 ethernet1 =3D &quot;/soc8641@f8000000/ethernet@25000&qu=
ot;;<br>=A0=A0=A0 =A0=A0=A0 ethernet2 =3D &quot;/soc8641@f8000000/ethernet@=
26000&quot;;<br>=A0=A0=A0 =A0=A0=A0 ethernet3 =3D &quot;/soc8641@f8000000/e=
thernet@27000&quot;;<br>=A0=A0=A0 =A0=A0=A0 serial0 =3D &quot;/soc8641@f800=
0000/serial@4500&quot;;<br>
=A0=A0=A0 };<br><br>=A0=A0=A0 cpus {<br>=A0=A0=A0 =A0=A0=A0 #address-cells =
=3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x0&gt;;<br><br=
>=A0=A0=A0 =A0=A0=A0 PowerPC,8641@0 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 devi=
ce_type =3D &quot;cpu&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0=
x0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 d-cache-line-size =3D &lt;0x20&gt;=
;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i-cache-line-size =3D &lt;0x20&gt;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 d-cache-size =3D &lt;0x8000&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 i-cache-size =3D &lt;0x8000&gt;;<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 timebase-frequency =3D &lt;0x0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 bus-frequency =3D &lt;0x0&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D &lt;0x0&gt;;<br>=A0=A0=A0=
 =A0=A0=A0 };<br>=A0=A0=A0 };<br><br>=A0=A0=A0 memory {<br>=A0=A0=A0 =A0=A0=
=A0 device_type =3D &quot;memory&quot;;<br>=A0=A0=A0 =A0=A0=A0 reg =3D &lt;=
0x0 0x20000000&gt;;<br>=A0=A0=A0 };<br><br>=A0=A0=A0 localbus@f8005000 {<br=
>=A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;0x2&gt;;<br>
=A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 com=
patible =3D &quot;fsl,mpc8641-localbus&quot;, &quot;simple-bus&quot;;<br>=
=A0=A0=A0 =A0=A0=A0 reg =3D &lt;0xf8005000 0x1000&gt;;<br>=A0=A0=A0 =A0=A0=
=A0 interrupts =3D &lt;0x13 0x2&gt;;<br>=A0=A0=A0 =A0=A0=A0 interrupt-paren=
t =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0x0 0xff000000 0x1000000&gt;;<br><br=
>=A0=A0=A0 =A0=A0=A0 flash@0,0 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatibl=
e =3D &quot;cfi-flash&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0=
x0 0x0 0x800000&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 bank-width =3D &lt;0x=
2&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device-width =3D &lt;0x2&gt;;<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=
=A0 };<br><br>=A0=A0=A0 soc8641@f8000000 {<br>=A0=A0=A0 =A0=A0=A0 #address-=
cells =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 dev=
ice_type =3D &quot;soc&quot;;<br>=A0=A0=A0 =A0=A0=A0 compatible =3D &quot;s=
imple-bus&quot;;<br>=A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0xf8000000 0x100=
000&gt;;<br>=A0=A0=A0 =A0=A0=A0 bus-frequency =3D &lt;0x0&gt;;<br>
<br>=A0=A0=A0 =A0=A0=A0 mcm-law@0 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compat=
ible =3D &quot;fsl,mcm-law&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D =
&lt;0x0 0x1000&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 fsl,num-laws =3D &lt;0=
xa&gt;;<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 mcm@1000 {<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,mpc8641-mcm&quot;, &=
quot;fsl,mcm&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x1000 0x1000&gt;;<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x11 0x2&gt;;<br>=A0=A0=A0 =A0=A0=A0=
 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 };<br><=
br>=A0=A0=A0 =A0=A0=A0 dma@21300 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #addres=
s-cells =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,mpc8641-dma&quot;, &quot;fsl,elop=
lus-dma&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x21300 0x4&gt;=
;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0x21100 0x200&gt;;<br=
>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x0&gt;;<br><br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 dma-channel@0 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 compatible =3D &quot;fsl,mpc8641-dma-channel&quot;, &quot;fsl,eloplus-d=
ma-channel&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x=
0 0x80&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x0&gt;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x14 0x2&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dma-=
channel@80 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quo=
t;fsl,mpc8641-dma-channel&quot;, &quot;fsl,eloplus-dma-channel&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x80 0x80&gt;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x1&gt;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x15 0x2&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dma-c=
hannel@100 {<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,mpc8641-dm=
a-channel&quot;, &quot;fsl,eloplus-dma-channel&quot;;<br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x100 0x80&gt;;<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x2&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x16 0x2&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dma-=
channel@180 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &qu=
ot;fsl,mpc8641-dma-channel&quot;, &quot;fsl,eloplus-dma-channel&quot;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x180 0x80&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x3&gt;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x17 0x2&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=
=A0 =A0=A0=A0 ethernet@24000 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-ce=
lls =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 device_type =3D &quot;network&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 m=
odel =3D &quot;TSEC&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D =
&quot;gianfar&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x24000 0x1000&gt;;<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0x24000 0x1000&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 local-mac-address =3D [00 00 00 00 00 00];<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x1d 0x2 0x1e 0x2 0x22 0x2&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-handle =3D &lt;0x2&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 phy-handle =3D &lt;0x3&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 phy-connection-type =3D &quot;rgmii-id&quot;;<br><br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 mdio@520 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #addres=
s-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-c=
ells =3D &lt;0x0&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,gianfar-md=
io&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x520 0x20=
&gt;;<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ethernet-phy@0 {<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;=
0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =
=3D &lt;0xa 0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x0&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;eth=
ernet-phy&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux=
,phandle =3D &lt;0x3&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=
<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ethernet-phy@1 {<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<b=
r>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0xa 0x=
1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x1=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D =
&quot;ethernet-phy&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 linux,phandle =3D &lt;0x5&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 };<br>
<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ethernet-phy@2 {<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<b=
r>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0xa =
0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0=
x2&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =
=3D &quot;ethernet-phy&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux,phandle =3D &lt;0x7=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 ethernet-phy@3 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0xa 0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x3&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;eth=
ernet-phy&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux=
,phandle =3D &lt;0x9&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=
<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-phy@11 {<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x11&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;tbi=
-phy&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux,phan=
dle =3D &lt;0x2&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =
=A0=A0=A0 ethernet@25000 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =
=3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 device_type =3D &quot;network&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 m=
odel =3D &quot;TSEC&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D =
&quot;gianfar&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x25000 0x1000&gt;;<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0x25000 0x1000&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 local-mac-address =3D [00 00 00 00 00 00];<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x23 0x2 0x24 0x2 0x28 0x2&gt;;<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-handle =3D &lt;0x4&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 phy-handle =3D &lt;0x5&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 phy-connection-type =3D &quot;rgmii-id&quot;;<br><br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 mdio@520 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #addres=
s-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-c=
ells =3D &lt;0x0&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,gianfar-tb=
i&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x520 0x20&=
gt;;<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-phy@11 {<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x11&gt;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;tbi-phy&q=
uot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux,phandle =3D &lt;0x4=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 ethernet@=
26000 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;0x1&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x2&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 device_type =3D &quot;network&quot;;<br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 model =3D &quot;TSEC&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
compatible =3D &quot;gianfar&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =
=3D &lt;0x26000 0x1000&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0x26000 0x1000&gt;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 local-mac-address =3D [00 00 00 00 00 00];<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x1f 0x2 0x20 0x2 0x21 0x2=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-handle =3D &lt;0x6&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 phy-handle =3D &lt;0x7&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 phy-connection-type =3D &quot;rgmii-id&quot;;<br><br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 mdio@520 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 #address-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 #size-cells =3D &lt;0x0&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,gianfar-tb=
i&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x520 0x20&=
gt;;<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-phy@11 {<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x11&gt;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;tbi-phy&q=
uot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux,phandle =3D &lt;0x6=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 ethernet@=
27000 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D &lt;0x1&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x3&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 device_type =3D &quot;network&quot;;<br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 model =3D &quot;TSEC&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
compatible =3D &quot;gianfar&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =
=3D &lt;0x27000 0x1000&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ranges =3D &lt;0x0 0x27000 0x1000&gt;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 local-mac-address =3D [00 00 00 00 00 00];<br>=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D &lt;0x25 0x2 0x26 0x2 0x27 0x2=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D &lt;0x1&gt;;<br=
>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-handle =3D &lt;0x8&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 phy-handle =3D &lt;0x9&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 phy-connection-type =3D &quot;rgmii-id&quot;;<br><br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 mdio@520 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 #address-cells =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 #size-cells =3D &lt;0x0&gt;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;fsl,gianfar-tb=
i&quot;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x520 0x20&=
gt;;<br><br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tbi-phy@11 {<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x11&gt;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;tbi-phy&q=
uot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 linux,phandle =3D &lt;0x8=
&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 };<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 serial@45=
00 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D &lt;0x0&gt;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;serial&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;ns16550&quot;;<br>=A0=A0=
=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x4500 0x100&gt;;<br>=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 clock-frequency =3D &lt;0x0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 interrupts =3D &lt;0x2a 0x2&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 in=
terrupt-parent =3D &lt;0x1&gt;;<br>
=A0=A0=A0 =A0=A0=A0 };<br><br>=A0=A0=A0 =A0=A0=A0 pic@40000 {<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 interrupt-controller;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
#address-cells =3D &lt;0x0&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #interrupt=
-cells =3D &lt;0x2&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0x4000=
0 0x40000&gt;;<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D &quot;chrp,o=
pen-pic&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D &quot;open-pic&quot;;<br>=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 linux,phandle =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 phandle =3D &lt;0x1&gt;;<br>=A0=A0=A0 =A0=A0=A0 };<br><br>=
=A0=A0=A0 =A0=A0=A0 global-utilities@e0000 {<br>=A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 compatible =3D &quot;fsl,mpc8641-guts&quot;;<br>
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D &lt;0xe0000 0x1000&gt;;<br>=A0=A0=A0 =
=A0=A0=A0 =A0=A0=A0 fsl,has-rstcr;<br>=A0=A0=A0 =A0=A0=A0 };<br>=A0=A0=A0 }=
;<br><br>=A0=A0=A0 chosen {<br>=A0=A0=A0 =A0=A0=A0 linux,stdout-path =3D &q=
uot;/soc8641/serial0: serial@4500&quot;;<br>=A0=A0=A0 };<br>};<br><br></div=
><br>
<div><div><div></div></div></div></div><div class=3D"gmail_extra"><br><br><=
div class=3D"gmail_quote">On Thu, Dec 26, 2013 at 2:37 PM, wyang <span dir=
=3D"ltr">&lt;<a href=3D"mailto:w90p710@gmail.com" target=3D"_blank">w90p710=
@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><div><div class=3D"h5">
    <div>On 12/26/2013 01:09 PM, Ashish Khetan
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>
          <div>
            <div>Hi,<br>
            </div>
            I was trying to port Linux-3.12 for MPC8641 based custom
            designed board for evaluation purpose. I have been facing a
            kernel bug at mpic initialization. Is somebody have faced
            this kind of bugs or can give me any pointer for further
            steps how to solve kernel bugs will be really helpful. here
            is the snapshot for the bug that may be helpful to address
            the bug.<br>
            Using MPC86xx HPCN machine description<br>
            Total memory =3D 512MB; using 1024kB for hash table (at
            cff00000)<br>
            Linux version 3.12.0 (ashish@ashish-VirtualBox) (gcc version
            4.7.2 (GCC) ) #2 We<br>
            d Dec 25 16:04:36 IST 2013<br>
            Found initrd at 0xde975000:0xdfec428a<br>
            bootconsole [udbg0] enabled<br>
            setup_arch: bootmem<br>
            mpc86xx_hpcn_setup_arch()<br>
            MPC86xx HPCN board from Freescale Semiconductor<br>
            arch: exit<br>
            Zone ranges:<br>
            =A0 DMA=A0=A0=A0=A0=A0 [mem 0x00000000-0x1fffffff]<br>
            =A0 Normal=A0=A0 empty<br>
            =A0 HighMem=A0 empty<br>
            Movable zone start for each node<br>
            Early memory node ranges<br>
            =A0 node=A0=A0 0: [mem 0x00000000-0x1fffffff]<br>
            Built 1 zonelists in Zone order, mobility grouping on.=A0
            Total pages: 130048<br>
            Kernel command line: root=3D/dev/ram0 rw rootfs
            console=3DttyS0,115200<br>
            PID hash table entries: 2048 (order: 1, 8192 bytes)<br>
            Dentry cache hash table entries: 65536 (order: 6, 262144
            bytes)<br>
            Inode-cache hash table entries: 32768 (order: 5, 131072
            bytes)<br>
            Sorting __ex_table...<br>
            Memory: 424980K/524288K available (4172K kernel code, 208K
            rwdata, 1304K rodata,<br>
            =A0196K init, 149K bss, 99308K reserved, 0K highmem)<br>
            Kernel virtual memory layout:<br>
            =A0 * 0xfffcf000..0xfffff000=A0 : fixmap<br>
            =A0 * 0xff800000..0xffc00000=A0 : highmem PTEs<br>
            =A0 * 0xff7fe000..0xff800000=A0 : early ioremap<br>
            =A0 * 0xe1000000..0xff7fe000=A0 : vmalloc &amp; ioremap<br>
            SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Node=
s=3D1<br>
            NR_IRQS:512 nr_irqs:512 16<br>
            ------------[ cut here ]------------<br>
            kernel BUG at arch/powerpc/platforms/86xx/pic.c:42!<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br></div></div>
    It hints that mpic_alloc() fails. Maybe, you should spend some time
    investigating why it fails.<span><span> :-) </span></span><br>
    <br>
    Thanks<br>
    Wei<br>
    <blockquote type=3D"cite"><div><div class=3D"h5">
      <div dir=3D"ltr">
        <div>
          <div>Oops: Exception in kernel mode, sig: 5 [#1]<br>
            MPC86xx HPCN<br>
            Modules linked in:<br>
            CPU: 0 PID: 0 Comm: swapper Not tainted 3.12.0 #2<br>
            task: c05903e0 ti: c05b4000 task.ti: c05b4000<br>
            NIP: c0567438 LR: c0567430 CTR: c0567400<br>
            REGS: c05b5ee0 TRAP: 0700=A0=A0 Not tainted=A0 (3.12.0)<br>
            MSR: 00021032 &lt;ME,IR,DR,RI&gt;=A0 CR: 24000042=A0 XER:
            20000000<br>
            <br>
            GPR00: c0567430 c05b5f90 c05903e0 00000000 c04e4ff8 c051e588
            0000008f 00000002<br>
            GPR08: c042789c 00000001 0000006f 00000000 22000048 bebffffd
            11a7b4e5 200c8000<br>
            GPR16: ffbeffff ffffffff 00000000 00000024 00000000 1fec56f8
            1fec59a7 00000000<br>
            GPR24: 00000000 1fff97e8 40000000 1ffcc6a0 c0bff080 c05c2490
            c05c2628 c0585b60<br>
            NIP [c0567438] mpc86xx_init_irq+0x38/0x108<br>
            LR [c0567430] mpc86xx_init_irq+0x30/0x108<br>
            Call Trace:<br>
            [c05b5f90] [c0567430] mpc86xx_init_irq+0x30/0x108
            (unreliable)<br>
            [c05b5fb0] [c0562784] init_IRQ+0x24/0x38<br>
            [c05b5fc0] [c055fde4] start_kernel+0x1bc/0x2ec<br>
            [c05b5ff0] [00003444] 0x3444<br>
            Instruction dump:<br>
            3d00c04f 38800000 38a01002 38c00000 38e00100 39088f8c
            38600000 90010024<br>
            bfa10014 4bffec35 7c690034 5529d97e &lt;0f090000&gt;
            3fa0c04f 4bfff391 38600000<br>
            ---[ end trace 31fd0ba7d8756001 ]---<br>
            <br>
            Kernel panic - not syncing: Attempted to kill the idle task!<br=
>
            Rebooting in 180 seconds..<br>
            <br>
            <br>
          </div>
          Thanks &amp; Regards<br>
        </div>
        Ashish Khetan<br>
      </div>
      <br>
      <fieldset></fieldset>
      <br>
      </div></div><pre>_______________________________________________
Linuxppc-dev mailing list
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org" target=3D"_blank">Linuxppc=
-dev@lists.ozlabs.org</a>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </div>

</blockquote></div><br></div>

--089e013c622009065404ee6e8e1a--
