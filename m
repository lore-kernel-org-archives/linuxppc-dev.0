Return-Path: <sumeshkkn@hotmail.com>
Received: from blu0-omc3-s35.blu0.hotmail.com (blu0-omc3-s35.blu0.hotmail.com
	[65.55.116.110])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 79CE0B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 19:02:06 +1000 (EST)
Message-ID: <BLU124-W247F8F54D67DB56A0DC30CB40B0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6fdff2b4-2842-4a68-979a-18aa4998b591_"
From: Sumesh Kaana <sumeshkkn@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Linux booting problem
Date: Fri, 7 Aug 2009 09:02:03 +0000
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_6fdff2b4-2842-4a68-979a-18aa4998b591_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi all=2C
I am trying to boot linux kernel (2.6.30) on a custom built board.I am usin=
g simple ppc platform and attached are my dts file and boot log..
I've 26Mb of RAM=2CUART and UIC with powerpc 440x5 processor.Kernel Image s=
ize is less than 1 mb.
cgc=2Cskybeam  board is added in arch/powerpc/platforms/44x/ppc44x_simple.c
device tree file as bellow:----------------------------
/dts-v1/=3B
/ {	model =3D "cgc=2Cskybeam"=3B	compatible =3D "cgc=2Cskybeam"=3B	#address=
-cells =3D <1>=3B	#size-cells =3D <1>=3B	dcr-parent =3D <&SKYBEAM_PPC>=3B		=
chosen	{		bootargs =3D "console=3DttyS0 root=3D/dev/ram"=3B	       	linux=
=2Cstdout-path =3D "/plb/serial@02080000"=3B	} =3B		aliases {		serial0 =3D =
&STD_UART=3B	} =3B		memory	{		device_type =3D "memory"=3B		reg =3D < 0x0 0x=
01A00000 >=3B	} =3B		cpus {		#address-cells =3D <1>=3B		#size-cells =3D <0>=
=3B			SKYBEAM_PPC: cpu@0 {			device_type =3D "cpu"=3B			#address-cells =3D =
<1>=3B			#size-cells =3D <1>=3B			reg =3D <0>=3B			clock-frequency =3D <250=
00000>=3B			compatible =3D "PowerPC=2C440"=2C "ibm=2Cppc440"=3B			d-cache-l=
ine-size =3D <0x20>=3B			d-cache-size =3D <0x8000>=3B			dcr-access-method =
=3D "native"=3B			dcr-controller =3B			i-cache-line-size =3D <0x20>=3B			i-=
cache-size =3D <0x8000>=3B			model =3D "PowerPC=2C440"=3B			timebase-freque=
ncy =3D <25000000>=3B		} =3B	} =3B		UIC0: interrupt-controller0 {		compatib=
le =3D "ibm=2Cuic-440ep"=2C"ibm=2Cuic"=3B		interrupt-controller=3B		cell-in=
dex =3D <0>=3B		dcr-reg =3D <0x1c0 0x009>=3B		#address-cells =3D <0>=3B		#s=
ize-cells =3D <0>=3B		#interrupt-cells =3D <2>=3B	}=3B		PLB: plb {		#addres=
s-cells =3D <1>=3B		#size-cells =3D <1>=3B		compatible =3D "simple-bus"=3B	=
	ranges =3B				STD_UART: serial@02080000 {			device_type =3D "serial"=3B			=
compatible =3D "ns16550"=3B			reg =3D <0x02080000 0x00000008>=3B			virtual-=
reg =3D <0x02080000>=3B            clock-frequency =3D <125000000>=3B			cur=
rent-speed =3D <9600>=3B			interrupt-parent =3D <&UIC0>=3B			interrupts =3D=
 <0x5 0x4>=3B		} =3B	} =3B}  =3B
boot log is as below:---------------------

