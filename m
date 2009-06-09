Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 00999B70AC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 04:17:02 +1000 (EST)
MIME-Version: 1.0
Date: Tue, 9 Jun 2009 23:38:40 +0530
Message-ID: <6213bc560906091108j2526efeep1dc9397123df5e0@mail.gmail.com>
Subject: "Info threads" hangs in Linux-2.6.29 with KGDBOE
From: srikanth krishnakar <skrishnakar@gmail.com>
To: kgdb-bugreport@lists.sourceforge.net
Content-Type: multipart/alternative; boundary=000e0cd157449ee15e046bee3f44
Cc: Jason Wessel <jason.wessel@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cd157449ee15e046bee3f44
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi All,

*ISSUE *: "*Info threads*" hangs in KGDBOE
Kernel : Linux-2.6.29
Bug found in Architectures: PowerPC (ppc32), x86
-------

While trying to run kernel* Linux-2.6.29* on* PowerPC* Xilinx target
with *KGDBOE
*enabled.  Further issues arise when I run  "*info threads*" after
connecting to the target. following is the error:

(gdb) target remote udp:10.161.2.35:6443

warning: The remote protocol may be unreliable over UDP.

Some events may be lost, rendering further debugging impossible.

Remote debugging using udp:10.161.2.35:6443

kgdb_breakpoint () at kernel/kgdb.c:1803

1803            arch_kgdb_breakpoint();

(gdb) info threads
[New Thread -2]
[New Thread 2]
[New Thread 3]
[New Thread 4]
[New Thread 5]
[New Thread 6]
[New Thread 59]
[New Thread 67]
[New Thread 101]
[New Thread 102]
[New Thread 103]
[New Thread 104]
[New Thread 105]
 14 Thread 105 (nfsiod)  __switch_to (prev=<value optimized out>,
new=0xcf89c100) at arch/powerpc/kernel/process.c:411
 13 Thread 104 (aio/0)  __switch_to (prev=<value optimized out>,
new=0xcf82f4e0) at arch/powerpc/kernel/process.c:411
 12 Thread 103 (kswapd0)  __switch_to (prev=<value optimized out>,
new=0xcf82f4e0) at arch/powerpc/kernel/process.c:411
 11 Thread 102 (pdflush)  __switch_to (prev=<value optimized out>,
new=0xcf82e880) at arch/powerpc/kernel/process.c:411
 10 Thread 101 (pdflush)  Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...
Ignoring packet error, continuing...

Finally kernel dies, after these error messages. This issue is not found
till Linux-2.6.28.10 kernel version, KGDBOE works fine in x86 & PowerPC. Now
the bug is seen in x86 (32bit) and PowerPC from kernel version Linux-2.6.29

Hope this should not be raw_smp_processor_id issue ! The CPU ID returned in
both arch's is 0.  Which patch in netpoll* or any net device has caused this
issue.

One more thing to notice in x86 or PowerPC the kernel dies exactly after
reply of four threads/packets.


Thanks,
Srikanth Krishnakar

--000e0cd157449ee15e046bee3f44
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All,<br><br><b>ISSUE </b>: &quot;<b>Info threads</b>&quot; hangs in KGDB=
OE <br>Kernel : Linux-2.6.29<br>Bug found in Architectures: PowerPC (ppc32)=
, x86<br>-------<br><br>While trying to run kernel<b style=3D"color: rgb(15=
3, 0, 0);"> Linux-2.6.29</b> on<b> PowerPC</b> Xilinx target with <b>KGDBOE=
 </b>enabled. =A0Further issues arise when I run =A0&quot;<b>info threads</=
b>&quot; after connecting to the target. following is the error:<br>

<br>(gdb) target remote udp:<a href=3D"http://10.161.2.35:6443/" target=3D"=
_blank">10.161.2.35:6443</a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<br>warning: The=
 remote protocol may be unreliable over UDP. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<br>

Some events may be lost, rendering further debugging impossible. =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<br>Remote debugging using u=
dp:<a href=3D"http://10.161.2.35:6443/" target=3D"_blank">10.161.2.35:6443<=
/a> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 <br>

kgdb_breakpoint () at kernel/kgdb.c:1803 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<br>=
1803 =A0 =A0 =A0 =A0 =A0 =A0arch_kgdb_breakpoint(); =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 <br>(gdb) info threads<br>[New Thread -2]<br>

[New Thread 2]<br>[New Thread 3]<br>[New Thread 4]<br>[New Thread 5]<br>[Ne=
w Thread 6]<br>[New Thread 59]<br>[New Thread 67]<br>[New Thread 101]<br>[N=
ew Thread 102]<br>[New Thread 103]<br>[New Thread 104]<br>[New Thread 105]<=
br>

 =A014 Thread 105 (nfsiod) =A0__switch_to (prev=3D&lt;value optimized out&g=
t;, new=3D0xcf89c100) at arch/powerpc/kernel/process.c:<div id=3D":zr" clas=
s=3D"ii gt">411<br> =A013 Thread 104 (aio/0) =A0__switch_to (prev=3D&lt;val=
ue optimized out&gt;, new=3D0xcf82f4e0) at arch/powerpc/kernel/process.c:41=
1<br>

 =A012 Thread 103 (kswapd0) =A0__switch_to (prev=3D&lt;value optimized out&=
gt;, new=3D0xcf82f4e0) at arch/powerpc/kernel/process.c:411<br> =A011 Threa=
d 102 (pdflush) =A0__switch_to (prev=3D&lt;value optimized out&gt;, new=3D0=
xcf82e880) at arch/powerpc/kernel/process.c:411<br>

 =A010 Thread 101 (pdflush) =A0Ignoring packet error, continuing...<br>Igno=
ring packet error, continuing...<br>Ignoring packet error, continuing...<br=
>Ignoring packet error, continuing...<br>Ignoring packet error, continuing.=
..<br>

<br>Finally kernel dies, after these error messages. This issue is not foun=
d till Linux-2.6.28.10 kernel version, KGDBOE works fine in x86 &amp; Power=
PC. Now the bug is seen in x86 (32bit) and PowerPC from kernel version Linu=
x-2.6.29<br>
<br>Hope this should not be raw_smp_processor_id issue ! The CPU ID returne=
d in both arch&#39;s is 0.=A0 Which patch in netpoll* or any net device has=
 caused this issue. <br><br>One more thing to notice in x86 or PowerPC the =
kernel dies exactly after reply of four threads/packets.<br>
<br><br>Thanks,<br><font color=3D"#888888">Srikanth Krishnakar</font></div>=
<br clear=3D"all"><br><br><br><br>

--000e0cd157449ee15e046bee3f44--
