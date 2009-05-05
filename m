Return-Path: <skrishnakar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3bd6b93c0905040742m64e1ef73i102106ca002236b2@mail.gmail.com>
References: <6213bc560905040417p48d3f12co608b885482998e06@mail.gmail.com>
	<6213bc560905040613q3cec9730idece67c1caf67112@mail.gmail.com>
	<3bd6b93c0905040742m64e1ef73i102106ca002236b2@mail.gmail.com>
Date: Tue, 5 May 2009 15:05:24 +0530
Message-ID: <6213bc560905050235l7fd05dfay9938d6600ab5339e@mail.gmail.com>
Subject: Re: KGDBOC testing on linux-2.6.30-rc4
From: srikanth krishnakar <skrishnakar@gmail.com>
To: kgdb-bugreport@lists.sourceforge.net
Content-Type: multipart/alternative; boundary=000e0cd14ed894ddc2046926ff1d
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd14ed894ddc2046926ff1d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Target : PowerPC, Virtex-440 Generic
Serial port : Xilinx 16550 Uart ( depends on OF_PLATFORM)

Further investigation of KGDBOC on PowerPC shows that kgdboc hangs at :

In file : arch/powerpc/include/asm/kgdb.h

*static inline void* arch_kgdb_breakpoint(*void*)
{
        *asm*(*".long 0x7d821008"*); /* *twge r2, r2 **/     * << ----
KGDBOC Hangs here* * << ---*


-----------------------------------------
Debug Log:

root@10.1.2.55:~# echo g >
/proc/sysrq-trigger
SysRq :
GDB

1------------------------>sysrq_handle_gdb

Entering KGDB
1-1----------------------->kgdb_breakpoint
1-2----------------------->kgdb_breakpoint
1-3----------------------->kgdb_breakpoint
1-1----------------------->arch_kgdb_breakpoint

---------------------------------------------


Any comments or suggestions ????

-Srikanth
----------

On Mon, May 4, 2009 at 8:12 PM, Bruce Ashfield <bruce.ashfield@gmail.com>wrote:

> On Mon, May 4, 2009 at 9:13 AM, srikanth krishnakar
> <skrishnakar@gmail.com> wrote:
> >
> >
> > Hi all,
> >
> > I need help in kgdboc  testing on PowerPC target.
>
> Have you tried contacting the maintainer ? (I noticed that Jason
> wasn't cc'd), just in case it isn't simply a use case problem and
> might be related to KGDB internals.
>
> KGDB
> P:      Jason Wessel
> M:      jason.wessel@windriver.com
>
> I've tested KGDBOC up to the 2.6.29 kernel and it worked fine
> on a series of 85xx boards. I haven't had a chance on 2.6.30-rcX
> yet, so something may have changed.
>
> >
> > Linux Kernel: 2.6.30-rc4
> > KGDB method : KGDBOC
> > Arch: PowerPC
> >
> > Note: Attached is the kernel config  used.
> >
> > Has anyone tested KGDBOC for Serial 8250, and the serial port has
> dependency
> > on OF_PLATFORM driver ?
> >
> > Here are the kernel config options:
> >
> > Device Drivers  --->
> >            Character devices  --->
> >                           Serial drivers  --->
> >                                                      <*> 8250/16550 and
> > compatible serial support
> >                                                      [*]   Console on
> > 8250/16550 and compatible serial port
> >                                                      (4) Number of
> > 8250/16550 serial ports to register at runtime
> >                                                      [ ] Extended
> 8250/16550
> > serial driver options
> >                                                      *** Non-8250 serial
> > port support ***
> >                                                      <*> Xilinx uartlite
> > serial port support
> >                                                      [*]   Support for
> > console on Xilinx uartlite serial port
> >                                                      < > Digi
> International
> > NEO PCI Support
> >                                                      <*> Serial port on
> Open
> > Firmware platform bus
> >                                                      < > NWP serial port
> > driver
> >
> > Kernel hacking  --->
> >            -*- Magic SysRq key
> >                             [*] Kernel debugging
> >                             [*] KGDB: kernel debugging with remote gdb
> --->
> >                             --- KGDB: kernel debugging with remote
> > gdb
> >                            <*> KGDB: use kgdb over the serial console
> >
> >
> > ----------------------------------------------
> > In the process :
> >
> >     On the target side :
> >
> >                              ...............
> >                              Serial: 8250/16550 driver, 4 ports, IRQ
> sharing
> > disabled
> >                              83e00000.serial: ttyS0 at MMIO 0x83e01003
> (irq
> > = 16) is a
> > 16550A
> >                              console [ttyS0]
> > enabled
> >                              kgdb: Registered I/O driver kgdboc.
> >                              .................
> >
> >                             root@10.161.2.35:~# echo g >
> /proc/sysrq-trigger
> >                             SysRq : GDB
> >                             Entering KGDB
> >
> >
> >   On host side :
> >
> >                            [root@srikant linux-2.6]#
> powerpc-linux-gnu-gdb
> > vmlinux-puru
> >                            GNU gdb G++ 4.3-150) 6.8.50.20081022-cvs
> >                            Copyright (C) 2008 Free Software Foundation,
> Inc.
> >                            License GPLv3+: GNU GPL version 3 or later
> > <http://gnu.org/licenses/gpl.html>
> >                            This is free software: you are free to change
> and
> > redistribute it.
> >                            There is NO WARRANTY, to the extent permitted
> by
> > law.  Type "show copying"
> >                            and "show warranty" for details.
> >                            This GDB was configured as
> > "--host=i686-pc-linux-gnu --target=powerpc-linux-gnu".
> >                            For bug reporting instructions, please see:
> >                           (gdb) set remotebaud 9600
> >                           (gdb) target remote /dev/ttyS0
> >                            Remote debugging using /dev/ttyS0
> >                           Ignoring packet error, continuing...
> >                           warning: unrecognized item "timeout" in
> > "qSupported" response
> >                           Ignoring packet error, continuing...
> >                           Ignoring packet error, continuing...
> >                           Ignoring packet error, continuing...
> >                           Ignoring packet error, continuing...
> >                           Ignoring packet error, continuing...
> >                           Malformed response to offset query, timeout
>
> I'm wondering if there is a GDB protocol mismatch and your
> version of GDB is sending packets that KGDB can't handle.
> I'm no where near an expert on GDB's protocol and won't know
> if I'm seeing the same thing until I try 2.6.30-rc
>
> Bruce
>
> >
> > Can anybody comment on the steps followed in the process of testing or
> > something is missing with respect to of_serial.c for powerpc
> architecture.
> > Seems the target has never responded for gdb requests !!!
> >
> >
> > Regards
> > Srikanth
> >
> >
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
>
>
>
> --
> "Thou shalt not follow the NULL pointer, for chaos and madness await
> thee at its end"
>