zImage starting: loaded at 0x00400000 (sp: 0x004deeb0)Allocating 0x1dad84 b=
ytes for kernel ...gunzipping (0x00000000 <- 0x0040c000:0x004dd3fc)...done =
0x1c31cc bytes
Linux/PowerPC load: console=3DttyS0 root=3D/dev/ramFinalizing device tree..=
. flat tree at 0x4eb300Debug print:This worksDebug print:############!!!!##=
#########Memory hole size: 0MB
Unable to handle kernel paging request for data at address 0x01a00000Faulti=
ng instruction address: 0xc0011434Oops: Kernel access of bad area=2C sig: 1=
1 [#1]PREEMPT PowerPC 44x PlatformModules linked in:NIP: c0011434 LR: c010d=
cb0 CTR: 00000001REGS: c01bfe60 TRAP: 0300   Not tainted  (2.6.30)MSR: 0002=
1000 <ME=2CCE>  CR: 22000024  XER: 20000000DEAR: 01a00000=2C ESR: 00000000T=
ASK =3D c01a94b8[0] 'swapper' THREAD: c01be000GPR00: fffffff4 c01bff10 c01a=
94b8 01a00000 019fffff 0000000c c01958b0 00000000GPR08: 00000037 c0110000 0=
0000042 00003fff 22000022 00000000 fffff104 00000000GPR16: 00000000 0000000=
0 00000000 00000000 00000000 00000000 c010d750 c01958b0GPR24: 0000000c 0000=
0000 c01a1dfc 01a00000 c01a1dfc 00003fff 0000000c 00000000NIP [c0011434] st=
rlen+0x4/0x18LR [c010dcb0] match_token+0x1a0/0x228Call Trace:[c01bff50] [c0=
1962f4] free_area_init_nodes+0x48/0x3a0[c01bff80] [c0191738] paging_init+0x=
80/0xa0[c01bffb0] [c01909b4] setup_arch+0x1c4/0x1dc[c01bffc0] [c018c648] st=
art_kernel+0x54/0x288[c01bfff0] [c0000200] skpinv+0x190/0x1ccInstruction du=
mp:4d820020 7ca903a6 38a3ffff 3884ffff 8c650001 2c830000 8c040001 7c6018514=
d860020 4102ffec 4e800020 3883ffff <8c040001> 2c000000 4082fff8 7c632050---=
[ end trace 31fd0ba7d8756001 ]---Kernel panic - not syncing: Attempted to k=
ill the idle task!Call Trace:[c01bfd40] [c0005d5c] show_stack+0x4c/0x16c (u=
nreliable)[c01bfd80] [c002f174] panic+0xa0/0x168[c01bfdd0] [c0032eb0] do_ex=
it+0x61c/0x638[c01bfe10] [c000b60c] kernel_bad_stack+0x0/0x4c[c01bfe40] [c0=
00f328] bad_page_fault+0x90/0xd8[c01bfe50] [c000e19c] handle_page_fault+0x7=
c/0x80[c01bff10] [00000000] (null)[c01bff50] [c01962f4] free_area_init_node=
s+0x48/0x3a0[c01bff80] [c0191738] paging_init+0x80/0xa0[c01bffb0] [c01909b4=
] setup_arch+0x1c4/0x1dc[c01bffc0] [c018c648] start_kernel+0x54/0x288[c01bf=
ff0] [c0000200] skpinv+0x190/0x1ccRebooting in 180 seconds..


Can anyone tell what would be the problem..?


thanks=2CSumesh.


Check the daily blob for the latest on what's happening around the web What=
 goes online=2C stays online
_________________________________________________________________
Need a new model in your life? Sell your car fast.
http://a.ninemsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Fsecure%2Dau%2Eimrworldwid=
e%2Ecom%2Fcgi%2Dbin%2Fa%2Fci%5F450304%2Fet%5F2%2Fcg%5F801459%2Fpi%5F1004813=
%2Fai%5F866383&_t=3D758314219&_r=3Dcarpoint_tagline&_m=3DEXT=

--_6fdff2b4-2842-4a68-979a-18aa4998b591_
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
Hi all=2C<div><br></div><div>I am trying to boot linux kernel (2.6.30) on a=
 custom built board.</div><div>I am using simple ppc platform and attached =
are my dts file and boot log..<br></div><div>I've 26Mb of RAM=2CUART and UI=
C with powerpc 440x5 processor.</div><div>Kernel Image size is less than 1 =
mb.</div><div><br></div><div>cgc=2Cskybeam &nbsp=3Bboard is added in arch/p=
owerpc/platforms/44x/ppc44x_simple.c</div><div><br></div><div><div>device t=
ree file as bellow:</div><div>----------------------------</div><div><br></=
div><div>/dts-v1/=3B</div><div><br></div><div>/ {</div><div><span class=3D"=
EC_Apple-tab-span" style=3D"white-space:pre">	</span>model =3D "cgc=2Cskybe=
am"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre=
">	</span>compatible =3D "cgc=2Cskybeam"=3B</div><div><span class=3D"EC_App=
le-tab-span" style=3D"white-space:pre">	</span>#address-cells =3D &lt=3B1&g=
t=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pr=
e">	</span>#size-cells =3D &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_App=
le-tab-span" style=3D"white-space:pre">	</span>dcr-parent =3D &lt=3B&amp=3B=
SKYBEAM_PPC&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"w=
hite-space:pre">	</span></div><div><span class=3D"EC_Apple-tab-span" style=
=3D"white-space:pre">	</span>chosen<span class=3D"EC_Apple-tab-span" style=
=3D"white-space:pre">	</span>{</div><div><span class=3D"EC_Apple-tab-span" =
style=3D"white-space:pre">		</span>bootargs =3D "console=3DttyS0 root=3D/de=
v/ram"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:=
pre">	</span> &nbsp=3B &nbsp=3B &nbsp=3B <span class=3D"EC_Apple-tab-span" =
style=3D"white-space:pre">	</span>linux=2Cstdout-path =3D "/plb/serial@0208=
0000"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:p=
re">	</span>} =3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"whit=
e-space:pre">	</span></div><div><span class=3D"EC_Apple-tab-span" style=3D"=
white-space:pre">	</span>aliases {</div><div><span class=3D"EC_Apple-tab-sp=
an" style=3D"white-space:pre">		</span>serial0 =3D &amp=3BSTD_UART=3B</div>=
<div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">	</span>} =
=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">	=
</span></div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pr=
e">	</span>memory<span class=3D"EC_Apple-tab-span" style=3D"white-space:pre=
">	</span>{</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-spac=
e:pre">		</span>device_type =3D "memory"=3B</div><div><span class=3D"EC_App=
le-tab-span" style=3D"white-space:pre">		</span>reg =3D &lt=3B 0x0 0x01A000=
00 &gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-spa=
ce:pre">	</span>} =3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"=
white-space:pre">	</span></div><div><span class=3D"EC_Apple-tab-span" style=
=3D"white-space:pre">	</span>cpus {</div><div><span class=3D"EC_Apple-tab-s=
pan" style=3D"white-space:pre">		</span>#address-cells =3D &lt=3B1&gt=3B=3B=
</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">		</=
span>#size-cells =3D &lt=3B0&gt=3B=3B</div><div><span class=3D"EC_Apple-tab=
-span" style=3D"white-space:pre">	</span></div><div><span class=3D"EC_Apple=
-tab-span" style=3D"white-space:pre">		</span>SKYBEAM_PPC: cpu@0 {</div><di=
v><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>dev=
ice_type =3D "cpu"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"=
white-space:pre">			</span>#address-cells =3D &lt=3B1&gt=3B=3B</div><div><s=
pan class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>#size-c=
ells =3D &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=
=3D"white-space:pre">			</span>reg =3D &lt=3B0&gt=3B=3B</div><div><span cla=
ss=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>clock-frequenc=
y =3D &lt=3B25000000&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" s=
tyle=3D"white-space:pre">			</span>compatible =3D "PowerPC=2C440"=2C "ibm=
=2Cppc440"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-sp=
ace:pre">			</span>d-cache-line-size =3D &lt=3B0x20&gt=3B=3B</div><div><spa=
n class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>d-cache-s=
ize =3D &lt=3B0x8000&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" s=
tyle=3D"white-space:pre">			</span>dcr-access-method =3D "native"=3B</div><=
div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>d=
cr-controller =3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"whit=
e-space:pre">			</span>i-cache-line-size =3D &lt=3B0x20&gt=3B=3B</div><div>=
<span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>i-cac=
he-size =3D &lt=3B0x8000&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-spa=
n" style=3D"white-space:pre">			</span>model =3D "PowerPC=2C440"=3B</div><d=
iv><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</span>ti=
mebase-frequency =3D &lt=3B25000000&gt=3B=3B</div><div><span class=3D"EC_Ap=
ple-tab-span" style=3D"white-space:pre">		</span>} =3B</div><div><span clas=
s=3D"EC_Apple-tab-span" style=3D"white-space:pre">	</span>} =3B</div><div><=
span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">	</span></div><d=
iv><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">	</span>UIC0=
: interrupt-controller0 {</div><div><span class=3D"EC_Apple-tab-span" style=
=3D"white-space:pre">		</span>compatible =3D "ibm=2Cuic-440ep"=2C"ibm=2Cuic=
"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">=
		</span>interrupt-controller=3B</div><div><span class=3D"EC_Apple-tab-span=
" style=3D"white-space:pre">		</span>cell-index =3D &lt=3B0&gt=3B=3B</div><=
div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">		</span>dc=
r-reg =3D &lt=3B0x1c0 0x009&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-=
span" style=3D"white-space:pre">		</span>#address-cells =3D &lt=3B0&gt=3B=
=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">	=
	</span>#size-cells =3D &lt=3B0&gt=3B=3B</div><div><span class=3D"EC_Apple-=
tab-span" style=3D"white-space:pre">		</span>#interrupt-cells =3D &lt=3B2&g=
t=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pr=
e">	</span>}=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-=
space:pre">	</span></div><div><span class=3D"EC_Apple-tab-span" style=3D"wh=
ite-space:pre">	</span>PLB: plb {</div><div><span class=3D"EC_Apple-tab-spa=
n" style=3D"white-space:pre">		</span>#address-cells =3D &lt=3B1&gt=3B=3B</=
div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">		</sp=
an>#size-cells =3D &lt=3B1&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-s=
pan" style=3D"white-space:pre">		</span>compatible =3D "simple-bus"=3B</div=
><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">		</span>=
ranges =3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space=
:pre">		</span></div><div><span class=3D"EC_Apple-tab-span" style=3D"white-=
space:pre">		</span>STD_UART: serial@02080000 {</div><div><span class=3D"EC=
_Apple-tab-span" style=3D"white-space:pre">			</span>device_type =3D "seria=
l"=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre"=
>			</span>compatible =3D "ns16550"=3B</div><div><span class=3D"EC_Apple-ta=
b-span" style=3D"white-space:pre">			</span>reg =3D &lt=3B0x02080000 0x0000=
0008&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"white-sp=
ace:pre">			</span>virtual-reg =3D &lt=3B0x02080000&gt=3B=3B</div><div>&nbs=
p=3B&nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3B &nbsp=3Bclock-frequency =
=3D &lt=3B125000000&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" st=
yle=3D"white-space:pre">			</span>current-speed =3D &lt=3B9600&gt=3B=3B</di=
v><div><span class=3D"EC_Apple-tab-span" style=3D"white-space:pre">			</spa=
n>interrupt-parent =3D &lt=3B&amp=3BUIC0&gt=3B=3B</div><div><span class=3D"=
EC_Apple-tab-span" style=3D"white-space:pre">			</span>interrupts =3D &lt=
=3B0x5 0x4&gt=3B=3B</div><div><span class=3D"EC_Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>} =3B</div><div><span class=3D"EC_Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>} =3B</div><div>} &nbsp=3B=3B</div><div><b=
r></div></div><div>boot log is as below:</div><div>---------------------</d=
iv><div><br></div><div><br></div><div><div>zImage starting: loaded at 0x004=
00000 (sp: 0x004deeb0)</div><div>Allocating 0x1dad84 bytes for kernel ...</=
div><div>gunzipping (0x00000000 &lt=3B- 0x0040c000:0x004dd3fc)...done 0x1c3=
1cc bytes</div><div><br></div><div>Linux/PowerPC load: console=3DttyS0 root=
=3D/dev/ram</div><div>Finalizing device tree... flat tree at 0x4eb300</div>=
<div>Debug print:This works</div><div>Debug print:############!!!!#########=
##</div><div>Memory hole size: 0MB<br></div><div>Unable to handle kernel pa=
ging request for data at address 0x01a00000</div><div>Faulting instruction =
address: 0xc0011434</div><div>Oops: Kernel access of bad area=2C sig: 11 [#=
1]</div><div>PREEMPT PowerPC 44x Platform</div><div>Modules linked in:</div=
><div>NIP: c0011434 LR: c010dcb0 CTR: 00000001</div><div>REGS: c01bfe60 TRA=
P: 0300 &nbsp=3B Not tainted &nbsp=3B(2.6.30)</div><div>MSR: 00021000 &lt=
=3BME=2CCE&gt=3B &nbsp=3BCR: 22000024 &nbsp=3BXER: 20000000</div><div>DEAR:=
 01a00000=2C ESR: 00000000</div><div>TASK =3D c01a94b8[0] 'swapper' THREAD:=
 c01be000</div><div>GPR00: fffffff4 c01bff10 c01a94b8 01a00000 019fffff 000=
0000c c01958b0 00000000</div><div>GPR08: 00000037 c0110000 00000042 00003ff=
f 22000022 00000000 fffff104 00000000</div><div>GPR16: 00000000 00000000 00=
000000 00000000 00000000 00000000 c010d750 c01958b0</div><div>GPR24: 000000=
0c 00000000 c01a1dfc 01a00000 c01a1dfc 00003fff 0000000c 00000000</div><div=
>NIP [c0011434] strlen+0x4/0x18</div><div>LR [c010dcb0] match_token+0x1a0/0=
x228</div><div>Call Trace:</div><div>[c01bff50] [c01962f4] free_area_init_n=
odes+0x48/0x3a0</div><div>[c01bff80] [c0191738] paging_init+0x80/0xa0</div>=
<div>[c01bffb0] [c01909b4] setup_arch+0x1c4/0x1dc</div><div>[c01bffc0] [c01=
8c648] start_kernel+0x54/0x288</div><div>[c01bfff0] [c0000200] skpinv+0x190=
/0x1cc</div><div>Instruction dump:</div><div>4d820020 7ca903a6 38a3ffff 388=
4ffff 8c650001 2c830000 8c040001 7c601851</div><div>4d860020 4102ffec 4e800=
020 3883ffff &lt=3B8c040001&gt=3B 2c000000 4082fff8 7c632050</div><div>---[=
 end trace 31fd0ba7d8756001 ]---</div><div>Kernel panic - not syncing: Atte=
mpted to kill the idle task!</div><div>Call Trace:</div><div>[c01bfd40] [c0=
005d5c] show_stack+0x4c/0x16c (unreliable)</div><div>[c01bfd80] [c002f174] =
panic+0xa0/0x168</div><div>[c01bfdd0] [c0032eb0] do_exit+0x61c/0x638</div><=
div>[c01bfe10] [c000b60c] kernel_bad_stack+0x0/0x4c</div><div>[c01bfe40] [c=
000f328] bad_page_fault+0x90/0xd8</div><div>[c01bfe50] [c000e19c] handle_pa=
ge_fault+0x7c/0x80</div><div>[c01bff10] [00000000] (null)</div><div>[c01bff=
50] [c01962f4] free_area_init_nodes+0x48/0x3a0</div><div>[c01bff80] [c01917=
38] paging_init+0x80/0xa0</div><div>[c01bffb0] [c01909b4] setup_arch+0x1c4/=
0x1dc</div><div>[c01bffc0] [c018c648] start_kernel+0x54/0x288</div><div>[c0=
1bfff0] [c0000200] skpinv+0x190/0x1cc</div><div>Rebooting in 180 seconds..<=
/div><div><br></div><div><br></div><div><br></div><div>Can anyone tell what=
 would be the problem..?</div><div><br></div><div><br></div><div><br></div>=
<div>thanks=2C</div><div>Sumesh.</div><div><br></div><div><br></div></div><=
br><hr>Check the daily blob for the latest on what's happening around the w=
eb <a href=3D"http://windowslive.ninemsn.com.au/blog.aspx">What goes online=
=2C stays online</a><br /><hr />Sell your car fast. <a href=3D'http://a.nin=
emsn.com.au/b.aspx?URL=3Dhttp%3A%2F%2Fsecure%2Dau%2Eimrworldwide%2Ecom%2Fcg=
i%2Dbin%2Fa%2Fci%5F450304%2Fet%5F2%2Fcg%5F801459%2Fpi%5F1004813%2Fai%5F8663=
83&_t=3D758314219&_r=3Dcarpoint_tagline&_m=3DEXT' target=3D'_new'>Need a ne=
w model in your life?</a></body>
</html>=

--_6fdff2b4-2842-4a68-979a-18aa4998b591_--
