Return-Path: <rgubler@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id AC60CDE023
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 12:07:43 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so5195960rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 17:07:42 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 23 Jan 2009 17:07:41 -0800
Message-ID: <e4ef24880901231707y7baad5f6kc1f6bde2c30bf29f@mail.gmail.com>
Subject: Ebony DTS compile error
From: Rob Gubler <rgubler@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd29bf0e2d5ee046130219d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd29bf0e2d5ee046130219d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

I'm an ELDK 4.2 user.  I'm trying to compile the ebony.dts file included in
the 2.6.24 kernel but the Device Tree Compiler, dtc, complains of a syntax
error.

ELDK provides me with a binary for dtc, but the command line arguments
specided by the ELDK documentation are not supported with the version of dtc
thats provided with ELDK 4.2. Unfortuntely whatever version of dtc is not
specified by the binary (as best I can tell). So, I used only the arguments
that were supported but was unable to produce the dtb.

Here is the output:

# /opt/eldk/sbin/dtc -I dts -O dtb -f arch/powerpc/boot/dts/ebony.dts  >
~rob/ebony.dtb
DTC: dts->dtb  on file "arch/powerpc/boot/dts/ebony.dts"
syntax error at line 45
FATAL ERROR: Couldn't read input tree

# cat -n arch/powerpc/boot/dts/ebony.dts

...

    44          UIC0: interrupt-controller0 {
    45                  compatible = "ibm,uic-440gp", "ibm,uic";
    46                  interrupt-controller;
    47                  cell-index = <0>;
    48                  dcr-reg = <0c0 009>;
    49                  #address-cells = <0>;
    50                  #size-cells = <0>;
    51                  #interrupt-cells = <2>;




At this point I went and downloaded the latest version (DTC 1.2.0-gb2b4990b)
of dtc from: git://www.jdl.com/software/dtc.git and tried compiling
ebony.dts.  This time I was able to use all of the arguments specified by
the ELDK documents, but I also ran into problems.  This time dtc complained
about the opening bracket.  I read the dtc documentation and it appears it
should be treating ebony.dts as a "version 0" file because "/dts-v1/;" is
not specified.

Here is the output

# ~rob/dtc/dtc -b 0 -V 17 -p 0x1000 -I dts -O dtb -f
arch/powerpc/boot/dts/ebony.dts > ~rob/ebony.dtb
DTC: dts->dtb  on file "arch/powerpc/boot/dts/ebony.dts"
Error: arch/powerpc/boot/dts/ebony.dts 14:0 - 1:0 syntax error
FATAL ERROR: Unable to parse input tree

# cat -n arch/powerpc/boot/dts/ebony.dts

...

    12   */
    13
    14  / {
    15          #address-cells = <2>;
    16          #size-cells = <1>;


Is anyone aware of a version of DTC that will compile the ebony.dts file
included with the 2.6.24 kernel?  Or, an updated ebony.dts file that works
with DTC 1.2.0-gb2b4990b.  Any other suggestions would be great.  Thanks!

-Rob

--000e0cd29bf0e2d5ee046130219d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I&#39;m an ELDK 4.2 user.&nbsp; I&#39;m trying to compile the=
 ebony.dts file included in the 2.6.24 kernel but the Device Tree Compiler,=
 dtc, complains of a syntax error.&nbsp; <br><br>ELDK provides me with a bi=
nary for dtc, but the command line arguments specided by the ELDK documenta=
tion are not supported with the version of dtc thats provided with ELDK 4.2=
. Unfortuntely whatever version of dtc is not specified by the binary (as b=
est I can tell). So, I used only the arguments that were supported but was =
unable to produce the dtb.<br>
<br>Here is the output:<br><br><div style=3D"margin-left: 40px;"># /opt/eld=
k/sbin/dtc -I dts -O dtb -f arch/powerpc/boot/dts/ebony.dts&nbsp; &gt; ~rob=
/ebony.dtb<br>DTC: dts-&gt;dtb&nbsp; on file &quot;arch/powerpc/boot/dts/eb=
ony.dts&quot;<br>
syntax error at line 45<br>FATAL ERROR: Couldn&#39;t read input tree<br><br=
># cat -n arch/powerpc/boot/dts/ebony.dts<br><br>...<br><br>&nbsp;&nbsp;&nb=
sp; 44&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UIC0: interrup=
t-controller0 {<br>&nbsp;&nbsp;&nbsp; 45&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compati=
ble =3D &quot;ibm,uic-440gp&quot;, &quot;ibm,uic&quot;;<br>
&nbsp;&nbsp;&nbsp; 46&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-controller;<br>&=
nbsp;&nbsp;&nbsp; 47&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cell-index =3D &lt;0&gt;;<b=
r>&nbsp;&nbsp;&nbsp; 48&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dcr-reg =3D &lt;0c0 009&=
gt;;<br>&nbsp;&nbsp;&nbsp; 49&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D=
 &lt;0&gt;;<br>&nbsp;&nbsp;&nbsp; 50&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells=
 =3D &lt;0&gt;;<br>
&nbsp;&nbsp;&nbsp; 51&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells =3D &lt;2=
&gt;;<br></div><br><br><br><br>At this point I went and downloaded the late=
st version (DTC 1.2.0-gb2b4990b) of dtc from: git://<a href=3D"http://www.j=
dl.com/software/dtc.git">www.jdl.com/software/dtc.git</a> and tried compili=
ng ebony.dts.&nbsp; This time I was able to use all of the arguments specif=
ied by the ELDK documents, but I also ran into problems.&nbsp; This time dt=
c complained about the opening bracket.&nbsp; I read the dtc documentation =
and it appears it should be treating ebony.dts as a &quot;version 0&quot; f=
ile because &quot;/dts-v1/;&quot; is not specified.<br>
<br>Here is the output<br><br><div style=3D"margin-left: 40px;"># ~rob/dtc/=
dtc -b 0 -V 17 -p 0x1000 -I dts -O dtb -f arch/powerpc/boot/dts/ebony.dts &=
gt; ~rob/ebony.dtb<br>DTC: dts-&gt;dtb&nbsp; on file &quot;arch/powerpc/boo=
t/dts/ebony.dts&quot;<br>
Error: arch/powerpc/boot/dts/ebony.dts 14:0 - 1:0 syntax error<br>FATAL ERR=
OR: Unable to parse input tree<br><br># cat -n arch/powerpc/boot/dts/ebony.=
dts<br><br>...<br><br>&nbsp;&nbsp;&nbsp; 12&nbsp;&nbsp; */<br>&nbsp;&nbsp;&=
nbsp; 13<br>&nbsp;&nbsp;&nbsp; 14&nbsp; / {<br>&nbsp;&nbsp;&nbsp; 15&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells =3D &lt;2&gt=
;;<br>
&nbsp;&nbsp;&nbsp; 16&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 #size-cells =3D &lt;1&gt;;<br></div><br><br>Is anyone aware of a version o=
f DTC that will compile the ebony.dts file included with the 2.6.24 kernel?=
&nbsp; Or, an updated ebony.dts file that works with DTC 1.2.0-gb2b4990b.&n=
bsp; Any other suggestions would be great.&nbsp; Thanks!<br>
<br>-Rob<br>&nbsp; <br>

--000e0cd29bf0e2d5ee046130219d--
