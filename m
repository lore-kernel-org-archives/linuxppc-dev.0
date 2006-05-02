Return-Path: <stevewin@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 83B3167B66
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 08:08:45 +1000 (EST)
Received: from e35.co.us.ibm.com (e35.boulder.ibm.com [9.17.249.45])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k42KuRtt024040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 May 2006 16:56:28 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k42Ku7Fj027722
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 May 2006 16:56:07 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k42Ku7jD178646
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 May 2006 14:56:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k42Ku7lf015126
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 May 2006 14:56:07 -0600
Received: from d03nm125.boulder.ibm.com (d03nm125.boulder.ibm.com
	[9.17.195.151])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k42Ku7Eb015112
	for <linuxppc-embedded@ozlabs.org>; Tue, 2 May 2006 14:56:07 -0600
Subject: Configuring PCI w/ 44x
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF7EB5CFE4.CBC11341-ON87257162.0071F2FC-85257162.0072FFA5@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Tue, 2 May 2006 16:58:32 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBFBF1DFE2746C8f9e8a93df938690918c08BBFBF1DFE2746C"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0__=08BBFBF1DFE2746C8f9e8a93df938690918c08BBFBF1DFE2746C
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable






I have a question regarding configuring PCI with 44x.  Using 2.6.17-rc3=
 as
a reference, PCI_CONFIG is defined for the 44x defconfigs, and Kconfig =
is
not enabled to reflect/change the setting for 44x.  When I update
arch/ppc/Kconfig to enable configuring or not configuring PCI with 44x,=
 and
then don't configure it, the kernel won't compile:

