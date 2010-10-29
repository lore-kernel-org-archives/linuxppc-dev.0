Return-Path: <gramaalexandruionut@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id 95A01B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 01:09:33 +1100 (EST)
Received: by eyg24 with SMTP id 24so1862516eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 07:09:31 -0700 (PDT)
MIME-Version: 1.0
From: Alexandru Ionut Grama <gramaalexandruionut@gmail.com>
Date: Fri, 29 Oct 2010 16:09:10 +0200
Message-ID: <AANLkTik1U6mguUKtri+Ryt0BRZZHJb_YDgnM=n-CPvU9@mail.gmail.com>
Subject: [MPC8272ADS] porting a custom patch from 2.6.21.7 to 2.6.35.7 for a
	custom board
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary=001636456f72d9d9ab0493c201cc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636456f72d9d9ab0493c201cc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello linuxppc-dev community!

First of all, I want to introduce myself and my project. I'm working at the
Technical University of Madrid in a project for porting Linux to an embedde=
d
system, a router. This project is my final degree thesis. This machine has =
a
MPC8272VRMIBA processor and a custom platform and seems to be based on
MPC8272ADS. The company that subsidizes us provides us a patch for making
the router compatible with Linux, but it only works for Linux-2.6.21.

I've achieve some aims, but for now I want to make openssl compatible with
SEC1.0. I want to use the Cryptographic-API with talitos to get the
advantage of using crypto-processor. I've decided to use Linux-2.6.35.7
because is the latest stable version of Linux, and adds new features to
"talitos". So, for now, my aim is to port the original patch to
Linux-2.6.35.7 to get CPM and serial port compatibility. After that I can d=
o
kernel debugging for making Ethernet cards compatible, and finally make som=
e
benchmark for the crypto system. The bad point is that the architecture of
kernel's code changes a lot and I don't know if the changes that I'm doing
are in the good way.

I'll try to explain my best what I'm doing.

Here is the original change:

diff -rcNP linux-2.6.21/arch/powerpc/mm/init_32.c
atlas_kernel/arch/powerpc/mm/init_32.c
*** linux-2.6.21/arch/powerpc/mm/init_32.c  2007-04-26 05:08:32.000000000
+0200
--- atlas_kernel/arch/powerpc/mm/init_32.c  2008-04-24 08:43:51.000000000
+0200
***************
*** 172,178 ****
  #ifdef CONFIG_HIGHMEM
    ioremap_base =3D PKMAP_BASE;
  #else
!   ioremap_base =3D 0xfe000000UL;    /* for now, could be 0xfffff000 */
  #endif /* CONFIG_HIGHMEM */
    ioremap_bot =3D ioremap_base;

--- 172,178 ----
  #ifdef CONFIG_HIGHMEM
    ioremap_base =3D PKMAP_BASE;
  #else
!   ioremap_base =3D 0xff000000UL;    /* for now, could be 0xfffff000 */ /*
gonza */
  #endif /* CONFIG_HIGHMEM */
    ioremap_bot =3D ioremap_base;

I reproduce this change with this:

diff -rc linux-2.6.35.7/arch/powerpc/include/asm/pgtable-ppc32.h
linux-agrama/arch/powerpc/include/asm/pgtable-ppc32.h
*** linux-2.6.35.7/arch/powerpc/include/asm/pgtable-ppc32.h 2010-09-29
03:09:08.000000000 +0200
--- linux-agrama/arch/powerpc/include/asm/pgtable-ppc32.h   2010-10-26
18:47:28.000000000 +0200
***************pq2ads
*** 63,69 ****
  #ifdef CONFIG_HIGHMEM
  #define KVIRT_TOP PKMAP_BASE
  #else
! #define KVIRT_TOP (0xfe000000UL)  /* for now, could be FIXMAP_BASE ? */
  #endif

  /*
--- 63,69 ----
  #ifdef CONFIG_HIGHMEM
  #define KVIRT_TOP PKMAP_BASE
  #else
! #define KVIRT_TOP (0xff000000UL)  /* for now, could be FIXMAP_BASE ? */ /=
*
agrama, antes KVIRT_TOP era 0xfe000000UL */
  #endif

  /*

Also, I've add the next line:

diff -rc linux-2.6.35.7/arch/powerpc/mm/init_32.c
linux-agrama/arch/powerpc/mm/init_32.c
*** linux-2.6.35.7/arch/powerpc/mm/init_32.c    2010-09-29
03:09:08.000000000 +0200
--- linux-agrama/arch/powerpc/mm/init_32.c  2010-10-29 10:28:43.000000000
+0200
***************
*** 178,184 ****

    /* Initialize early top-down ioremap allocator */
    ioremap_bot =3D IOREMAP_TOP;
!
    /* Map in I/O resources */
    if (ppc_md.progress)
        ppc_md.progress("MMU:setio", 0x302);
--- 178,184 ----

    /* Initialize early top-down ioremap allocator */
    ioremap_bot =3D IOREMAP_TOP;
!   ioremap_base =3D ioremap_bot; /*agrama*/
    /* Map in I/O resources */
    if (ppc_md.progress)
        ppc_md.progress("MMU:setio", 0x302);

=BFIt's correct to add the line ioremap_base=3Dioremap_bot or ioremap_base =
it
not used anymore?

The next change it's about a jam on pci's kref. This line has been deleted
on 2.6.21:

diff -rcNP linux-2.6.21/arch/powerpc/platforms/82xx/mpc82xx_ads.c
atlas_kernel/arch/powerpc/platforms/82xx/mpc82xx_ads.c
*** linux-2.6.21/arch/powerpc/platforms/82xx/mpc82xx_ads.c  2007-04-26
05:08:32.000000000 +0200
--- atlas_kernel/arch/powerpc/platforms/82xx/mpc82xx_ads.c  2008-04-24
08:43:51.000000000 +0200
***************
*** 533,539 ****
        return;
    }
    pci_clk_frq =3D *(uint *) ptr;
