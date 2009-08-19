Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc3-s23.blu0.hotmail.com (blu0-omc3-s23.blu0.hotmail.com
	[65.55.116.98])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 34E2CB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 23:02:24 +1000 (EST)
Message-ID: <BLU124-W26979C48CA968E784AEA0CB4FE0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_64f30dfb-3128-42ce-98cd-dc1ed4bc4fff_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Linux booting problem on powerpc 440
Date: Wed, 19 Aug 2009 13:01:16 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_64f30dfb-3128-42ce-98cd-dc1ed4bc4fff_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable











Hi all=2C
I am trying to boot linux kernel (2.6.30) on a custom built board.I am usin=
g simple ppc platform and attached are my dts file and boot log..
I've 16Mb of RAM=2CUART and UIC with powerpc 440x5 processor.Kernel Image s=
ize is less than 1 mb.
i am not using any bootloaders such as U-boot
i have a small program on reset vector which will copy linux bin image from=
 flash to 4mb (Link Address as per wrapper script)=2C after that execution =
starts from link address.
the problem that i face is kernel crashes in different places while booting=
 for different linux images=2C but always mentioned that=20
TASK =3D 'swapper'

Can anyone tell what would be the problem..?

Thanks=2C
Sumesh.

boot log is as below:---------------------zImage starting: loaded at 0x0040=
0000 (sp: 0x004deeb0)Allocating 0x1dad84 bytes for kernel ...gunzipping (0x=
00000000 <- 0x0040c000:0x004dd3f1)...done 0x1c31cc bytes
Linux/PowerPC load: console=3DttyS0 root=3D/dev/ramFinalizing device tree..=
. flat tree at 0x4eb300Top of RAM: 0x1000000=2C Total RAM: 0x1000000
Zone PFN ranges:  DMA      0x00000000 -> 0x00001000  Normal   0x00001000 ->=
 0x00001000Movable zone start PFN for each nodeearly_node_map[1] active PFN=
 ranges    0: 0x00000000 -> 0x00001000MMU: Allocated 1088 bytes of context =