arch/ppc/kernel/built-in.o: In function `__dma_alloc_coherent':
arch/ppc/kernel/dma-mapping.c:231: undefined reference to `pci_dram_off=
set'
arch/ppc/kernel/dma-mapping.c:231: undefined reference to `pci_dram_off=
set'
arch/ppc/mm/built-in.o: In function `ioport_map':
arch/ppc/mm/pgtable.c:265: undefined reference to `isa_io_base'
arch/ppc/mm/pgtable.c:265: undefined reference to `isa_io_base'
arch/ppc/mm/built-in.o: In function `__ioremap':
arch/ppc/mm/pgtable.c:187: undefined reference to `isa_mem_base'
arch/ppc/mm/pgtable.c:187: undefined reference to `isa_mem_base'
arch/ppc/mm/pgtable.c:187: undefined reference to `isa_mem_base'
arch/ppc/mm/pgtable.c:187: undefined reference to `isa_mem_base'
arch/ppc/syslib/built-in.o: In function `outb':
include/asm/io.h:299: undefined reference to `isa_io_base'
arch/ppc/syslib/built-in.o: In function `todc_m48txx_write_val':
include/asm/io.h:299: undefined reference to `isa_io_base'
arch/ppc/syslib/built-in.o: In function `outb':
include/asm/io.h:299: undefined reference to `isa_io_base'
arch/ppc/syslib/built-in.o: In function `todc_mc146818_read_val':
include/asm/io.h:299: undefined reference to `isa_io_base'
arch/ppc/syslib/built-in.o: In function `outb':
include/asm/io.h:299: undefined reference to `isa_io_base'
arch/ppc/syslib/built-in.o:include/asm/io.h:299: more undefined referen=
ces
to `isa_io_base' follow
arch/ppc/syslib/built-in.o: In function `pciauto_setup_bars':
arch/ppc/syslib/pci_auto.c:56: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:61: undefined reference to
`early_read_config_dword'
arch/ppc/syslib/pci_auto.c:93: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:108: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/built-in.o: In function `pciauto_prescan_setup_bridge':=

arch/ppc/syslib/pci_auto.c:130: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:135: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:140: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:155: undefined reference to
`early_write_config_word'
arch/ppc/syslib/pci_auto.c:160: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:165: undefined reference to
`early_write_config_word'
arch/ppc/syslib/pci_auto.c:172: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:177: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/built-in.o: In function `pciauto_postscan_setup_bridge'=
:
arch/ppc/syslib/pci_auto.c:194: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:208: undefined reference to
`early_write_config_word'
arch/ppc/syslib/pci_auto.c:215: undefined reference to
`early_write_config_word'
arch/ppc/syslib/pci_auto.c:223: undefined reference to
`early_write_config_word'
arch/ppc/syslib/pci_auto.c:234: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:239: undefined reference to
`early_write_config_word'
arch/ppc/syslib/pci_auto.c:246: undefined reference to
`early_read_config_dword'
arch/ppc/syslib/pci_auto.c:251: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/built-in.o: In function
`pciauto_prescan_setup_cardbus_bridge':
arch/ppc/syslib/pci_auto.c:269: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:274: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:279: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:294: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:299: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/built-in.o: In function
`pciauto_postscan_setup_cardbus_bridge':
arch/ppc/syslib/pci_auto.c:321: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:347: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:355: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:362: undefined reference to
`early_read_config_dword'
arch/ppc/syslib/pci_auto.c:367: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/built-in.o: In function `pciauto_bus_scan':
arch/ppc/syslib/pci_auto.c:403: undefined reference to
`early_read_config_byte'
arch/ppc/syslib/pci_auto.c:413: undefined reference to
`early_read_config_word'
arch/ppc/syslib/pci_auto.c:420: undefined reference to
`early_read_config_dword'
arch/ppc/syslib/pci_auto.c:493: undefined reference to
`early_read_config_dword'
arch/ppc/syslib/pci_auto.c:498: undefined reference to
`early_write_config_dword'
arch/ppc/syslib/pci_auto.c:506: undefined reference to
`early_write_config_byte'
arch/ppc/syslib/pci_auto.c:474: undefined reference to
`early_read_config_byte'
arch/ppc/platforms/4xx/built-in.o: In function `ocotea_setup_arch':
arch/ppc/platforms/4xx/ocotea.c:195: undefined reference to
`pcibios_alloc_controller'
arch/ppc/platforms/4xx/ocotea.c:205: undefined reference to
`pci_init_resource'
arch/ppc/platforms/4xx/ocotea.c:211: undefined reference to
`pci_init_resource'
arch/ppc/platforms/4xx/ocotea.c:222: undefined reference to `isa_io_bas=
e'
arch/ppc/platforms/4xx/ocotea.c:222: undefined reference to `isa_io_bas=
e'
arch/ppc/platforms/4xx/ocotea.c:224: undefined reference to
`setup_indirect_pci'
arch/ppc/platforms/4xx/ocotea.c:231: undefined reference to
`common_swizzle'
arch/ppc/platforms/4xx/ocotea.c:231: undefined reference to
`common_swizzle'
drivers/built-in.o: In function `write_port':
drivers/char/mem.c:556: undefined reference to `isa_io_base'
drivers/char/mem.c:556: undefined reference to `isa_io_base'
drivers/built-in.o: In function `inb':
include/asm/io.h:314: undefined reference to `isa_io_base'
include/asm/io.h:314: undefined reference to `isa_io_base'
drivers/built-in.o: In function `outb':
include/asm/io.h:299: undefined reference to `isa_io_base'
drivers/built-in.o:include/asm/io.h:299: more undefined references to
`isa_io_base' follow
drivers/built-in.o: In function `virt_to_bus':
include/asm/io.h:403: undefined reference to `pci_dram_offset'
include/asm/io.h:403: undefined reference to `pci_dram_offset'
drivers/built-in.o: In function `emac_resize_rx_ring':
include/asm/io.h:401: undefined reference to `pci_dram_offset'
include/asm/io.h:401: undefined reference to `pci_dram_offset'
drivers/built-in.o: In function `virt_to_bus':
include/asm/io.h:401: undefined reference to `pci_dram_offset'
drivers/built-in.o:include/asm/io.h:401: more undefined references to
`pci_dram_offset' follow
drivers/built-in.o: In function `inb':
include/asm/io.h:314: undefined reference to `isa_io_base'
include/asm/io.h:314: undefined reference to `isa_io_base'
drivers/built-in.o: In function `outb':
include/asm/io.h:299: undefined reference to `isa_io_base'
include/asm/io.h:299: undefined reference to `isa_io_base'
make: *** [.tmp_vmlinux1] Error 1


Shouldn't not configuring PCI be allowed/supported?

Thanks,

Steve
=

--0__=08BBFBF1DFE2746C8f9e8a93df938690918c08BBFBF1DFE2746C
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>I have a question regarding configuring PCI with 44x.  Using 2.6.17-=
rc3 as a reference, PCI_CONFIG is defined for the 44x defconfigs, and K=
config is not enabled to reflect/change the setting for 44x.  When I up=
date arch/ppc/Kconfig to enable configuring or not configuring PCI with=
 44x, and then don't configure it, the kernel won't compile:<br>
<br>
<font face=3D"Courier New">arch/ppc/kernel/built-in.o: In function `__d=
ma_alloc_coherent':</font><br>
<font face=3D"Courier New">arch/ppc/kernel/dma-mapping.c:231: undefined=
 reference to `pci_dram_offset'</font><br>
<font face=3D"Courier New">arch/ppc/kernel/dma-mapping.c:231: undefined=
 reference to `pci_dram_offset'</font><br>
