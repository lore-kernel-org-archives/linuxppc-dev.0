Return-Path: <SHorton@kodiaknetworks.com>
Received: from cowboy.inovate.inovate.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 281C0DE344
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 06:39:57 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8EB71.EF25E572"
Subject: Problem with cuImage Linux entry from old U-boot
Date: Mon, 21 Jul 2008 15:39:55 -0500
Message-ID: <295C5089A56CE143B316E5F67CA99CB001D0626A@cowboy.inovate.inovate.com>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8EB71.EF25E572
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello folks,

=20

As I have posted recently before, in a current work project, I have
inherited a compactPCI board that has an mpc7447/7448 powerpc processor
as well as a Marvell system controller, model mv64462 (stripped down
mv64460). The board has a somewhat working Gentoo Linux port running on
it from long ago and a company far far away (kernel version 2.6.9 built
using arch/ppc). To prepare for an upcoming deployment, I would like to
bring the OS up-to-date on this board with a newer kernel (targeting
2.6.24r3).

=20

I have made great strides with help from this mailing list and its
archives. I now have a compiled cuImage ready to boot from my older
working u-boot 1.1.2. I now seem to be stuck at the kernel entry point.
I'm not sure if I'm trying to jump into the kernel at the wrong address,
or if I have a serial console issue that prevents me from seeing anymore
progress. Here is my output:

=20

debug> bootm
## Booting image at 00800000 ...
   Image Name:   Linux-2.6.24-gentoo-r3
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1515921 Bytes =3D  1.4 MB
   Load Address: 00400000
   Entry Point:  0040095c
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Transferring control to Linux (at address 0040095c) ...
Memory <- <0x0 0x10000000> (256MB)
ENET0: local-mac-address <- 00:a0:d6:62:38:89
CPU clock-frequency <- 0x3b9ac9d8 (1000MHz)
CPU timebase-frequency <- 0x27bc86a (42MHz)
CPU bus-frequency <- 0x9ef21aa (167MHz)

=20

zImage starting: loaded at 0x00400000 (sp: 0x0febfa38)
Allocating 0x35f040 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040d000:0x00735db0)...done 0x312b34 bytes

=20

Linux/PowerPC load: ip=3Dbootp root=3D/dev/nfs rw nfsroot=3D/opt/gentoo
console=3DttyMM0,9600n8
Finalizing device tree... flat tree at 0x7423a0

=20

------

=20

If I run 'nm' on my elf image, I expect to find some entry point address
that corresponds to 0x7423a0, but this is not the case. See nm output
below.  Does anyone know what I might be doing wrong?

=20

[root@blade3 boot]# nm cuImage.giganew.elf

00736060 b alloc_min

00736058 b alloc_tbl

00400838 T backwards_memcpy

0073606c b bd

00736000 b bridge_base

00736000 A __bss_start

00736010 b chr1

00736014 b chr2

0040aadc d cmdline

00741ee0 B console_ops

00404620 t copy_val

00736018 b cpcr

00736004 b cpld_base

004060f4 t cpm1_cmd

00406174 t cpm2_cmd

00736028 b cpm_cmd

00405d84 T cpm_console_init

00406440 t cpm_serial_getc

00406334 t cpm_serial_open

004062c0 t cpm_serial_putc

00405d3c t cpm_serial_tstc

00405c60 T cuboot_init

00741c14 b cxt

0040a1e4 d dbase.1092

0040a1a4 d dext.1093

0073603c b disable_port

00741d30 b discard_buf.1378

00409922 d distfix.1169

004022e8 T __div64_32

00736034 b do_cmd

0040c098 A _dtb_end

0040ace0 A _dtb_start

00404c38 T dt_fixup_clock

00404cbc T dt_fixup_cpu_clocks

00404aec T dt_fixup_mac_address

00404b7c T __dt_fixup_mac_addresses

00404dec T dt_fixup_memory

00404500 T dt_get_reg_format

00404584 T dt_is_compatible

00741ef4 B dt_ops

00404684 t dt_xlate

00404a00 T dt_xlate_addr

00404a80 T dt_xlate_reg

00736000 A _edata

00736038 b enable_port

00742000 A _end

00408c98 A _etext

00400108 t exit

00401640 t exit

00402420 t exit

004044c4 t exit

00401cac t fdtm_create_node

00401c10 t fdtm_finalize

00401de4 t fdtm_finddevice

00401c54 t fdtm_find_node_by_prop_value