-   of_node_put(np);
    bus_range =3D get_property(np, "bus-range", &len);
    if (bus_range =3D=3D NULL || len < 2 * sizeof(int)) {
        printk(KERN_WARNING "Can't get bus-range for %s, assume"

I didn't find an equivalent operation on 2.6.35 because the code has been
changed completly. =BFWhere it's included this operation about the bus?

Here there's a change of the macro CPM_BASE_ADDR :

diff -rcNP linux-2.6.21/arch/powerpc/platforms/82xx/pq2ads.h
atlas_kernel/arch/powerpc/platforms/82xx/pq2ads.h
*** linux-2.6.21/arch/powerpc/platforms/82xx/pq2ads.h   2007-04-26
05:08:32.000000000 +0200
--- atlas_kernel/arch/powerpc/platforms/82xx/pq2ads.h   2008-04-24
08:43:51.000000000 +0200
***************
*** 30,36 ****
  #define CPUINFO_MACHINE       "PQ2 ADS PowerPC"

  /* Backword-compatibility stuff for the drivers */
! #define CPM_MAP_ADDR      ((uint)0xf0000000)
  #define CPM_IRQ_OFFSET 0

  /* The ADS8260 has 16, 32-bit wide control/status registers, accessed
--- 30,36 ----
  #define CPUINFO_MACHINE       "PQ2 ADS PowerPC"

  /* Backword-compatibility stuff for the drivers */
! #define CPM_MAP_ADDR      ((uint)0xff000000)  /*gonza*/
  #define CPM_IRQ_OFFSET 0

It's seems that it has to be 0xff000000, but in 2.6.35 this symbol it's not
used anymore. =BFWhere it's defined right now, or how I can handle this
address? I need it for the next part, that it's the hardest one to modify.

Here comes the hardest part at the file
arch/powerpc/platforms/82xx/mpc82xx_ads.c:
***************
*** 632,637 ****
--- 632,643 ----
    while (1) ;
  }

+ static void __init m82xx_map_io(void)   /* gonza */
+ {
+     io_block_mapping(CPM_MAP_ADDR, CPM_MAP_ADDR, ((uint)(4 * 64 * 1024)),
_PAGE_IO);
+ }
+
+
  define_machine(mpc82xx_ads)
  {
    .name =3D "MPC82xx ADS",
***************
*** 642,645 ****
--- 648,652 ----
    .get_irq =3D    cpm2_get_irq,
    .calibrate_decr =3D    m82xx_calibrate_decr,
    .restart =3D m82xx_restart,.halt =3D m82xx_halt,
+   .setup_io_mappings =3D    m82xx_map_io, /* gonza */
  };

Here it's a modification that sets the base address for CPM with
io_block_mapping. I've seen in another discussion that io_block_mapping it'=
s
became deprecated and it's out or kernel code. Does ioremap() function
became smarter and you can use it instead of io_block_mapping? I've found
some part of the code that I think do the same stuff, but it's not seems
working. Also, I've tried with setbat() changing the addresses for
0xff000000, but it doesn't work. Also, I've removed the original setbat lin=
e
and let only mine. So it doesn't work with the both lines or letting only
mine (being ioremap() or setbat()).
*** linux-2.6.35.7/arch/powerpc/sysdev/cpm_common.c    2010-09-29
03:09:08.000000000 +0200
--- linux-agrama/arch/powerpc/sysdev/cpm_common.c    2010-10-29
13:20:35.000000000 +0200
***************
*** 58,63 ****
--- 58,64 ----
      if (cpm_udbg_txdesc) {
  #ifdef CONFIG_CPM2
          setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
+         ioremap(((uint)0xff000000UL),(uint)1024*64*4);
  #endif
          udbg_putc =3D udbg_putc_cpm;
      }

I've seen that .setup_io_mappings was removed from kernel code. It has beed
called in version 2.6.21.7 from arch/powerpc/mm/init_32.c. It's has the sam=
e
effect make this operation at arch/powerpc/sysdev/cpm_common.c ? Which
operation should I do, ioremap(),setbat() or another one?

The last part of the modification it's about the serial port. At the versio=
n
2.6.21.7 you can choose where it's connected the serial port
(SCC1,SCC2,SCC3,SCC4,SMC1 or SMC2). Our serial port it's connected over
SMC1. We define it with the var SERIAL_CPM_SMC1 at menuconfig. At the
2.6.35.7 there's no option for do that. How should i do to force the serial
on SMC1? Also, there's a change when you init the serial port:
diff -rcNP linux-2.6.21/drivers/serial/cpm_uart/cpm_uart_cpm2.c
atlas_kernel/drivers/serial/cpm_uart/cpm_uart_cpm2.c
*** linux-2.6.21/drivers/serial/cpm_uart/cpm_uart_cpm2.c    2007-04-26
05:08:32.000000000 +0200
--- atlas_kernel/drivers/serial/cpm_uart/cpm_uart_cpm2.c    2008-04-24
08:43:52.000000000 +0200
***************
*** 95,105 ****
    volatile iop_cpm2_t *io =3D cpm2_map(im_ioport);
    volatile cpmux_t *cpmux =3D cpm2_map(im_cpmux);

!   /* SMC1 is only on port D */
!   io->iop_ppard |=3D 0x00c00000;
!   io->iop_pdird |=3D 0x00400000;
!   io->iop_pdird &=3D ~0x00800000;
!   io->iop_psord &=3D ~0x00c00000;

    /* Wire BRG1 to SMC1 */
    cpmux->cmx_smr &=3D 0x0f;
--- 95,105 ----
    volatile iop_cpm2_t *io =3D cpm2_map(im_ioport);
    volatile cpmux_t *cpmux =3D cpm2_map(im_cpmux);

! /* gonza, se cambia ppard por pparc*/
!   io->iop_pparc |=3D 0x0c000000;
!   io->iop_pdirc |=3D 0x04000000;
!   io->iop_pdirc &=3D ~0x08000000;
!   io->iop_psorc &=3D ~0x0c000000;

    /* Wire BRG1 to SMC1 */
    cpmux->cmx_smr &=3D 0x0f;

The change consists on use port c instead of port d. Also, the values that
are written are multiplied of 0x10. In version 2.6.35.7 I've made the next
change that I believe that makes the same stuff:
diff -rc linux-2.6.35.7/arch/powerpc/platforms/82xx/mpc8272_ads.c
linux-agrama/arch/powerpc/platforms/82xx/mpc8272_ads.c
*** linux-2.6.35.7/arch/powerpc/platforms/82xx/mpc8272_ads.c    2010-09-29
03:09:08.000000000 +0200
--- linux-agrama/arch/powerpc/platforms/82xx/mpc8272_ads.c  2010-10-28
15:05:49.000000000 +0200
***************
*** 108,113 ****
--- 108,127 ----
    {3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
    {3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
    {3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+ #if 0 /* agrama */
+   /* En linux-2.6.21.7 (atlas):*/
+   /* gonza, se cambia ppard por pparc*/
+   io->iop_pparc |=3D 0x0c 00 00 00;
+   1100
+   io->iop_pdirc |=3D 0x04000000;
+   io->iop_pdirc &=3D ~0x08000000;
+   io->iop_psorc &=3D ~0x0c000000;
+ #endif
+
+     /* SMC1 */    /* agrama */
+       {2, 26, (0*CPM_PIN_GPIO) | CPM_PIN_OUTPUT | CPM_PIN_SECONDARY}, /*
agrama */
+       {2, 27, (0*CPM_PIN_GPIO) | CPM_PIN_INPUT  | CPM_PIN_SECONDARY}, /*
agrama */
  };

There's another modification in version 2.6.21.7 about Ethernet, but I
believe that doesn't affect to serial port.

diff -rcNP linux-2.6.21/arch/powerpc/sysdev/fsl_soc.c
atlas_kernel/arch/powerpc/sysdev/fsl_soc.c
*** linux-2.6.21/arch/powerpc/sysdev/fsl_soc.c  2007-04-26
05:08:32.000000000 +0200
--- atlas_kernel/arch/powerpc/sysdev/fsl_soc.c  2008-04-24
08:43:51.000000000 +0200
***************
*** 679,685 ****
            fs_enet_data.rx_ring =3D 32;
            fs_enet_data.tx_ring =3D 32;
            fs_enet_data.rx_copybreak =3D 240;
!           fs_enet_data.use_napi =3D 0;
            fs_enet_data.napi_weight =3D 17;
            fs_enet_data.mem_offset =3D FCC_MEM_OFFSET(fcc_index);
            fs_enet_data.cp_page =3D CPM_CR_FCC_PAGE(fcc_index);
--- 680,686 ----
            fs_enet_data.rx_ring =3D 32;
            fs_enet_data.tx_ring =3D 32;
            fs_enet_data.rx_copybreak =3D 240;
!           fs_enet_data.use_napi =3D 1;
            fs_enet_data.napi_weight =3D 17;
            fs_enet_data.mem_offset =3D FCC_MEM_OFFSET(fcc_index);
            fs_enet_data.cp_page =3D CPM_CR_FCC_PAGE(fcc_index);
***************
*** 713,731 ****
                fs_enet_mdio_bb_data.delay =3D
                    mdio_bb_prop[5];

                fs_enet_mdio_bb_data.irq[0] =3D phy_irq[0];
                fs_enet_mdio_bb_data.irq[1] =3D -1;
                fs_enet_mdio_bb_data.irq[2] =3D -1;
                fs_enet_mdio_bb_data.irq[3] =3D phy_irq[0];
                fs_enet_mdio_bb_data.irq[31] =3D -1;

                fs_enet_mdio_bb_data.mdio_dat.offset =3D
                    (u32)&cpm2_immr->im_ioport.iop_pdatc;
                fs_enet_mdio_bb_data.mdio_dir.offset =3D
                    (u32)&cpm2_immr->im_ioport.iop_pdirc;
                fs_enet_mdio_bb_data.mdc_dat.offset =3D
                    (u32)&cpm2_immr->im_ioport.iop_pdatc;
!
                ret =3D platform_device_add_data(
                        fs_enet_mdio_bb_dev,
                        &fs_enet_mdio_bb_data,
--- 714,747 ----
                fs_enet_mdio_bb_data.delay =3D
                    mdio_bb_prop[5];
+ /*gonza: Creo que aqui se esta suponiendo que hay phy con direccion 0 y
3*/
+ /*igual que en mii-bitbang.c*/
                fs_enet_mdio_bb_data.irq[0] =3D phy_irq[0];
                fs_enet_mdio_bb_data.irq[1] =3D -1;
                fs_enet_mdio_bb_data.irq[2] =3D -1;
                fs_enet_mdio_bb_data.irq[3] =3D phy_irq[0];
                fs_enet_mdio_bb_data.irq[31] =3D -1;

+                 /*gonza: uso los campos mdio_port y mdc_port que son
0=3DPORTA..3=3DPORTD*/
+                 offset_port_port =3D (u32)&cpm2_immr->im_ioport.iop_pdirb=
 -
(u32)&cpm2_immr->im_ioport.iop_pdira;
+
+               fs_enet_mdio_bb_data.mdio_dat.offset =3D
+                       (u32)&cpm2_immr->im_ioport.iop_pdata +
+                       (offset_port_port * fs_enet_mdio_bb_data.mdio_port)=
;
+               fs_enet_mdio_bb_data.mdio_dir.offset =3D
+                       (u32)&cpm2_immr->im_ioport.iop_pdira +
+                       (offset_port_port * fs_enet_mdio_bb_data.mdio_port)=
;
+               fs_enet_mdio_bb_data.mdc_dat.offset =3D
+                       (u32)&cpm2_immr->im_ioport.iop_pdata +
+                       (offset_port_port * fs_enet_mdio_bb_data.mdc_port);
+ #if 0
                fs_enet_mdio_bb_data.mdio_dat.offset =3D
                    (u32)&cpm2_immr->im_ioport.iop_pdatc;
                fs_enet_mdio_bb_data.mdio_dir.offset =3D
                    (u32)&cpm2_immr->im_ioport.iop_pdirc;
                fs_enet_mdio_bb_data.mdc_dat.offset =3D
                    (u32)&cpm2_immr->im_ioport.iop_pdatc;
! #endif
                ret =3D platform_device_add_data(
                        fs_enet_mdio_bb_dev,
                        &fs_enet_mdio_bb_data,
***************
*** 733,739 ****
                if (ret)
                    goto unreg;
            }
!
            of_node_put(phy);
            of_node_put(mdio);

--- 749,755 ----
                if (ret)
                    goto unreg;
            }
!
            of_node_put(phy);
            of_node_put(mdio);

***************
*** 754,759 ****
--- 770,777 ----

  arch_initcall(fs_enet_of_init);

+ #if 0 /* gonza */
+
  static const char scc_regs[] =3D "regs";
  static const char scc_pram[] =3D "pram";

***************
*** 828,833 ****
--- 846,853 ----
  }

  arch_initcall(cpm_uart_of_init);
+ #endif
+
  #endif /* CONFIG_CPM2 */

  #ifdef CONFIG_8xx
***************
*** 1022,1027 ****
--- 1042,1050 ----

  arch_initcall(fs_enet_of_init);

+ #endif /* CONFIG_8xx */
+
+ #if defined(CONFIG_CPM2) || defined(CONFIG_8xx)

  static const char *smc_regs =3D "regs";
  static const char *smc_pram =3D "pram";
***************
*** 1096,1099 ****

  arch_initcall(cpm_smc_uart_of_init);

! #endif /* CONFIG_8xx */
--- 1119,1122 ----

  arch_initcall(cpm_smc_uart_of_init);

! #endif /* CONFIG_CPM2 || CONFIG_8xx */

So, the questions are the next:
- linux-2.6.21/arch/powerpc/mm/init_32.c
linux-2.6.35.7/arch/powerpc/mm/pgtable_32.h
   - It's ok what I'm doing changing here KVIRT_TOP?
   - ioremap_base =3D ioremap_bot at linux-2.6.35.7/arch/powerpc/mm/init_32=
.c?
- linux-2.6.21/arch/powerpc/platforms/82xx/pq2ads.h
   - Where and how can I define CMP_MAP_ADDR, that all the controllers can
use it?
   - Changing the CMP_MAP_ADDR in 2.6.21.7 involves that I should use a
configuration for 2.6.35 based on PQ2ADS?
-linux-2.6.35.7/arch/powerpc/platforms/82xx/mpc8272_ads.c
   - How shall I the same stuff asociated to the operation
.setup_io_mappings, that uses block_io_mapping?
-linux-2.6.35.7/drivers/serial/cpm_uart/cpm_uart_cpm2.c
   - How shall I force the uart driver to work on SMC1?
   - What shall I change to make the same operation at recognizing the uart=
,
(I mean, asingn control sequences to iop_pparc,iop_pdirc and iop_psorc), in
the new "style" of kernel architecture?
-linux-2.6.21/arch/powerpc/sysdev/fsl_soc.c
   -This code it's necesary for making the UART works properly?

I really appreciate the work that you're doing adding features to the new
kernel, but it's very obscure for me to make the changes that I need, so
I'll apreciate very much your help with my issue. Also I think that it's a
very good way to show to the begginers (as me) how to make the proper
changes with the new style of the code.

King regards,
Alexandru

--001636456f72d9d9ab0493c201cc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello linuxppc-dev community!<br><br>First of all, I want to introduce myse=
lf and my project. I&#39;m working at the Technical University of Madrid in=
 a project for porting Linux to an embedded system, a router. This project =
is my final degree thesis. This machine has a MPC8272VRMIBA processor and a=
 custom platform and seems to be based on MPC8272ADS. The company that subs=
idizes us provides us a patch for making the router compatible with Linux, =
but it only works for Linux-2.6.21.<br>

<br>I&#39;ve achieve some aims, but for now I want to make openssl compatib=
le with SEC1.0. I want to use the Cryptographic-API with talitos to get the=
 advantage of using crypto-processor. I&#39;ve decided to use Linux-2.6.35.=
7 because is the latest stable version of Linux, and adds new features to &=
quot;talitos&quot;. So, for now, my aim is to port the original patch to Li=
nux-2.6.35.7 to get CPM and serial port compatibility. After that I can do =
kernel debugging for making Ethernet cards compatible, and finally make som=
e benchmark for the crypto system. The bad point is that the architecture o=
f kernel&#39;s code changes a lot and I don&#39;t know if the changes that =
I&#39;m doing are in the good way.<br>

<br>I&#39;ll try to explain my best what I&#39;m doing.<br><br>Here is the =
original change:<br><br>diff -rcNP linux-2.6.21/arch/powerpc/mm/init_32.c a=
tlas_kernel/arch/powerpc/mm/init_32.c<br>*** linux-2.6.21/arch/powerpc/mm/i=
nit_32.c=A0 2007-04-26 05:08:32.000000000 +0200<br>

--- atlas_kernel/arch/powerpc/mm/init_32.c=A0 2008-04-24 08:43:51.000000000=
 +0200<br>***************<br>*** 172,178 ****<br>=A0 #ifdef CONFIG_HIGHMEM<=
br>=A0=A0=A0 ioremap_base =3D PKMAP_BASE;<br>=A0 #else<br>!=A0=A0 ioremap_b=
ase =3D 0xfe000000UL;=A0=A0=A0 /* for now, could be 0xfffff000 */<br>

=A0 #endif /* CONFIG_HIGHMEM */<br>=A0=A0=A0 ioremap_bot =3D ioremap_base;<=
br><br>--- 172,178 ----<br>=A0 #ifdef CONFIG_HIGHMEM<br>=A0=A0=A0 ioremap_b=
ase =3D PKMAP_BASE;<br>=A0 #else<br>!=A0=A0 ioremap_base =3D 0xff000000UL;=
=A0=A0=A0 /* for now, could be 0xfffff000 */ /* gonza */<br>

=A0 #endif /* CONFIG_HIGHMEM */<br>=A0=A0=A0 ioremap_bot =3D ioremap_base;<=
br><br>I reproduce this change with this:<br><br>diff -rc linux-2.6.35.7/ar=
ch/powerpc/include/asm/pgtable-ppc32.h linux-agrama/arch/powerpc/include/as=
m/pgtable-ppc32.h<br>

*** linux-2.6.35.7/arch/powerpc/include/asm/pgtable-ppc32.h 2010-09-29 03:0=
9:08.000000000 +0200<br>--- linux-agrama/arch/powerpc/include/asm/pgtable-p=
pc32.h=A0=A0 2010-10-26 18:47:28.000000000 +0200<br>***************pq2ads<b=
r>

*** 63,69 ****<br>=A0 #ifdef CONFIG_HIGHMEM<br>=A0 #define KVIRT_TOP PKMAP_=
BASE<br>=A0 #else<br>! #define KVIRT_TOP (0xfe000000UL)=A0 /* for now, coul=
d be FIXMAP_BASE ? */<br>=A0 #endif<br><br>=A0 /*<br>--- 63,69 ----<br>=A0 =
#ifdef CONFIG_HIGHMEM<br>

=A0 #define KVIRT_TOP PKMAP_BASE<br>=A0 #else<br>! #define KVIRT_TOP (0xff0=
00000UL)=A0 /* for now, could be FIXMAP_BASE ? */ /* agrama, antes KVIRT_TO=
P era 0xfe000000UL */<br>=A0 #endif<br><br>=A0 /*<br><br>Also, I&#39;ve add=
 the next line:<br>

<br>diff -rc linux-2.6.35.7/arch/powerpc/mm/init_32.c linux-agrama/arch/pow=
erpc/mm/init_32.c<br>*** linux-2.6.35.7/arch/powerpc/mm/init_32.c=A0=A0=A0 =
2010-09-29 03:09:08.000000000 +0200<br>--- linux-agrama/arch/powerpc/mm/ini=
t_32.c=A0 2010-10-29 10:28:43.000000000 +0200<br>

***************<br>*** 178,184 ****<br><br>=A0=A0=A0 /* Initialize early to=
p-down ioremap allocator */<br>=A0=A0=A0 ioremap_bot =3D IOREMAP_TOP;<br>!<=
br>=A0=A0=A0 /* Map in I/O resources */<br>=A0=A0=A0 if (ppc_md.progress)<b=
r>=A0=A0=A0=A0=A0=A0=A0 ppc_md.progress(&quot;MMU:setio&quot;, 0x302);<br>

--- 178,184 ----<br><br>=A0=A0=A0 /* Initialize early top-down ioremap allo=
cator */<br>=A0=A0=A0 ioremap_bot =3D IOREMAP_TOP;<br>!=A0=A0 ioremap_base =
=3D ioremap_bot; /*agrama*/<br>=A0=A0=A0 /* Map in I/O resources */<br>=A0=
=A0=A0 if (ppc_md.progress)<br>

=A0=A0=A0=A0=A0=A0=A0 ppc_md.progress(&quot;MMU:setio&quot;, 0x302);<br><br=
>=BFIt&#39;s correct to add the line ioremap_base=3Dioremap_bot or ioremap_=
base it not used anymore?<br><br>The next change it&#39;s about a jam on pc=
i&#39;s kref. This line has been deleted on 2.6.21:<br>

<br>diff -rcNP linux-2.6.21/arch/powerpc/platforms/82xx/mpc82xx_ads.c atlas=
_kernel/arch/powerpc/platforms/82xx/mpc82xx_ads.c<br>*** linux-2.6.21/arch/=
powerpc/platforms/82xx/mpc82xx_ads.c=A0 2007-04-26 05:08:32.000000000 +0200=
<br>

--- atlas_kernel/arch/powerpc/platforms/82xx/mpc82xx_ads.c=A0 2008-04-24 08=
:43:51.000000000 +0200<br>***************<br>*** 533,539 ****<br>=A0=A0=A0=
=A0=A0=A0=A0 return;<br>=A0=A0=A0 }<br>=A0=A0=A0 pci_clk_frq =3D *(uint *) =
ptr;<br>-=A0=A0 of_node_put(np);<br>

