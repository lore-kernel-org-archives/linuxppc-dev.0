Return-Path: <just4usai@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.192])
	by ozlabs.org (Postfix) with ESMTP id CACC868871
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Dec 2005 16:29:10 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id s15so993632wxc
	for <linuxppc-dev@ozlabs.org>; Mon, 05 Dec 2005 21:29:09 -0800 (PST)
Message-ID: <c6be647f0512052129s2afd4c1vf4442192ea6d5c28@mail.gmail.com>
Date: Tue, 6 Dec 2005 10:59:08 +0530
From: sairam k <just4usai@gmail.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <c6be647f0512052125hecac836pf9891a346e9327e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1750_32802150.1133846948802"
References: <c6be647f0512052125hecac836pf9891a346e9327e8@mail.gmail.com>
Subject: Does this Bug fixed ?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1750_32802150.1133846948802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

1) I used linuxppc_2_4_devel PowerPC development tree source(from
ppc.bkbits.net) to build kernel for PowerPC IBM405EP(evb405ep_defconfig) an=
d
montavista's gcc cross compiler for ppc_405-

2)I gave the following commands..
  make evb405ep_config
  make mrproper
  make clean
  make dep
  make zImage

3) when i gave 'make zImage' command, the compilation stopped abnormally an=
d
gave error that OPB_BASE_START symbol is unknown in file ibm405ep.c
(arch/ppc/platforms/ibm405ep.c)

4) The point in source code where problem is arising is shown below....
-----------------------------------------------------------------------

  ..................
  struct ocp_def core_ocp[] __initdata =3D {
 { .vendor =3D OCP_VENDOR_IBM,
  .function =3D OCP_FUNC_OPB,
  .index =3D 0,
  .paddr =3D OPB_BASE_START, // UNKOWN SYMBOL
  .irq =3D OCP_IRQ_NA,
  .pm =3D OCP_CPM_NA,

  .........
  ..........

----------------------------------------------------------------------
Suggestion 1) I fixed this bug by providing the OPB_BASE_START address.
Since the core of ibm405EP is same as that of ibm405Gp & ibm405Gpr, the
OPB_BASE_START address will be same for all.

  So just include the following line in ibm405ep.h
(ie., in arch/ppc/platforms/ibm405ep.h)

 #define OPB_BASE_START 0x40000000

2) After adding the above line, I recompiled the sources again....and this
time it compiled and i am able to work on IBM405Ep board.
(configuration file for IBm405ep is 'evb405ep_defconfig' in configs folder)


Does anyone fixed this bug........if so why it is not reflected in bkbits

------=_Part_1750_32802150.1133846948802
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><span class=3D"gmail_quote"><br><br></span><code>1)
I used linuxppc_2_4_devel PowerPC development tree source(from <a href=3D"h=
ttp://ppc.bkbits.net" target=3D"_blank" onclick=3D"return top.js.OpenExtLin=
k(window,event,this)">ppc.bkbits.net</a>) to build
kernel for PowerPC IBM405EP(evb405ep_defconfig) and montavista's gcc
cross compiler for ppc_405-</code><br>

<code></code><br>

<code>2)I gave the following commands..</code><br>

<code>&nbsp;  make evb405ep_config</code><br>

<code>&nbsp;  make mrproper</code><br>

<code>&nbsp;  make clean</code><br>

<code>&nbsp;  make dep</code><br>

<code>&nbsp;  make zImage</code><br>

<code></code><br>

<code>3) when i gave 'make zImage' command, the compilation stopped
abnormally and gave error that OPB_BASE_START symbol is unknown in file
ibm405ep.c</code><br>

<code>(arch/ppc/platforms/ibm405ep.c) </code><br>

<code></code><br>

<code>4) The point in source code where problem is arising is shown below..=
..</code><br>

<code>---------------------------------------------------------------------=
--</code><br>

<code>&nbsp;    </code><br>

<code>&nbsp;       ..................</code><br>

<code>&nbsp;  struct ocp_def core_ocp[]  __initdata =3D {</code><br>

<code>&nbsp;{ .vendor=09=3D OCP_VENDOR_IBM,</code><br>

<code>&nbsp;         .function=09=3D OCP_FUNC_OPB,</code><br>

<code>&nbsp;  .index=09=3D 0,</code><br>

<code>&nbsp;=09  .paddr=09=3D OPB_BASE_START, // UNKOWN SYMBOL </code><br>

<code>&nbsp;  .irq=09=09=3D OCP_IRQ_NA,</code><br>

<code>&nbsp;  .pm=09=09=3D OCP_CPM_NA,</code><br>

<code></code><br>

<code>&nbsp;            .........</code><br>

<code>&nbsp;            ..........</code><br>

<code></code><br>

<code>---------------------------------------------------------------------=
-</code>
<table border=3D"0" cellpadding=3D"3" cellspacing=3D"1" width=3D"100%">
<tbody><tr><td bgcolor=3D"#e0e0e0">Suggestion</td></tr></tbody>
</table>
 <code>1) I fixed this bug by providing the OPB_BASE_START address.</code><=
br>

<code>Since the core of ibm405EP is same as that of ibm405Gp &amp; ibm405Gp=
r, the OPB_BASE_START address will be same for all.</code><br>

<code></code><br>

<code>&nbsp;                So just include the following line in ibm405ep.=
h</code><br>

<code>(ie., in arch/ppc/platforms/ibm405ep.h)</code><br>

<code></code><br>

<code>&nbsp;#define OPB_BASE_START 0x40000000</code><br>

<code></code><br>

<code>2) After adding the above line, I recompiled the sources
again....and this time it compiled and i am able to work on IBM405Ep
board.</code><br>

<code>(configuration file for IBm405ep is 'evb405ep_defconfig' in configs f=
older)<br>
<br>
<br>
Does anyone fixed this bug........if so why it is not reflected in bkbits<b=
r>
</code>

<code></code><br>

<code><br>
</code>


------=_Part_1750_32802150.1133846948802--