00401cf4 t fdtm_get_parent

00401bc0 t fdtm_get_path

00401d8c t fdtm_getprop

00401d34 t fdtm_setprop

00400000 t finddevice

00401e28 t finddevice

0040430c t finddevice

004050b8 t find_node_by_devtype

004000b0 t find_node_by_prop_value

0040446c t find_node_by_prop_value

0040092c T flush_cache

004073ac T ft_add_rsvmap

004077d4 T ft_begin

00408024 T ft_begin_node

004078b0 T ft_begin_tree

004080c4 T ft_create_node

004072d8 T ft_del_prop

004069b0 T ft_end_node

00406b7c T ft_end_tree

00407428 T ft_find_descendent

004075ec T ft_find_device

004079f0 T __ft_find_node_by_prop_value

00407af8 T ft_find_node_by_prop_value

00407b88 T __ft_get_parent

00407c74 T ft_get_parent

004078c4 T ft_get_path

00406890 t ft_get_phandle

00406ab4 t __ft_get_prop

00406e4c T ft_get_prop

00401b24 T ft_init

00406f48 t ft_make_space

004069d4 t ft_next

0040690c t ft_node_ph2node

00406938 t ft_node_update_after

004081b4 T ft_nop

00407674 T ft_open

00407cdc T ft_prop

00407f84 T ft_prop_int

00407fc8 T ft_prop_str

00406edc t ft_put_bin

00407e44 T ft_set_prop

00406c78 t ft_shuffle

00404414 t get_parent

00400058 t getprop

00401e80 t getprop

00404364 t getprop

00404fec t getprop

004057e8 t getprop

00405ce4 t getprop

0040820c t getprop

0040023c t giganew_fixups

00400530 t giganew_reset

0040aadc D __got2_end

0040a6e0 D __got2_start

004025dc T gunzip_discard

00402574 T gunzip_exactly

0040251c T gunzip_finish

0040245c T gunzip_partial

0040264c T gunzip_start

007364a4 b gzstate

00408804 T inflate_fast

00736000 A _initrd_end

00736000 A _initrd_start

0040a262 d lbase.1090

004099a2 d lenfix.1168

0040a224 d lext.1091

00741eb0 B loader_info

004008dc T memchr

00400904 T memcmp

00400780 T memcpy

00400778 T memmove

0040071c T memset

0040650c T mpc5200_psc_console_init

00736008 b mpsc_base

004058e8 T mpsc_console_init

00405a68 t mpsc_getc

00405840 t mpsc_get_virtreg_of_phandle

0073600c b mpscintr_base

00405b64 t mpsc_open

00405ae4 t mpsc_putc

00405c14 t mpsc_tstc

00736030 b muram_offset

0073602c b muram_start

0040520c T mv64x60_cfg_read

004052f8 T mv64x60_cfg_write

00405288 T mv64x60_config_cpu2pci_window

004055cc T mv64x60_config_ctlr_windows

00405408 T mv64x60_config_pci_windows

0040a4a4 d mv64x60_cpu2mem

0040a6a0 D mv64x60_cpu2pci_io

0040a6c0 D mv64x60_cpu2pci_mem

0040a59c d mv64x60_dram_selects

0040a5ac d mv64x60_enet2mem

00405134 T mv64x60_get_bridge_base

004051a0 T mv64x60_get_bridge_pbase

0040536c T mv64x60_get_mem_size

0040a60c d mv64x60_idma2mem

00405044 T mv64x60_is_coherent

0040a5dc d mv64x60_mpsc2mem

0040a564 d mv64x60_pci2mem

0040a584 d mv64x60_pci2reg

0040a4d4 d mv64x60_pci_acc

0040a63c d mv64x60_pci_cfgio

00736064 b next_base

00406980 t next_start

004082c0 T ns16550_console_init

004083f0 t ns16550_getc

00408264 t ns16550_open

00408464 t ns16550_putc

00408394 t ns16550_tstc

00400abc t number

004098fc d order.1221

0073601c b param

00402854 T parse_elf32

004027b4 T parse_elf64

00400144 T platform_init

00741ec4 B platform_ops

         w _platform_stack_top

004014c8 T printf

00741db0 b prop_buf

00736048 b psc

00406614 t psc_getc

004064b0 t psc_open

004065b8 t psc_putc

004064c0 t psc_tstc

00736040 B rbdf

0073604c b reg_base

00736050 b reg_base