=A0=A0=A0 bus_range =3D get_property(np, &quot;bus-range&quot;, &amp;len);<=
br>=A0=A0=A0 if (bus_range =3D=3D NULL || len &lt; 2 * sizeof(int)) {<br>=
=A0=A0=A0=A0=A0=A0=A0 printk(KERN_WARNING &quot;Can&#39;t get bus-range for=
 %s, assume&quot;<br><br>I didn&#39;t find an equivalent operation on 2.6.3=
5 because the code has been changed completly. =BFWhere it&#39;s included t=
his operation about the bus?<br>

<br>Here there&#39;s a change of the macro CPM_BASE_ADDR :<br><br>diff -rcN=
P linux-2.6.21/arch/powerpc/platforms/82xx/pq2ads.h atlas_kernel/arch/power=
pc/platforms/82xx/pq2ads.h<br>*** linux-2.6.21/arch/powerpc/platforms/82xx/=
pq2ads.h=A0=A0 2007-04-26 05:08:32.000000000 +0200<br>

--- atlas_kernel/arch/powerpc/platforms/82xx/pq2ads.h=A0=A0 2008-04-24 08:4=
3:51.000000000 +0200<br>***************<br>*** 30,36 ****<br>=A0 #define CP=
UINFO_MACHINE=A0=A0=A0=A0=A0=A0 &quot;PQ2 ADS PowerPC&quot;<br><br>=A0 /* B=
ackword-compatibility stuff for the drivers */<br>

! #define CPM_MAP_ADDR=A0=A0=A0=A0=A0 ((uint)0xf0000000)<br>=A0 #define CPM=
_IRQ_OFFSET 0<br><br>=A0 /* The ADS8260 has 16, 32-bit wide control/status =
registers, accessed<br>--- 30,36 ----<br>=A0 #define CPUINFO_MACHINE=A0=A0=
=A0=A0=A0=A0 &quot;PQ2 ADS PowerPC&quot;<br>

<br>=A0 /* Backword-compatibility stuff for the drivers */<br>! #define CPM=
_MAP_ADDR=A0=A0=A0=A0=A0 ((uint)0xff000000)=A0 /*gonza*/<br>=A0 #define CPM=
_IRQ_OFFSET 0<br><br>It&#39;s seems that it has to be 0xff000000, but in 2.=
6.35 this symbol it&#39;s not used anymore. =BFWhere it&#39;s defined right=
 now, or how I can handle this address? I need it for the next part, that i=
t&#39;s the hardest one to modify.<br>

<br>Here comes the hardest part at the file arch/powerpc/platforms/82xx/mpc=
82xx_ads.c:<br>***************<br>*** 632,637 ****<br>--- 632,643 ----<br>=
=A0=A0=A0 while (1) ;<br>=A0 }<br><br>+ static void __init m82xx_map_io(voi=
d)=A0=A0 /* gonza */<br>

+ {<br>+=A0=A0=A0=A0 io_block_mapping(CPM_MAP_ADDR, CPM_MAP_ADDR, ((uint)(4=
 * 64 * 1024)), _PAGE_IO);<br>+ }<br>+<br>+<br>=A0 define_machine(mpc82xx_a=
ds)<br>=A0 {<br>=A0=A0=A0 .name =3D &quot;MPC82xx ADS&quot;,<br>***********=
****<br>*** 642,645 ****<br>

--- 648,652 ----<br>=A0=A0=A0 .get_irq =3D=A0=A0=A0 cpm2_get_irq,<br>=A0=A0=
=A0 .calibrate_decr =3D=A0=A0=A0 m82xx_calibrate_decr,<br>=A0=A0=A0 .restar=
t =3D m82xx_restart,.halt =3D m82xx_halt,<br>+=A0=A0 .setup_io_mappings =3D=
=A0=A0=A0 m82xx_map_io, /* gonza */<br>=A0 };<br>

<br>Here it&#39;s a modification that sets the base address for CPM with io=
_block_mapping. I&#39;ve seen in another discussion that io_block_mapping i=
t&#39;s became deprecated and it&#39;s out or kernel code. Does ioremap() f=
unction became smarter and you can use it instead of io_block_mapping? I&#3=
9;ve found some part of the code that I think do the same stuff, but it&#39=
;s not seems working. Also, I&#39;ve tried with setbat() changing the addre=
sses for 0xff000000, but it doesn&#39;t work. Also, I&#39;ve removed the or=
iginal setbat line and let only mine. So it doesn&#39;t work with the both =
lines or letting only mine (being ioremap() or setbat()).<br>

*** linux-2.6.35.7/arch/powerpc/sysdev/cpm_common.c=A0=A0=A0 2010-09-29 03:=
09:08.000000000 +0200<br>--- linux-agrama/arch/powerpc/sysdev/cpm_common.c=
=A0=A0=A0 2010-10-29 13:20:35.000000000 +0200<br>***************<br>*** 58,=
63 ****<br>

--- 58,64 ----<br>=A0=A0=A0=A0=A0 if (cpm_udbg_txdesc) {<br>=A0 #ifdef CONF=
IG_CPM2<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0 setbat(1, 0xf0000000, 0xf0000000, 10=
24*1024, PAGE_KERNEL_NCG);<br>+=A0=A0=A0=A0=A0=A0=A0=A0 ioremap(((uint)0xff=
000000UL),(uint)1024*64*4);<br>=A0 #endif<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0 udbg_putc =3D udbg_putc_cpm;<br>=A0=A0=A0=A0=A0=
 }<br><br>I&#39;ve seen that .setup_io_mappings was removed from kernel cod=
e. It has beed called in version 2.6.21.7 from arch/powerpc/mm/init_32.c. I=
t&#39;s has the same effect make this operation at arch/powerpc/sysdev/cpm_=
common.c ? Which operation should I do, ioremap(),setbat() or another one?<=
br>

<br>The last part of the modification it&#39;s about the serial port. At th=
e version 2.6.21.7 you can choose where it&#39;s connected the serial port =
(SCC1,SCC2,SCC3,SCC4,SMC1 or SMC2). Our serial port it&#39;s connected over=
 SMC1. We define it with the var SERIAL_CPM_SMC1 at menuconfig. At the 2.6.=
35.7 there&#39;s no option for do that. How should i do to force the serial=
 on SMC1? Also, there&#39;s a change when you init the serial port:<br>

diff -rcNP linux-2.6.21/drivers/serial/cpm_uart/cpm_uart_cpm2.c atlas_kerne=
l/drivers/serial/cpm_uart/cpm_uart_cpm2.c<br>*** linux-2.6.21/drivers/seria=
l/cpm_uart/cpm_uart_cpm2.c=A0=A0=A0 2007-04-26 05:08:32.000000000 +0200<br>=
--- atlas_kernel/drivers/serial/cpm_uart/cpm_uart_cpm2.c=A0=A0=A0 2008-04-2=
4 08:43:52.000000000 +0200<br>

***************<br>*** 95,105 ****<br>=A0=A0=A0 volatile iop_cpm2_t *io =3D=
 cpm2_map(im_ioport);<br>=A0=A0=A0 volatile cpmux_t *cpmux =3D cpm2_map(im_=
cpmux);<br><br>!=A0=A0 /* SMC1 is only on port D */<br>!=A0=A0 io-&gt;iop_p=
pard |=3D 0x00c00000;<br>

!=A0=A0 io-&gt;iop_pdird |=3D 0x00400000;<br>!=A0=A0 io-&gt;iop_pdird &amp;=
=3D ~0x00800000;<br>!=A0=A0 io-&gt;iop_psord &amp;=3D ~0x00c00000;<br><br>=
=A0=A0=A0 /* Wire BRG1 to SMC1 */<br>=A0=A0=A0 cpmux-&gt;cmx_smr &amp;=3D 0=
x0f;<br>--- 95,105 ----<br>=A0=A0=A0 volatile iop_cpm2_t *io =3D cpm2_map(i=
m_ioport);<br>

=A0=A0=A0 volatile cpmux_t *cpmux =3D cpm2_map(im_cpmux);<br><br>! /* gonza=
, se cambia ppard por pparc*/<br>!=A0=A0 io-&gt;iop_pparc |=3D 0x0c000000;<=
br>!=A0=A0 io-&gt;iop_pdirc |=3D 0x04000000;<br>!=A0=A0 io-&gt;iop_pdirc &a=
mp;=3D ~0x08000000;<br>

!=A0=A0 io-&gt;iop_psorc &amp;=3D ~0x0c000000;<br><br>=A0=A0=A0 /* Wire BRG=
1 to SMC1 */<br>=A0=A0=A0 cpmux-&gt;cmx_smr &amp;=3D 0x0f;<br><br>The chang=
e consists on use port c instead of port d. Also, the values that are writt=
en are multiplied of 0x10. In version 2.6.35.7 I&#39;ve made the next chang=
e that I believe that makes the same stuff:<br>

diff -rc linux-2.6.35.7/arch/powerpc/platforms/82xx/mpc8272_ads.c linux-agr=
ama/arch/powerpc/platforms/82xx/mpc8272_ads.c<br>*** linux-2.6.35.7/arch/po=
werpc/platforms/82xx/mpc8272_ads.c=A0=A0=A0 2010-09-29 03:09:08.000000000 +=
0200<br>

--- linux-agrama/arch/powerpc/platforms/82xx/mpc8272_ads.c=A0 2010-10-28 15=
:05:49.000000000 +0200<br>***************<br>*** 108,113 ****<br>--- 108,12=
7 ----<br>=A0=A0=A0 {3, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},<br>=A0=A0=A0=
 {3, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},<br>

=A0=A0=A0 {3, 25, CPM_PIN_INPUT | CPM_PIN_PRIMARY},<br>+<br>+ #if 0 /* agra=
ma */<br>+=A0=A0 /* En linux-2.6.21.7 (atlas):*/<br>+=A0=A0 /* gonza, se ca=
mbia ppard por pparc*/<br>+=A0=A0 io-&gt;iop_pparc |=3D 0x0c 00 00 00;<br>+=
=A0=A0 1100<br>+=A0=A0 io-&gt;iop_pdirc |=3D 0x04000000;<br>

+=A0=A0 io-&gt;iop_pdirc &amp;=3D ~0x08000000;<br>+=A0=A0 io-&gt;iop_psorc =
&amp;=3D ~0x0c000000;<br>+ #endif<br>+<br>+=A0=A0=A0=A0 /* SMC1 */=A0=A0=A0=
 /* agrama */<br>+=A0=A0=A0=A0=A0=A0 {2, 26, (0*CPM_PIN_GPIO) | CPM_PIN_OUT=
PUT | CPM_PIN_SECONDARY}, /* agrama */<br>

+=A0=A0=A0=A0=A0=A0 {2, 27, (0*CPM_PIN_GPIO) | CPM_PIN_INPUT=A0 | CPM_PIN_S=
ECONDARY}, /* agrama */<br>=A0 };<br><br>There&#39;s another modification i=
n version 2.6.21.7 about Ethernet, but I believe that doesn&#39;t affect to=
 serial port.<br>