-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--000e0cd14ed894ddc2046926ff1d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br><font size=3D"1">Target : PowerPC, Virtex-440 Generic </font=
><br><font size=3D"1">Serial port : Xilinx 16550 Uart ( depends on OF_PLATF=
ORM</font>)<br><br>Further investigation of KGDBOC on PowerPC shows that kg=
dboc hangs at :<br>
<br>In file : <span style=3D"background-color: rgb(204, 204, 204);">arch/po=
werpc/include/asm/kgdb.h</span><br><br><b><span style=3D"color: rgb(0, 153,=
 0);">static inline void</span></b> arch_kgdb_breakpoint(<b><span style=3D"=
color: rgb(0, 102, 0);">void</span></b>)<br>
{<br>=A0=A0=A0=A0=A0=A0=A0 <b style=3D"color: rgb(255, 153, 0);">asm</b>(<b=
><span style=3D"color: rgb(153, 51, 153);">&quot;.long 0x7d821008&quot;</sp=
an></b>); /* <b><span style=3D"color: rgb(51, 153, 153);">twge r2, r2 </spa=
n></b>*/=A0=A0=A0=A0=A0<b style=3D"color: rgb(255, 0, 0);"> &lt;&lt; ---- K=
GDBOC Hangs here</b>=A0<b style=3D"color: rgb(255, 0, 0);"> &lt;&lt; ---</b=
><br>
<br><br>-----------------------------------------<br><span style=3D"backgro=
und-color: rgb(204, 204, 204);">Debug Log:</span><br style=3D"background-co=
lor: rgb(204, 204, 204);"><br><span style=3D"color: rgb(51, 51, 51);">root@=
10.1.2.55:~# echo g &gt; /proc/sysrq-trigger=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"col=
or: rgb(51, 51, 51);">
<span style=3D"color: rgb(51, 51, 51);">SysRq : GDB=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 </span><br style=3D"color: rgb(51, 51, 51);"><span style=
=3D"color: rgb(51, 51, 51);">1------------------------&gt;sysrq_handle_gdb=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 </span><br style=3D"color: rgb(51, 51, 51);">
<span style=3D"color: rgb(51, 51, 51);">Entering KGDB=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 </span><br style=3D"color: rgb(51, 51, 51);"><span style=3D"color=
: rgb(51, 51, 51);">1-1-----------------------&gt;kgdb_breakpoint=A0=A0=A0=
=A0=A0=A0 </span><br style=3D"color: rgb(51, 51, 51);">
<span style=3D"color: rgb(51, 51, 51);">1-2-----------------------&gt;kgdb_=
breakpoint=A0=A0=A0=A0=A0=A0 </span><br style=3D"color: rgb(51, 51, 51);"><=
span style=3D"color: rgb(51, 51, 51);">1-3-----------------------&gt;kgdb_b=
reakpoint=A0=A0=A0=A0=A0=A0 </span><br style=3D"color: rgb(51, 51, 51);">
<span style=3D"color: rgb(51, 51, 51);">1-1-----------------------&gt;arch_=
kgdb_breakpoint=A0 </span><br><br>-----------------------------------------=
----<br><br><br>Any comments or suggestions ????<br><br>-Srikanth<br>------=
----<br>
<br><div class=3D"gmail_quote">On Mon, May 4, 2009 at 8:12 PM, Bruce Ashfie=
ld <span dir=3D"ltr">&lt;<a href=3D"mailto:bruce.ashfield@gmail.com">bruce.=
ashfield@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">
<div class=3D"im">On Mon, May 4, 2009 at 9:13 AM, srikanth krishnakar<br>
&lt;<a href=3D"mailto:skrishnakar@gmail.com">skrishnakar@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I need help in kgdboc=A0 testing on PowerPC target.<br>
<br>
</div>Have you tried contacting the maintainer ? (I noticed that Jason<br>
wasn&#39;t cc&#39;d), just in case it isn&#39;t simply a use case problem a=
nd<br>
might be related to KGDB internals.<br>
<br>
KGDB<br>
P: =A0 =A0 =A0Jason Wessel<br>
M: =A0 =A0 =A0<a href=3D"mailto:jason.wessel@windriver.com">jason.wessel@wi=
ndriver.com</a><br>
<br>
I&#39;ve tested KGDBOC up to the 2.6.29 kernel and it worked fine<br>
on a series of 85xx boards. I haven&#39;t had a chance on 2.6.30-rcX<br>
yet, so something may have changed.<br>
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; Linux Kernel: 2.6.30-rc4<br>
&gt; KGDB method : KGDBOC<br>
&gt; Arch: PowerPC<br>
&gt;<br>
&gt; Note: Attached is the kernel config=A0 used.<br>
&gt;<br>
&gt; Has anyone tested KGDBOC for Serial 8250, and the serial port has depe=
ndency<br>
&gt; on OF_PLATFORM driver ?<br>
&gt;<br>
&gt; Here are the kernel config options:<br>
&gt;<br>
&gt; Device Drivers=A0 ---&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Character devices=A0 ---&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Serial drivers=A0 =
---&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 &lt;*&gt; 8250/16550 and<br>
&gt; compatible serial support<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 [*]=A0=A0 Console on<br>
&gt; 8250/16550 and compatible serial port<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (4) Number of<br>
&gt; 8250/16550 serial ports to register at runtime<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [ ] Extended 82=
50/16550<br>
&gt; serial driver options<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *** Non-825=
0 serial<br>
&gt; port support ***<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 &lt;*&gt; Xil=
inx uartlite<br>
&gt; serial port support<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 [*]=A0=A0 Sup=
port for<br>
&gt; console on Xilinx uartlite serial port<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &lt; &gt; Digi International<br>
&gt; NEO PCI Support<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 &lt;*&gt; Serial port on=
 Open<br>
&gt; Firmware platform bus<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &l=
t; &gt; NWP serial port<br>
&gt; driver<br>
&gt;<br>
&gt; Kernel hacking=A0 ---&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 -*- Magic SysRq key<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [*] Ke=
rnel debugging<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 [*] KGDB: kernel debugging with remote gdb=A0 ---&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 --- KGDB: kernel debugging with remote<br>
&gt; gdb<br>
&gt; =A0=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 &lt;*&gt; KGDB: use kgdb over the serial console<br>
&gt;<br>
&gt;<br>
&gt; ----------------------------------------------<br>
&gt; In the process :<br>
&gt;<br>
&gt; =A0=A0=A0 On the target side :<br>
&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ...............<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 Serial: 8250/16550 driver, 4 ports, IRQ sharing<br>
&gt; disabled<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 83e00000.serial: ttyS0 at MMIO 0x83e01003 (irq<br>
&gt; =3D 16) is a<br>
&gt; 16550A<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 console [ttyS0]<br>
&gt; enabled<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 kgdb: Registered I/O driver kgdboc.<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 .................<br>
&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 root@10.161.2.35:~# echo g &gt; /proc/sysrq-trigger<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 SysRq : GDB<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 Entering KGDB<br>
&gt;<br>
&gt;<br>
&gt; =A0 On host side :<br>
&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 [root@srikant linux-2.6]# powerpc-linux-gnu-gdb<br>
&gt; vmlinux-puru<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 GNU gdb G++ 4.3-150) 6.8.50.20081022-cvs<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Copyright (C) 2008 Free Software Foundation, Inc.<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 License GPLv3+: GNU GPL version 3 or later<br>
&gt; &lt;<a href=3D"http://gnu.org/licenses/gpl.html" target=3D"_blank">htt=
p://gnu.org/licenses/gpl.html</a>&gt;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 This is free software: you are free to change and<br>
&gt; redistribute it.<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 There is NO WARRANTY, to the extent permitted by<br>
&gt; law.=A0 Type &quot;show copying&quot;<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 and &quot;show warranty&quot; for details.<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 This GDB was configured as<br>
&gt; &quot;--host=3Di686-pc-linux-gnu --target=3Dpowerpc-linux-gnu&quot;.<b=
r>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 For bug reporting instructions, please see:<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 (gdb) set remotebaud 9600<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 (gdb) target remote /dev/ttyS0<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 Remote debugging using /dev/ttyS0<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Ignoring packet error, continuing...<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 warning: unrecognized item &quot;timeout&quot; in<br>
&gt; &quot;qSupported&quot; response<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Ignoring packet error, continuing...<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Ignoring packet error, continuing...<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Ignoring packet error, continuing...<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Ignoring packet error, continuing...<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Ignoring packet error, continuing...<br>
&gt; =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 Malformed response to offset query, timeout<br>
<br>
</div></div>I&#39;m wondering if there is a GDB protocol mismatch and your<=
br>
version of GDB is sending packets that KGDB can&#39;t handle.<br>
I&#39;m no where near an expert on GDB&#39;s protocol and won&#39;t know<br=
>
if I&#39;m seeing the same thing until I try 2.6.30-rc<br>
<br>
Bruce<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Can anybody comment on the steps followed in the process of testing or=
<br>
&gt; something is missing with respect to of_serial.c for powerpc architect=
ure.<br>
&gt; Seems the target has never responded for gdb requests !!!<br>
&gt;<br>
&gt;<br>
&gt; Regards<br>
&gt; Srikanth<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div>&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>=
<br>
&gt; <a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D=
"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
&gt;<br>
<font color=3D"#888888"><br>
<br>
<br>
--<br>
&quot;Thou shalt not follow the NULL pointer, for chaos and madness await<b=
r>
thee at its end&quot;<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;The Good Y=
ou Do, The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>****=
******************<br>

--000e0cd14ed894ddc2046926ff1d--
