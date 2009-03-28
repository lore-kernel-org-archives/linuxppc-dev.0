Return-Path: <skrishnakar@gmail.com>
MIME-Version: 1.0
Date: Sat, 28 Mar 2009 16:57:17 +0530
Message-ID: <6213bc560903280427n6fa95761j2c0e173825ad97f5@mail.gmail.com>
Subject: KGDB8250 on PowerPC-440 does not hit KGDB breakpoint
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cd177cebdf8ca04662c2106
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd177cebdf8ca04662c2106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I am using KGDB on powerpc-440. This is tested on* Linux-2.6.27*, the
following arguments to KGDB showing init_delay of 8250 as shown below:

Target Side :

-----------------------------

Linux/PowerPC load: console=ttyS0 ip=bootp root=/dev/nfs rw
kgdb8250=ttyS0,9600 kgdbwait
Finalizing device tree... flat tree at
0x5ad300
*kgdb8250: ttyS0 init delayed, use io/mmio/mbase syntax for early init.
*
.....
.....
.......
......
......
.......
......
console [ttyS0] enabled
kgdb: Registered I/O driver kgdb8250.

Stops here ->
-------------------------------

Host Side:

(gdb) target remote
/dev/ttyS0
Remote debugging using
/dev/ttyS0
0xc01a760c in mem_serial_in (p=0xc036e050, offset=<value optimized
out>)
    at
/opt/XILINX-MVL6/SUNDAY-March-28/linux-2.6.29/arch/powerpc/include/asm/io.h:153

153     DEF_MMIO_IN_BE(in_8,     8, lbz);

(gdb) info threads
14 Thread 109 (nfsiod)  __switch_to (prev=<value optimized out>,
new=0xcf8227f0) at arch/powerpc/kernel/process.c:412
  13 Thread 108 (aio/0)  __switch_to (prev=<value optimized out>,
new=0xcf8227f0) at arch/powerpc/kernel/process.c:412
  12 Thread 107 (kswapd0)  __switch_to (prev=<value optimized out>,
new=0xcf8227f0) at arch/powerpc/kernel/process.c:412
  11 Thread 106 (pdflush)  __switch_to (prev=<value optimized out>,
new=0xcf8227f0) at arch/powerpc/kernel/process.c:412
  10 Thread 105 (pdflush)  __switch_to (prev=<value optimized out>,
new=0xcf8227f0) at arch/powerpc/kernel/process.c:412


********************
But when I say Continue -> <Got the Error as below >

(gdb) c
Continuing.
*warning: Remote failure reply: E22    *

------------------------

Can anybody correct me, where I am going wrong. I am not able to hit KGDB
breakpoint. ?


-- 

Regards
Srikanth Krishnakar
**********************

--000e0cd177cebdf8ca04662c2106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I am using KGDB on powerpc-440. This is tested on<b> Linux-2=
.6.27</b>, the following arguments to KGDB showing init_delay of 8250 as sh=
own below:<br><br>Target Side :<br><br>-----------------------------<br>
<br>Linux/PowerPC load: console=3DttyS0 ip=3Dbootp root=3D/dev/nfs rw kgdb8=
250=3DttyS0,9600 kgdbwait<br>Finalizing device tree... flat tree at 0x5ad30=
0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br><b style=3D"color: rgb=
(255, 0, 0);">kgdb8250: ttyS0 init delayed, use io/mmio/mbase syntax for ea=
rly init.=A0=A0=A0=A0 </b><br>
.....<br>.....<br>.......<br>......<br>......<br>.......<br>......<br>conso=
le [ttyS0] enabled<br>kgdb: Registered I/O driver kgdb8250.<br><br>Stops he=
re -&gt; <br clear=3D"all">-------------------------------<br><br>Host Side=
:<br>
<br>(gdb) target remote /dev/ttyS0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 <br>Remote debugging using /dev/ttyS0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>0=
xc01a760c in mem_serial_in (p=3D0xc036e050, offset=3D&lt;value optimized ou=
t&gt;)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
=A0=A0=A0 at /opt/XILINX-MVL6/SUNDAY-March-28/linux-2.6.29/arch/powerpc/inc=
lude/asm/io.h:153=A0=A0=A0=A0=A0=A0=A0 <br>153=A0=A0=A0=A0 DEF_MMIO_IN_BE(i=
n_8,=A0=A0=A0=A0 8, lbz);=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>(gdb) info threads=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>
14 Thread 109 (nfsiod)=A0 __switch_to (prev=3D&lt;value optimized out&gt;, =
new=3D0xcf8227f0) at arch/powerpc/kernel/process.c:412<br>=A0 13 Thread 108=
 (aio/0)=A0 __switch_to (prev=3D&lt;value optimized out&gt;, new=3D0xcf8227=
f0) at arch/powerpc/kernel/process.c:412 <br>
=A0 12 Thread 107 (kswapd0)=A0 __switch_to (prev=3D&lt;value optimized out&=
gt;, new=3D0xcf8227f0) at arch/powerpc/kernel/process.c:412<br>=A0 11 Threa=
d 106 (pdflush)=A0 __switch_to (prev=3D&lt;value optimized out&gt;, new=3D0=
xcf8227f0) at arch/powerpc/kernel/process.c:412<br>
=A0 10 Thread 105 (pdflush)=A0 __switch_to (prev=3D&lt;value optimized out&=
gt;, new=3D0xcf8227f0) at arch/powerpc/kernel/process.c:412<br><br><br>****=
****************<br>But when I say Continue -&gt; &lt;Got the Error as belo=
w &gt;<br>
<br>(gdb) c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>Continuing.=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 <br><b style=3D"color: rgb(204, 0, 0);">warning: Remo=
te failure reply: E22=A0=A0=A0=A0</b><span style=3D"color: rgb(204, 0, 0);"=
>=A0=A0=A0 </span><br>
<br>------------------------<br><br>Can anybody correct me, where I am goin=
g wrong. I am not able to hit KGDB breakpoint. ?<br><br><br>-- <br><br>Rega=
rds<br>Srikanth Krishnakar<br>**********************<br>

--000e0cd177cebdf8ca04662c2106--