<br>diff -rcNP linux-2.6.21/arch/powerpc/sysdev/fsl_soc.c atlas_kernel/arch=
/powerpc/sysdev/fsl_soc.c<br>*** linux-2.6.21/arch/powerpc/sysdev/fsl_soc.c=
=A0 2007-04-26 05:08:32.000000000 +0200<br>--- atlas_kernel/arch/powerpc/sy=
sdev/fsl_soc.c=A0 2008-04-24 08:43:51.000000000 +0200<br>

***************<br>*** 679,685 ****<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs=
_enet_data.rx_ring =3D 32;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_dat=
a.tx_ring =3D 32;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.rx_copy=
break =3D 240;<br>!=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.use_napi =3D=
 0;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.napi_weight =3D 17;<b=
r>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.mem_offset =3D FCC_MEM_OFFSE=
T(fcc_index);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.cp_page =3D=
 CPM_CR_FCC_PAGE(fcc_index);<br>--- 680,686 ----<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 fs_enet_data.rx_ring =3D 32;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 fs_enet_data.tx_ring =3D 32;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.rx_copybreak =3D 240;<br>!=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.use_napi =3D 1;<br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.napi_weight =3D 17;<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 fs_enet_data.mem_offset =3D FCC_MEM_OFFSET(fcc_index);<b=