maps for 255 contextsBuilt 1 zonelists in Zone order=2C mobility grouping o=
ff.  Total pages: 4064Kernel command line: console=3DttyS0 root=3D/dev/ramN=
R_IRQS:512UIC0 (32 IRQ sources) at DCR 0x1c0BUG: recent printk recursion!Oo=
ps: Kernel access of bad area=2C sig: 11 [#1]PREEMPT PowerPC 44x PlatformMo=
dules linked in:NIP: c010c848 LR: c010c9f8 CTR: 00000000REGS: c01bfc10 TRAP=
: 0300   Not tainted  (2.6.30)MSR: 00021000 <ME=2CCE>  CR: 22004042  XER: 2=
0000000DEAR: 00000000=2C ESR: 00800000TASK =3D c01a94b8[0] 'swapper' THREAD=
: c01be000GPR00: 0000005a c01bfcc0 c01a94b8 c01c5eb0 c016f3db 00000002 c01c=
5eb1 00000000 GPR08: 00000000 c016f3dc c016f3dc 00000000 42004048 00f08000 =
c015276c c0152850 GPR16: c015261c c01528dc c01bfe20 ffffffff c01b8628 c01c5=
e8c 00000004 00000000 GPR24: ffffffff c01be000 0000000a c01c628c c01bff68 0=
0000000 c01c5eb2 c016f3db NIP [c010c848] vsnprintf+0x75c/0xeb0LR [c010c9f8]=
 vsnprintf+0x90c/0xeb0Call Trace:[c01bfcc0] [c010c41c] vsnprintf+0x330/0xeb=
0 (unreliable)[c01bfeb0] [c010d100] vscnprintf+0x18/0x38[c01bfec0] [c002ff1=
0] vprintk+0x8c/0x350[c01bff60] [c0030224] printk+0x50/0x60[c01bffa0] [c019=
3830] pidhash_init+0x5c/0xd4[c01bffc0] [c018c744] start_kernel+0x150/0x284[=
c01bfff0] [c0000200] skpinv+0x190/0x1ccInstruction dump:540a073e 5400e13e 7=
d3100ae 7d7150ae 99280000 99680001 39070001 40a2ffd4 2f860005 409effc0 3800=
0000 57ab06b0 <98080000> 7fc3f378 7f64db78 38a1003c ---[ end trace 31fd0ba7=
d8756001 ]---Kernel panic - not syncing: Attempted to kill the idle task!Ca=
ll Trace:[c01bfaf0] [c0005d5c] show_stack+0x4c/0x16c (unreliable)[c01bfb30]=
 [c002f17c] panic+0xa0/0x168[c01bfb80] [c0032eb8] do_exit+0x61c/0x638[c01bf=
bc0] [c000b60c] kernel_bad_stack+0x0/0x4c[c01bfbf0] [c000f310] bad_page_fau=
lt+0x90/0xd8[c01bfc00] [c000e184] handle_page_fault+0x7c/0x80[c01bfcc0] [c0=
10c41c] vsnprintf+0x330/0xeb0[c01bfeb0] [c010d100] vscnprintf+0x18/0x38[c01=
bfec0] [c002ff10] vprintk+0x8c/0x350[c01bff60] [c0030224] printk+0x50/0x60[=
c01bffa0] [c0193830] pidhash_init+0x5c/0xd4[c01bffc0] [c018c744] start_kern=
el+0x150/0x284[c01bfff0] [c0000200] skpinv+0x190/0x1ccRebooting in 180 seco=
nds...

device tree file as bellow:
----------------------------
/dts-v1/=3B
/ {	model =3D "XXX=2Cxxxx"=3B	compatible =3D "XXX=2Cxxxx"=3B	#address-cells=
 =3D <1>=3B	#size-cells =3D <1>=3B	dcr-parent =3D <&SKYBEAM_PPC>=3B		chosen=
	{		bootargs =3D "console=3DttyS0 root=3D/dev/ram"=3B	       	linux=2Cstdou=
t-path =3D "/plb/serial@02080000"=3B	} =3B		aliases {		serial0 =3D &STD_UAR=
T=3B	} =3B		memory	{		device_type =3D "memory"=3B		reg =3D < 0x0 0x01000000=
 >=3B	} =3B		cpus {		#address-cells =3D <1>=3B		#size-cells =3D <0>=3B			SK=
YBEAM_PPC: cpu@0 {			device_type =3D "cpu"=3B			#address-cells =3D <1>=3B		=
	#size-cells =3D <1>=3B			reg =3D <0>=3B			clock-frequency =3D <25000000>=
=3B			compatible =3D "PowerPC=2C440"=2C "ibm=2Cppc440"=3B			d-cache-line-si=
ze =3D <0x20>=3B			d-cache-size =3D <0x8000>=3B			dcr-access-method =3D "na=
tive"=3B			dcr-controller =3B			i-cache-line-size =3D <0x20>=3B			i-cache-s=
ize =3D <0x8000>=3B			model =3D "PowerPC=2C440"=3B			timebase-frequency =3D=
 <25000000>=3B		} =3B	} =3B		UIC0: interrupt-controller0 {		compatible =3D =
"ibm=2Cuic-440ep"=2C"ibm=2Cuic"=3B		interrupt-controller=3B		cell-index =3D=
 <0>=3B		dcr-reg =3D <0x1c0 0x009>=3B		#address-cells =3D <0>=3B		#size-cel=
ls =3D <0>=3B		#interrupt-cells =3D <2>=3B	}=3B		PLB: plb {		#address-cells=
 =3D <1>=3B		#size-cells =3D <1>=3B		compatible =3D "simple-bus"=3B		ranges=
 =3B				STD_UART: serial@02080000 {			device_type =3D "serial"=3B			compati=
ble =3D "ns16550"=3B			reg =3D <0x02080000 0x00000008>=3B			virtual-reg =3D=
 <0x02080000>=3B            clock-frequency =3D <125000000>=3B			current-sp=
eed =3D <9600>=3B			interrupt-parent =3D <&UIC0>=3B			interrupts =3D <0x5 0=
x4>=3B		} =3B	} =3B}  =3B



_________________________________________________________________
View photos of singles in your area Click Here
http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Fdating%2Eninemsn%2Ecom%2E=
au%2Fsearch%2Fsearch%2Easpx%3Fexec%3Dgo%26tp%3Dq%26gc%3D2%26tr%3D1%26lage%3=
D18%26uage%3D55%26cl%3D14%26sl%3D0%26dist%3D50%26po%3D1%26do%3D2%26tracking=
id%3D1046138%26r2s%3D1&_t=3D773166090&_r=3DHotmail_Endtext&_m=3DEXT=

--_64f30dfb-3128-42ce-98cd-dc1ed4bc4fff_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Verdana
}
</style>
</head>
<body class=3D'hmmessage'>