00736054 b reg_shift

00736024 b scc

00406258 t scc_disable_port

004061f0 t scc_enable_port

00741d1c b serial_cd

00401f84 t serial_close

00401fd4 T serial_console_init

004021a8 t serial_edit_cmdline

00401ed8 t serial_open

00401f20 t serial_write

004015e8 t setprop

004043bc t setprop

0040868c T simple_alloc_init

004085d4 t simple_find_entry

00408658 t simple_free

004084d0 t simple_malloc

00408754 t simple_realloc

00400a78 t skip_atoi

00736020 b smc

0040608c t smc_disable_port

00406024 t smc_enable_port

00736068 b space_left

007360a4 b sprint_buf

00401574 T sprintf

0040167c T start

00400000 A _start

0040aadc A __start___builtin_cmdline

0040acdc A __stop___builtin_cmdline

0040066c T strcat

00400698 T strchr

004006b8 T strcmp

00400628 T strcpy

00400704 T strlen

004006dc T strncmp

00400644 T strncpy

00400a44 T strnlen

00736044 B tbdf

0073605c b tbl_entries

0040a69c D timebase_period_ns

004066c4 T uartlite_console_init

004067d0 t uartlite_getc

00406678 t uartlite_open

00406834 t uartlite_putc

00406784 t uartlite_tstc

00402384 T udelay

004023b0 t .udelay_not_601

00735db0 A _vmlinux_end

0040d000 A _vmlinux_start

00400dd4 T vsprintf

00400968 W _zimage_start

00400968 T _zimage_start_lib

00400958 T _zimage_start_opd

004028f4 t zlib_adler32

00402dc0 T zlib_inflate

00402bb4 T zlib_inflateEnd

00402cf8 T zlib_inflateIncomp

00402b1c T zlib_inflateInit2

00402a90 T zlib_inflateReset

00403dd4 T zlib_inflate_table

00402a7c T zlib_inflate_workspacesize

00402be0 t zlib_updatewindow