r>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_data.cp_page =3D CPM_CR_FCC_PAG=
E(fcc_index);<br>

***************<br>*** 713,731 ****<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 fs_enet_mdio_bb_data.delay =3D<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 mdio_bb_prop[5];<br><br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.irq[0] =3D phy_irq[0];<br>=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.irq[1] =3D =
-1;<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.irq[2] =
=3D -1;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_da=
ta.irq[3] =3D phy_irq[0];<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
fs_enet_mdio_bb_data.irq[31] =3D -1;<br><br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.mdio_dat.offset =3D<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_im=
mr-&gt;im_ioport.iop_pdatc;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 fs_enet_mdio_bb_data.mdio_dir.offset =3D<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_immr-&gt;im_ioport.iop_pdirc;=
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.mdc_=
dat.offset =3D<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_im=
mr-&gt;im_ioport.iop_pdatc;<br>!<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ret =3D platform_device_add_data(<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_dev,<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &amp;fs_enet_m=
dio_bb_data,<br>

--- 714,747 ----<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_m=
dio_bb_data.delay =3D<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 mdio_bb_prop[5];<br>+ /*gonza: Creo que aqui se esta suponiendo q=
ue hay phy con direccion 0 y 3*/<br>+ /*igual que en mii-bitbang.c*/<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.irq[0] =
=3D phy_irq[0];<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_md=
io_bb_data.irq[1] =3D -1;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
fs_enet_mdio_bb_data.irq[2] =3D -1;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 fs_enet_mdio_bb_data.irq[3] =3D phy_irq[0];<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.irq[31] =
=3D -1;<br><br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*gonza: u=
so los campos mdio_port y mdc_port que son 0=3DPORTA..3=3DPORTD*/<br>+=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset_port_port =3D (u32)&am=
p;cpm2_immr-&gt;im_ioport.iop_pdirb - (u32)&amp;cpm2_immr-&gt;im_ioport.iop=
_pdira;<br>

+<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.mdio_=
dat.offset =3D<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 (u32)&amp;cpm2_immr-&gt;im_ioport.iop_pdata +<br>+=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (offset_port_port * =
fs_enet_mdio_bb_data.mdio_port);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 fs_enet_mdio_bb_data.mdio_dir.offset =3D<br>

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&a=
mp;cpm2_immr-&gt;im_ioport.iop_pdira +<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (offset_port_port * fs_enet_mdio_bb_da=
ta.mdio_port);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_=
bb_data.mdc_dat.offset =3D<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_immr-&gt;im_ioport.iop_pdata +<br>

+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (offset=
_port_port * fs_enet_mdio_bb_data.mdc_port);<br>+ #if 0<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_enet_mdio_bb_data.mdio_dat.offset =3D<br>=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_im=
mr-&gt;im_ioport.iop_pdatc;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 fs_enet_mdio_bb_data.mdio_dir.offset =3D<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_im=
mr-&gt;im_ioport.iop_pdirc;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 fs_enet_mdio_bb_data.mdc_dat.offset =3D<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (u32)&amp;cpm2_immr-&gt;im_ioport.iop_pdatc;=
<br>! #endif<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D platf=
orm_device_add_data(<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fs_en=
et_mdio_bb_dev,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 &amp;fs_enet_mdio_bb_data,<br>***************<br>*** 733,73=
9 ****<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto unreg;<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<br>

!<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of_node_put(phy);<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 of_node_put(mdio);<br><br>--- 749,755 ----<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto unreg;<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 }<br>!=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 of_node_put(phy);<br>

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of_node_put(mdio);<br><br>***************=
<br>*** 754,759 ****<br>--- 770,777 ----<br><br>=A0 arch_initcall(fs_enet_o=
f_init);<br><br>+ #if 0 /* gonza */<br>+<br>=A0 static const char scc_regs[=
] =3D &quot;regs&quot;;<br>