<br>



<style>
.ExternalClass .EC_hmmessage P
{padding:0px=3B}
.ExternalClass body.EC_hmmessage
{font-size:10pt=3Bfont-family:Verdana=3B}
</style>


Hi all=2C<div><br></div><div>I am trying to boot linux kernel (2.6.30) on a=
 custom built board.</div><div>I am using simple ppc platform and attached =
are my dts file and boot log..<br></div><div>I've 16Mb of RAM=2CUART and UI=
C with powerpc 440x5 processor.</div><div>Kernel Image size is less than 1 =
mb.</div><div><br></div><div>i am not using any bootloaders such as U-boot<=
/div><div><br></div><div>i have a small program on reset vector which will =
copy linux bin image from flash to 4mb (Link Address as per wrapper script)=
=2C after that execution starts from link address.</div><div><br></div><div=
>the problem that i face is&nbsp=3Bkernel crashes in different places while=
 booting for different linux images=2C but&nbsp=3Balways mentioned that&nbs=
p=3B</div><div><br></div><div>TASK =3D 'swapper'<br></div><div><br></div><d=
iv><div>Can anyone tell what would be the problem..?<br></div><div><br></di=
v><div>Thanks=2C<br></div><div><div>Sumesh.</div><div><br></div><div><br></=
div><div><div>boot log is as below:</div><div>---------------------</div><d=
iv><div><div>zImage starting: loaded at 0x00400000 (sp: 0x004deeb0)</div><d=
iv>Allocating 0x1dad84 bytes for kernel ...</div><div>gunzipping (0x0000000=
0 &lt=3B- 0x0040c000:0x004dd3f1)...done 0x1c31cc bytes</div><div><br></div>=
<div>Linux/PowerPC load: console=3DttyS0 root=3D/dev/ram</div><div>Finalizi=
ng device tree... flat tree at 0x4eb300</div><div>Top of RAM: 0x1000000=2C =
Total RAM: 0x1000000<br></div><div>Zone PFN ranges:</div><div>&nbsp=3B&nbsp=
=3BDMA &nbsp=3B &nbsp=3B &nbsp=3B0x00000000 -&gt=3B 0x00001000</div><div>&n=
bsp=3B&nbsp=3BNormal &nbsp=3B 0x00001000 -&gt=3B 0x00001000</div><div>Movab=
le zone start PFN for each node</div><div>early_node_map[1] active PFN rang=
es</div><div>&nbsp=3B&nbsp=3B &nbsp=3B0: 0x00000000 -&gt=3B 0x00001000</div=
><div>MMU: Allocated 1088 bytes of context maps for 255 contexts</div><div>=
Built 1 zonelists in Zone order=2C mobility grouping off. &nbsp=3BTotal pag=
es: 4064</div><div>Kernel command line: console=3DttyS0 root=3D/dev/ram</di=
v><div>NR_IRQS:512</div><div>UIC0 (32 IRQ sources) at DCR 0x1c0</div><div>B=
UG: recent printk recursion!</div><div>Oops: Kernel access of bad area=2C s=
ig: 11 [#1]</div><div>PREEMPT PowerPC 44x Platform</div><div>Modules linked=
 in:</div><div>NIP: c010c848 LR: c010c9f8 CTR: 00000000</div><div>REGS: c01=
bfc10 TRAP: 0300 &nbsp=3B Not tainted &nbsp=3B(2.6.30)</div><div>MSR: 00021=
000 &lt=3BME=2CCE&gt=3B &nbsp=3BCR: 22004042 &nbsp=3BXER: 20000000</div><di=
v>DEAR: 00000000=2C ESR: 00800000</div><div>TASK =3D c01a94b8[0] 'swapper' =
THREAD: c01be000</div><div>GPR00: 0000005a c01bfcc0 c01a94b8 c01c5eb0 c016f=
3db 00000002 c01c5eb1 00000000&nbsp=3B</div><div>GPR08: 00000000 c016f3dc c=
016f3dc 00000000 42004048 00f08000 c015276c c0152850&nbsp=3B</div><div>GPR1=
6: c015261c c01528dc c01bfe20 ffffffff c01b8628 c01c5e8c 00000004 00000000&=
nbsp=3B</div><div>GPR24: ffffffff c01be000 0000000a c01c628c c01bff68 00000=
000 c01c5eb2 c016f3db&nbsp=3B</div><div>NIP [c010c848] vsnprintf+0x75c/0xeb=
0</div><div>LR [c010c9f8] vsnprintf+0x90c/0xeb0</div><div>Call Trace:</div>=
<div>[c01bfcc0] [c010c41c] vsnprintf+0x330/0xeb0 (unreliable)</div><div>[c0=
1bfeb0] [c010d100] vscnprintf+0x18/0x38</div><div>[c01bfec0] [c002ff10] vpr=
intk+0x8c/0x350</div><div>[c01bff60] [c0030224] printk+0x50/0x60</div><div>=
[c01bffa0] [c0193830] pidhash_init+0x5c/0xd4</div><div>[c01bffc0] [c018c744=
] start_kernel+0x150/0x284</div><div>[c01bfff0] [c0000200] skpinv+0x190/0x1=
cc</div><div>Instruction dump:</div><div>540a073e 5400e13e 7d3100ae 7d7150a=
e 99280000 99680001 39070001 40a2ffd4&nbsp=3B</div><div>2f860005 409effc0 3=
8000000 57ab06b0 &lt=3B98080000&gt=3B 7fc3f378 7f64db78 38a1003c&nbsp=3B</d=
iv><div>---[ end trace 31fd0ba7d8756001 ]---</div><div>Kernel panic - not s=
yncing: Attempted to kill the idle task!</div><div>Call Trace:</div><div>[c=
01bfaf0] [c0005d5c] show_stack+0x4c/0x16c (unreliable)</div><div>[c01bfb30]=
 [c002f17c] panic+0xa0/0x168</div><div>[c01bfb80] [c0032eb8] do_exit+0x61c/=
0x638</div><div>[c01bfbc0] [c000b60c] kernel_bad_stack+0x0/0x4c</div><div>[=
c01bfbf0] [c000f310] bad_page_fault+0x90/0xd8</div><div>[c01bfc00] [c000e18=
4] handle_page_fault+0x7c/0x80</div><div>[c01bfcc0] [c010c41c] vsnprintf+0x=
330/0xeb0</div><div>[c01bfeb0] [c010d100] vscnprintf+0x18/0x38</div><div>[c=
01bfec0] [c002ff10] vprintk+0x8c/0x350</div><div>[c01bff60] [c0030224] prin=
tk+0x50/0x60</div><div>[c01bffa0] [c0193830] pidhash_init+0x5c/0xd4</div><d=
iv>[c01bffc0] [c018c744] start_kernel+0x150/0x284</div><div>[c01bfff0] [c00=
00200] skpinv+0x190/0x1cc</div><div>Rebooting in 180 seconds...</div></div>=
</div></div><div><br></div><div><br></div><div>device tree file as bellow:<=
br></div></div></div><div><div>----------------------------</div><div><div>=
<br></div><div></div></div><div>/dts-v1/=3B</div><div><br></div><div>/ {</d=
iv><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</s=
pan>model =3D "XXX=2Cxxxx"=3B</div><div><span class=3D"EC_EC_Apple-tab-span=
" style=3D"white-space:pre">	</span>compatible =3D "XXX=2Cxxxx"=3B</div><di=
v><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>#a=
ddress-cells =3D &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-=
span" style=3D"white-space:pre">	</span>#size-cells =3D &lt=3B1&gt=3B=3B</d=
iv><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</s=
pan>dcr-parent =3D &lt=3B&amp=3BSKYBEAM_PPC&gt=3B=3B</div><div><span class=
=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span></div><div><spa=
n class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>chosen<s=
pan class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>{</div=
><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</sp=
an>bootargs =3D "console=3DttyS0 root=3D/dev/ram"=3B</div><div><span class=
=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span> &nbsp=3B &nbsp=
=3B &nbsp=3B <span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre"=
>	</span>linux=2Cstdout-path =3D "/plb/serial@02080000"=3B</div><div><span =
class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>} =3B</div=
><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</spa=
n></div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre"=
>	</span>aliases {</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"=
white-space:pre">		</span>serial0 =3D &amp=3BSTD_UART=3B</div><div><span cl=
ass=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>} =3B</div><=
div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>=
</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	=
</span>memory<span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre"=
>	</span>{</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-sp=
ace:pre">		</span>device_type =3D "memory"=3B</div><div><span class=3D"EC_E=
C_Apple-tab-span" style=3D"white-space:pre">		</span>reg =3D &lt=3B 0x0 0x0=
1000000 &gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"w=
hite-space:pre">	</span>} =3B</div><div><span class=3D"EC_EC_Apple-tab-span=
" style=3D"white-space:pre">	</span></div><div><span class=3D"EC_EC_Apple-t=
ab-span" style=3D"white-space:pre">	</span>cpus {</div><div><span class=3D"=
EC_EC_Apple-tab-span" style=3D"white-space:pre">		</span>#address-cells =3D=
 &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"w=
hite-space:pre">		</span>#size-cells =3D &lt=3B0&gt=3B=3B</div><div><span c=
lass=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span></div><div>=
<span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</span>SKY=
BEAM_PPC: cpu@0 {</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"w=
hite-space:pre">			</span>device_type =3D "cpu"=3B</div><div><span class=3D=
"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>#address-cells =
=3D &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=
=3D"white-space:pre">			</span>#size-cells =3D &lt=3B1&gt=3B=3B</div><div><=
span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>reg=
 =3D &lt=3B0&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=
=3D"white-space:pre">			</span>clock-frequency =3D &lt=3B25000000&gt=3B=3B<=
/div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		=
	</span>compatible =3D "PowerPC=2C440"=2C "ibm=2Cppc440"=3B</div><div><span=
 class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>d-cache=
-line-size =3D &lt=3B0x20&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab=
-span" style=3D"white-space:pre">			</span>d-cache-size =3D &lt=3B0x8000&gt=
=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:=
pre">			</span>dcr-access-method =3D "native"=3B</div><div><span class=3D"E=
C_EC_Apple-tab-span" style=3D"white-space:pre">			</span>dcr-controller =3B=
</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	=
		</span>i-cache-line-size =3D &lt=3B0x20&gt=3B=3B</div><div><span class=3D=
"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>i-cache-size =3D=
 &lt=3B0x8000&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=
=3D"white-space:pre">			</span>model =3D "PowerPC=2C440"=3B</div><div><span=
 class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>timebas=
e-frequency =3D &lt=3B25000000&gt=3B=3B</div><div><span class=3D"EC_EC_Appl=
e-tab-span" style=3D"white-space:pre">		</span>} =3B</div><div><span class=
=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>} =3B</div><div=
><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span></d=
iv><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</s=
pan>UIC0: interrupt-controller0 {</div><div><span class=3D"EC_EC_Apple-tab-=
span" style=3D"white-space:pre">		</span>compatible =3D "ibm=2Cuic-440ep"=
=2C"ibm=2Cuic"=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"w=
hite-space:pre">		</span>interrupt-controller=3B</div><div><span class=3D"E=
C_EC_Apple-tab-span" style=3D"white-space:pre">		</span>cell-index =3D &lt=
=3B0&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white=
-space:pre">		</span>dcr-reg =3D &lt=3B0x1c0 0x009&gt=3B=3B</div><div><span=
 class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</span>#address=
-cells =3D &lt=3B0&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" =
style=3D"white-space:pre">		</span>#size-cells =3D &lt=3B0&gt=3B=3B</div><d=
iv><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</span>=
#interrupt-cells =3D &lt=3B2&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-=
tab-span" style=3D"white-space:pre">	</span>}=3B</div><div><span class=3D"E=
C_EC_Apple-tab-span" style=3D"white-space:pre">	</span></div><div><span cla=
ss=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">	</span>PLB: plb {</d=
iv><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</=
span>#address-cells =3D &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_EC_App=
le-tab-span" style=3D"white-space:pre">		</span>#size-cells =3D &lt=3B1&gt=
=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:=
pre">		</span>compatible =3D "simple-bus"=3B</div><div><span class=3D"EC_EC=
_Apple-tab-span" style=3D"white-space:pre">		</span>ranges =3B</div><div><s=
pan class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</span></div=
><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">		</sp=
an>STD_UART: serial@02080000 {</div><div><span class=3D"EC_EC_Apple-tab-spa=
n" style=3D"white-space:pre">			</span>device_type =3D "serial"=3B</div><di=
v><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>=
compatible =3D "ns16550"=3B</div><div><span class=3D"EC_EC_Apple-tab-span" =
style=3D"white-space:pre">			</span>reg =3D &lt=3B0x02080000 0x00000008&gt=
=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:=
pre">			</span>virtual-reg =3D &lt=3B0x02080000&gt=3B=3B</div><div>&nbsp=3B=
&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bclock-frequency =3D &l=
t=3B125000000&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=
=3D"white-space:pre">			</span>current-speed =3D &lt=3B9600&gt=3B=3B</div><=
div><span class=3D"EC_EC_Apple-tab-span" style=3D"white-space:pre">			</spa=
n>interrupt-parent =3D &lt=3B&amp=3BUIC0&gt=3B=3B</div><div><span class=3D"=
EC_EC_Apple-tab-span" style=3D"white-space:pre">			</span>interrupts =3D &l=
t=3B0x5 0x4&gt=3B=3B</div><div><span class=3D"EC_EC_Apple-tab-span" style=
=3D"white-space:pre">		</span>} =3B</div><div><span class=3D"EC_EC_Apple-ta=
b-span" style=3D"white-space:pre">	</span>} =3B</div><div>} &nbsp=3B=3B</di=
v><div><br></div></div><div><div><br></div></div>
<br /><hr />Click Here <a href=3D'http://a.ninemsn.com.au/b.aspx?URL=3Dhttp=
%3A%2F%2Fdating%2Eninemsn%2Ecom%2Eau%2Fsearch%2Fsearch%2Easpx%3Fexec%3Dgo%2=
6tp%3Dq%26gc%3D2%26tr%3D1%26lage%3D18%26uage%3D55%26cl%3D14%26sl%3D0%26dist=
%3D50%26po%3D1%26do%3D2%26trackingid%3D1046138%26r2s%3D1&_t=3D773166090&_r=
=3DHotmail_Endtext&_m=3DEXT' target=3D'_new'>View photos of singles in your=
 area</a></body>
</html>=

--_64f30dfb-3128-42ce-98cd-dc1ed4bc4fff_--