<font face=3D"Courier New">arch/ppc/mm/built-in.o: In function `ioport_=
map':</font><br>
<font face=3D"Courier New">arch/ppc/mm/pgtable.c:265: undefined referen=
ce to `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/mm/pgtable.c:265: undefined referen=
ce to `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/mm/built-in.o: In function `__iorem=
ap':</font><br>
<font face=3D"Courier New">arch/ppc/mm/pgtable.c:187: undefined referen=
ce to `isa_mem_base'</font><br>
<font face=3D"Courier New">arch/ppc/mm/pgtable.c:187: undefined referen=
ce to `isa_mem_base'</font><br>
<font face=3D"Courier New">arch/ppc/mm/pgtable.c:187: undefined referen=
ce to `isa_mem_base'</font><br>
<font face=3D"Courier New">arch/ppc/mm/pgtable.c:187: undefined referen=
ce to `isa_mem_base'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `out=
b':</font><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `tod=
c_m48txx_write_val':</font><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `out=
b':</font><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `tod=
c_mc146818_read_val':</font><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `out=
b':</font><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o:include/asm/io.h:=
299: more undefined references to `isa_io_base' follow</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `pci=
auto_setup_bars':</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:56: undefined ref=
erence to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:61: undefined ref=
erence to `early_read_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:93: undefined ref=
erence to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:108: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `pci=
auto_prescan_setup_bridge':</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:130: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:135: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:140: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:155: undefined re=
ference to `early_write_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:160: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:165: undefined re=
ference to `early_write_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:172: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:177: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `pci=
auto_postscan_setup_bridge':</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:194: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:208: undefined re=
ference to `early_write_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:215: undefined re=
ference to `early_write_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:223: undefined re=
ference to `early_write_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:234: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:239: undefined re=
ference to `early_write_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:246: undefined re=
ference to `early_read_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:251: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `pci=
auto_prescan_setup_cardbus_bridge':</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:269: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:274: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:279: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:294: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:299: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `pci=
auto_postscan_setup_cardbus_bridge':</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:321: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:347: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:355: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:362: undefined re=
ference to `early_read_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:367: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/built-in.o: In function `pci=
auto_bus_scan':</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:403: undefined re=
ference to `early_read_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:413: undefined re=
ference to `early_read_config_word'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:420: undefined re=
ference to `early_read_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:493: undefined re=
ference to `early_read_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:498: undefined re=
ference to `early_write_config_dword'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:506: undefined re=
ference to `early_write_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/syslib/pci_auto.c:474: undefined re=
ference to `early_read_config_byte'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/built-in.o: In functi=
on `ocotea_setup_arch':</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:195: undefin=
ed reference to `pcibios_alloc_controller'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:205: undefin=
ed reference to `pci_init_resource'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:211: undefin=
ed reference to `pci_init_resource'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:222: undefin=
ed reference to `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:222: undefin=
ed reference to `isa_io_base'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:224: undefin=
ed reference to `setup_indirect_pci'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:231: undefin=
ed reference to `common_swizzle'</font><br>
<font face=3D"Courier New">arch/ppc/platforms/4xx/ocotea.c:231: undefin=
ed reference to `common_swizzle'</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `write_port'=
:</font><br>
<font face=3D"Courier New">drivers/char/mem.c:556: undefined reference =
to `isa_io_base'</font><br>
<font face=3D"Courier New">drivers/char/mem.c:556: undefined reference =
to `isa_io_base'</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `inb':</font=
><br>
<font face=3D"Courier New">include/asm/io.h:314: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">include/asm/io.h:314: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `outb':</fon=
t><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">drivers/built-in.o:include/asm/io.h:299: mor=
e undefined references to `isa_io_base' follow</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `virt_to_bus=
':</font><br>
<font face=3D"Courier New">include/asm/io.h:403: undefined reference to=
 `pci_dram_offset'</font><br>
<font face=3D"Courier New">include/asm/io.h:403: undefined reference to=
 `pci_dram_offset'</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `emac_resize=
_rx_ring':</font><br>
<font face=3D"Courier New">include/asm/io.h:401: undefined reference to=
 `pci_dram_offset'</font><br>
<font face=3D"Courier New">include/asm/io.h:401: undefined reference to=
 `pci_dram_offset'</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `virt_to_bus=
':</font><br>
<font face=3D"Courier New">include/asm/io.h:401: undefined reference to=
 `pci_dram_offset'</font><br>
<font face=3D"Courier New">drivers/built-in.o:include/asm/io.h:401: mor=
e undefined references to `pci_dram_offset' follow</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `inb':</font=
><br>
<font face=3D"Courier New">include/asm/io.h:314: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">include/asm/io.h:314: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">drivers/built-in.o: In function `outb':</fon=
t><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">include/asm/io.h:299: undefined reference to=
 `isa_io_base'</font><br>
<font face=3D"Courier New">make: *** [.tmp_vmlinux1] Error 1</font><br>=

<br>
<br>
Shouldn't not configuring PCI be allowed/supported?<br>
<br>
Thanks,<br>
<br>
Steve<br>
<br>
</body></html>=

--0__=08BBFBF1DFE2746C8f9e8a93df938690918c08BBFBF1DFE2746C--