------_=_NextPart_001_01C8EB71.EF25E572
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>Hello =
folks,<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>As I have posted =
recently
before, in a current work project, I have inherited a compactPCI board =
that has
an mpc7447/7448 powerpc processor as well as a Marvell system =
controller, model
mv64462 (stripped down mv64460). The board has a somewhat working Gentoo =
Linux
port running on it from long ago and a company far far away (kernel =
version
2.6.9 built using arch/ppc). To prepare for an upcoming deployment, I =
would
like to bring the OS up-to-date on this board with a newer kernel =
(targeting 2.6.24r3).<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>I have made great =
strides
with help from this mailing list and its archives. I now have a compiled
cuImage ready to boot from my older working u-boot 1.1.2. I now seem to =
be
stuck at the kernel entry point. I&#8217;m not sure if I&#8217;m trying =
to jump
into the kernel at the wrong address, or if I have a serial console =
issue that
prevents me from seeing anymore progress. Here is my =
output:<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>debug&gt; bootm<br>
## Booting image at 00800000 ...<br>
&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.24-gentoo-r3<br>
&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip
compressed)<br>
&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 1515921 Bytes =3D&nbsp; 1.4 =
MB<br>
&nbsp;&nbsp; Load Address: 00400000<br>
&nbsp;&nbsp; Entry Point:&nbsp; 0040095c<br>
&nbsp;&nbsp; Verifying Checksum ... OK<br>
&nbsp;&nbsp; Uncompressing Kernel Image ... OK<br>
## Transferring control to Linux (at address 0040095c) ...<br>
Memory &lt;- &lt;0x0 0x10000000&gt; (256MB)<br>
ENET0: local-mac-address &lt;- 00:a0:d6:62:38:89<br>
CPU clock-frequency &lt;- 0x3b9ac9d8 (1000MHz)<br>
CPU timebase-frequency &lt;- 0x27bc86a (42MHz)<br>
CPU bus-frequency &lt;- 0x9ef21aa (167MHz)</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>zImage starting: loaded at =
0x00400000 (sp:
0x0febfa38)<br>
Allocating 0x35f040 bytes for kernel ...<br>
gunzipping (0x00000000 &lt;- 0x0040d000:0x00735db0)...done 0x312b34 =
bytes</span></font><o:p></o:p></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'>&nbsp;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span =
style=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Linux/PowerPC load: ip=3Dbootp =
root=3D/dev/nfs
rw nfsroot=3D/opt/gentoo console=3DttyMM0,9600n8<br>
Finalizing device tree... flat tree at =
0x7423a0</span></font><o:p></o:p></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>If I run &#8216;nm&#8217; on my elf image, I expect =
to find
some entry point address that corresponds to 0x7423a0, but this is not =
the
case. See nm output below.&nbsp; Does anyone know what I might be doing =
wrong?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>[root@blade3 boot]# nm =
cuImage.giganew.elf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736060 b alloc_min<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736058 b alloc_tbl<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400838 T =
backwards_memcpy<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073606c b bd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736000 b bridge_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736000 A __bss_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736010 b chr1<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736014 b chr2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040aadc d cmdline<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741ee0 B console_ops<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404620 t copy_val<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736018 b cpcr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736004 b cpld_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004060f4 t cpm1_cmd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406174 t cpm2_cmd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736028 b cpm_cmd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405d84 T =
cpm_console_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406440 t =
cpm_serial_getc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406334 t =
cpm_serial_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004062c0 t =
cpm_serial_putc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405d3c t =
cpm_serial_tstc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405c60 T cuboot_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741c14 b cxt<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a1e4 d dbase.1092<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a1a4 d dext.1093<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073603c b disable_port<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741d30 b =
discard_buf.1378<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00409922 d distfix.1169<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004022e8 T __div64_32<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736034 b do_cmd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040c098 A _dtb_end<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040ace0 A _dtb_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404c38 T =
dt_fixup_clock<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404cbc T =
dt_fixup_cpu_clocks<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404aec T =
dt_fixup_mac_address<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404b7c T =
__dt_fixup_mac_addresses<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404dec T =
dt_fixup_memory<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404500 T =
dt_get_reg_format<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404584 T =
dt_is_compatible<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741ef4 B dt_ops<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404684 t dt_xlate<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404a00 T dt_xlate_addr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404a80 T dt_xlate_reg<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736000 A _edata<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736038 b enable_port<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00742000 A _end<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408c98 A _etext<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400108 t exit<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401640 t exit<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402420 t exit<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004044c4 t exit<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401cac t =
fdtm_create_node<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401c10 t fdtm_finalize<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401de4 t =
fdtm_finddevice<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401c54 t =
fdtm_find_node_by_prop_value<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401cf4 t =
fdtm_get_parent<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401bc0 t fdtm_get_path<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401d8c t fdtm_getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401d34 t fdtm_setprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400000 t finddevice<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401e28 t finddevice<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040430c t finddevice<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004050b8 t =
find_node_by_devtype<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004000b0 t =
find_node_by_prop_value<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040446c t =
find_node_by_prop_value<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040092c T flush_cache<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004073ac T ft_add_rsvmap<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004077d4 T ft_begin<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408024 T ft_begin_node<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004078b0 T ft_begin_tree<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004080c4 T =
ft_create_node<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004072d8 T ft_del_prop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004069b0 T ft_end_node<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406b7c T ft_end_tree<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407428 T =
ft_find_descendent<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004075ec T =
ft_find_device<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004079f0 T =
__ft_find_node_by_prop_value<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407af8 T =
ft_find_node_by_prop_value<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407b88 T =
__ft_get_parent<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407c74 T ft_get_parent<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004078c4 T ft_get_path<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406890 t =
ft_get_phandle<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406ab4 t __ft_get_prop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406e4c T ft_get_prop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401b24 T ft_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406f48 t ft_make_space<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004069d4 t ft_next<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040690c t =
ft_node_ph2node<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406938 t =
ft_node_update_after<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004081b4 T ft_nop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407674 T ft_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407cdc T ft_prop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407f84 T ft_prop_int<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407fc8 T ft_prop_str<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406edc t ft_put_bin<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00407e44 T ft_set_prop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406c78 t ft_shuffle<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404414 t get_parent<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400058 t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401e80 t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404364 t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00404fec t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004057e8 t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405ce4 t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040820c t getprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040023c t =
giganew_fixups<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400530 t giganew_reset<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040aadc D __got2_end<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a6e0 D __got2_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004025dc T =
gunzip_discard<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402574 T =
gunzip_exactly<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040251c T gunzip_finish<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040245c T =
gunzip_partial<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040264c T gunzip_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>007364a4 b gzstate<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408804 T inflate_fast<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736000 A _initrd_end<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736000 A _initrd_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a262 d lbase.1090<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004099a2 d lenfix.1168<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a224 d lext.1091<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741eb0 B loader_info<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004008dc T memchr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400904 T memcmp<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400780 T memcpy<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400778 T memmove<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040071c T memset<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040650c T =
mpc5200_psc_console_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736008 b mpsc_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004058e8 T =
mpsc_console_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405a68 t mpsc_getc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405840 t =
mpsc_get_virtreg_of_phandle<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073600c b mpscintr_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405b64 t mpsc_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405ae4 t mpsc_putc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405c14 t mpsc_tstc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736030 b muram_offset<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073602c b muram_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040520c T =
mv64x60_cfg_read<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004052f8 T =
mv64x60_cfg_write<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405288 T =
mv64x60_config_cpu2pci_window<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004055cc T =
mv64x60_config_ctlr_windows<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405408 T =
mv64x60_config_pci_windows<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a4a4 d =
mv64x60_cpu2mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a6a0 D =
mv64x60_cpu2pci_io<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a6c0 D =
mv64x60_cpu2pci_mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a59c d =
mv64x60_dram_selects<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a5ac d =
mv64x60_enet2mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405134 T =
mv64x60_get_bridge_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004051a0 T =
mv64x60_get_bridge_pbase<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040536c T =
mv64x60_get_mem_size<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a60c d =
mv64x60_idma2mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00405044 T =
mv64x60_is_coherent<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a5dc d =
mv64x60_mpsc2mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a564 d =
mv64x60_pci2mem<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a584 d =
mv64x60_pci2reg<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a4d4 d =
mv64x60_pci_acc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a63c d =
mv64x60_pci_cfgio<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736064 b next_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406980 t next_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004082c0 T =
ns16550_console_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004083f0 t ns16550_getc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408264 t ns16550_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408464 t ns16550_putc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408394 t ns16550_tstc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400abc t number<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004098fc d order.1221<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073601c b param<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402854 T parse_elf32<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004027b4 T parse_elf64<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400144 T platform_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741ec4 B platform_ops<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; w
_platform_stack_top<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004014c8 T printf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741db0 b prop_buf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736048 b psc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406614 t psc_getc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004064b0 t psc_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004065b8 t psc_putc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004064c0 t psc_tstc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736040 B rbdf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073604c b reg_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736050 b reg_base<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736054 b reg_shift<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736024 b scc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406258 t =
scc_disable_port<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004061f0 t =
scc_enable_port<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00741d1c b serial_cd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401f84 t serial_close<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401fd4 T =
serial_console_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004021a8 t =
serial_edit_cmdline<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401ed8 t serial_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401f20 t serial_write<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004015e8 t setprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004043bc t setprop<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040868c T =
simple_alloc_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004085d4 t =
simple_find_entry<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408658 t simple_free<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004084d0 t simple_malloc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00408754 t =
simple_realloc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400a78 t skip_atoi<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736020 b smc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040608c t =
smc_disable_port<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406024 t =
smc_enable_port<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736068 b space_left<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>007360a4 b sprint_buf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00401574 T sprintf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040167c T start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400000 A _start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040aadc A =
__start___builtin_cmdline<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040acdc A =
__stop___builtin_cmdline<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040066c T strcat<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400698 T strchr<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004006b8 T strcmp<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400628 T strcpy<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400704 T strlen<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004006dc T strncmp<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400644 T strncpy<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400a44 T strnlen<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00736044 B tbdf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0073605c b tbl_entries<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040a69c D =
timebase_period_ns<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004066c4 T =
uartlite_console_init<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004067d0 t uartlite_getc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406678 t uartlite_open<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406834 t uartlite_putc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00406784 t uartlite_tstc<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402384 T udelay<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004023b0 t =
.udelay_not_601<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00735db0 A _vmlinux_end<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0040d000 A =
_vmlinux_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400dd4 T vsprintf<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400968 W _zimage_start<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400968 T =
_zimage_start_lib<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00400958 T =
_zimage_start_opd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>004028f4 t zlib_adler32<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402dc0 T zlib_inflate<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402bb4 T =
zlib_inflateEnd<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402cf8 T =
zlib_inflateIncomp<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402b1c T =
zlib_inflateInit2<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402a90 T =
zlib_inflateReset<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00403dd4 T =
zlib_inflate_table<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402a7c T =
zlib_inflate_workspacesize<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>00402be0 t =
zlib_updatewindow<o:p></o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C8EB71.EF25E572--