=A0 static const char scc_pram[] =3D &quot;pram&quot;;<br><br>*************=
**<br>*** 828,833 ****<br>--- 846,853 ----<br>=A0 }<br><br>=A0 arch_initcal=
l(cpm_uart_of_init);<br>+ #endif<br>+<br>=A0 #endif /* CONFIG_CPM2 */<br><b=
r>=A0 #ifdef CONFIG_8xx<br>

***************<br>*** 1022,1027 ****<br>--- 1042,1050 ----<br><br>=A0 arch=
_initcall(fs_enet_of_init);<br><br>+ #endif /* CONFIG_8xx */<br>+<br>+ #if =
defined(CONFIG_CPM2) || defined(CONFIG_8xx)<br><br>=A0 static const char *s=
mc_regs =3D &quot;regs&quot;;<br>

=A0 static const char *smc_pram =3D &quot;pram&quot;;<br>***************<br=
>*** 1096,1099 ****<br><br>=A0 arch_initcall(cpm_smc_uart_of_init);<br><br>=
! #endif /* CONFIG_8xx */<br>--- 1119,1122 ----<br><br>=A0 arch_initcall(cp=
m_smc_uart_of_init);<br>

<br>! #endif /* CONFIG_CPM2 || CONFIG_8xx */<br><br>So, the questions are t=
he next:<br>- linux-2.6.21/arch/powerpc/mm/init_32.c linux-2.6.35.7/arch/po=
werpc/mm/pgtable_32.h<br>=A0=A0 - It&#39;s ok what I&#39;m doing changing h=
ere KVIRT_TOP?<br>

=A0=A0 - ioremap_base =3D ioremap_bot at linux-2.6.35.7/arch/powerpc/mm/ini=
t_32.c?<br>- linux-2.6.21/arch/powerpc/platforms/82xx/pq2ads.h<br>=A0=A0 - =
Where and how can I define CMP_MAP_ADDR, that all the controllers can use i=
t?<br>

=A0=A0 - Changing the CMP_MAP_ADDR in 2.6.21.7 involves that I should use a=
 configuration for 2.6.35 based on PQ2ADS?<br>-linux-2.6.35.7/arch/powerpc/=
platforms/82xx/mpc8272_ads.c<br>=A0=A0 - How shall I the same stuff asociat=
ed to the operation .setup_io_mappings, that uses block_io_mapping?<br>

-linux-2.6.35.7/drivers/serial/cpm_uart/cpm_uart_cpm2.c<br>=A0=A0 - How sha=
ll I force the uart driver to work on SMC1?<br>=A0=A0 - What shall I change=
 to make the same operation at recognizing the uart, (I mean, asingn contro=
l sequences to iop_pparc,iop_pdirc and iop_psorc), in the new &quot;style&q=
uot; of kernel architecture?<br>

-linux-2.6.21/arch/powerpc/sysdev/fsl_soc.c<br>=A0=A0 -This code it&#39;s n=
ecesary for making the UART works properly?<br><br>I really appreciate the =
work that you&#39;re doing adding features to the new kernel, but it&#39;s =
very obscure for me to make the changes that I need, so I&#39;ll apreciate =
very much your help with my issue. Also I think that it&#39;s a very good w=
ay to show to the begginers (as me) how to make the proper changes with the=
 new style of the code.<br>

<br>King regards,<br>Alexandru<br>

--001636456f72d9d9ab0493c201cc--
