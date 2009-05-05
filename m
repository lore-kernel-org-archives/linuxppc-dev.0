Return-Path: <skrishnakar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4A0029E0.3000008@windriver.com>
References: <6213bc560905040417p48d3f12co608b885482998e06@mail.gmail.com>
	<6213bc560905040613q3cec9730idece67c1caf67112@mail.gmail.com>
	<3bd6b93c0905040742m64e1ef73i102106ca002236b2@mail.gmail.com>
	<6213bc560905050235l7fd05dfay9938d6600ab5339e@mail.gmail.com>
	<4A0029E0.3000008@windriver.com>
Date: Tue, 5 May 2009 18:29:14 +0530
Message-ID: <6213bc560905050559i80bacb7g97f26acb0fa03318@mail.gmail.com>
Subject: Re: [Kgdb-bugreport] KGDBOC testing on linux-2.6.30-rc4
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Jason Wessel <jason.wessel@windriver.com>
Content-Type: multipart/alternative; boundary=000e0cd175129311f8046929d85a
Cc: kgdb-bugreport@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd175129311f8046929d85a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, May 5, 2009 at 5:28 PM, Jason Wessel <jason.wessel@windriver.com>wrote:

> srikanth krishnakar wrote:
> > Hi all,
> >
> > Target : PowerPC, Virtex-440 Generic
> > Serial port : Xilinx 16550 Uart ( depends on OF_PLATFORM)
> >
> > Further investigation of KGDBOC on PowerPC shows that kgdboc hangs at :
> >
> > In file : arch/powerpc/include/asm/kgdb.h
> >
> > *static inline void* arch_kgdb_breakpoint(*void*)
> > {
> >         *asm*(*".long 0x7d821008"*); /* *twge r2, r2 **/     * << ----
> > KGDBOC Hangs here* * << ---*
> >
> >
> > -----------------------------------------
> > Debug Log:
> >
> > root@10.1.2.55:~# echo g >
> > /proc/sysrq-trigger
> > SysRq :
> > GDB
> >
> > 1------------------------>sysrq_handle_gdb
> >
> > Entering KGDB
> > 1-1----------------------->kgdb_breakpoint
> > 1-2----------------------->kgdb_breakpoint
> > 1-3----------------------->kgdb_breakpoint
> > 1-1----------------------->arch_kgdb_breakpoint
> >
> > ---------------------------------------------
> >
> >
> > Any comments or suggestions ????
> >
>
> I had used the 2.6.30-rc3 kernel with the PowerPC 604 system I have and
> it was working fine, but the 4xx archs are a bit different.
>
> What happens next after you execute the inline assembly is that an
> exception occurs, and that is the point that the kgdb entry will
> actually execute.  IE:
>
> arch/powerpc/kernel/traps.c
>
> program_check_exception()
>
> From there kgdb should be entered and the I/O driver gets activated.
> You could put another printk in kgdb_handle_exception() in kernel/kgdb.c
> to make sure it actually gets there.
>
> Generally when the system hangs hard on an initial entry to kgdb it
> means there is a problem with the I/O polling driver or there is
> something else eating the kgdb exception and the kgdb exception handler
> was never fired in the first place.
>
> Jason.
>

Hi Jason,

Re attempted with inserting a printk in kernel/kgdb.c
kgdb_handle_exception() function but seems the kgdb exception has never
occurred !!

------------------
Debug Log:

root@10.1.2.55:~# echo g > /proc/sysrq-trigger
SysRq : GDB
1------------------------>sysrq_handle_gdb
Entering KGDB
1-1----------------------->kgdb_breakpoint
1-2----------------------->kgdb_breakpoint
1-3----------------------->kgdb_breakpoint
1-1----------------------->arch_kgdb_breakpoint


(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
Ignoring packet error, continuing...
warning: unrecognized item "timeout" in "qSupported" response
Ignoring packet error, continuing...
Ignoring packet error, continuing...

-------------------

Inserted printk's in kernel kgdb.c  :
int
kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs
*regs)
{

printk("1------------------------>%s\n",__FUNCTION__);
        if (kgdb_reenter_check(ks)) {
-----------------------------

*Does the PowerPC uses PowerPC64 hooks ??*

as seen below from arch/powerpc/kernel/kgdb.c

/* KGDB functions to use existing PowerPC64 hooks. */
static int kgdb_debugger(struct pt_regs *regs)
{
        printk("1------------------------>%s\n",__FUNCTION__);
        return *kgdb_handle_exception*(0, computeSignal(TRAP(regs)), 0,
regs);

-------------------------------


Thanks For your co-operation, patience and help.


Regards
Srikanth
**********

--000e0cd175129311f8046929d85a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, May 5, 2009 at 5:28 PM, Jason We=
ssel <span dir=3D"ltr">&lt;<a href=3D"mailto:jason.wessel@windriver.com">ja=
son.wessel@windriver.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">srikanth krishnakar wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Target : PowerPC, Virtex-440 Generic<br>
&gt; Serial port : Xilinx 16550 Uart ( depends on OF_PLATFORM)<br>
&gt;<br>
&gt; Further investigation of KGDBOC on PowerPC shows that kgdboc hangs at =
:<br>
&gt;<br>
&gt; In file : arch/powerpc/include/asm/kgdb.h<br>
&gt;<br>
&gt; *static inline void* arch_kgdb_breakpoint(*void*)<br>
&gt; {<br>
&gt; =A0 =A0 =A0 =A0 *asm*(*&quot;.long 0x7d821008&quot;*); /* *twge r2, r2=
 **/ =A0 =A0 * &lt;&lt; ----<br>
&gt; KGDBOC Hangs here* * &lt;&lt; ---*<br>
&gt;<br>
&gt;<br>
&gt; -----------------------------------------<br>
&gt; Debug Log:<br>
&gt;<br>
&gt; root@10.1.2.55:~# echo g &gt;<br>
&gt; /proc/sysrq-trigger<br>
&gt; SysRq :<br>
&gt; GDB<br>
&gt;<br>
&gt; 1------------------------&gt;sysrq_handle_gdb<br>
&gt;<br>
&gt; Entering KGDB<br>
&gt; 1-1-----------------------&gt;kgdb_breakpoint<br>
&gt; 1-2-----------------------&gt;kgdb_breakpoint<br>
&gt; 1-3-----------------------&gt;kgdb_breakpoint<br>
&gt; 1-1-----------------------&gt;arch_kgdb_breakpoint<br>
&gt;<br>
&gt; ---------------------------------------------<br>
&gt;<br>
&gt;<br>
&gt; Any comments or suggestions ????<br>
&gt;<br>
<br>
</div>I had used the 2.6.30-rc3 kernel with the PowerPC 604 system I have a=
nd<br>
it was working fine, but the 4xx archs are a bit different.<br>
<br>
What happens next after you execute the inline assembly is that an<br>
exception occurs, and that is the point that the kgdb entry will<br>
actually execute. =A0IE:<br>
<br>
arch/powerpc/kernel/traps.c<br>
<br>
program_check_exception()<br>
<br>
>From there kgdb should be entered and the I/O driver gets activated.<br>
You could put another printk in kgdb_handle_exception() in kernel/kgdb.c<br=
>
to make sure it actually gets there.<br>
<br>
Generally when the system hangs hard on an initial entry to kgdb it<br>
means there is a problem with the I/O polling driver or there is<br>
something else eating the kgdb exception and the kgdb exception handler<br>
was never fired in the first place.<br>
<font color=3D"#888888"><br>
Jason.<br>
</font></blockquote></div><br>Hi Jason,<br><br>Re attempted with inserting =
a printk in kernel/kgdb.c kgdb_handle_exception() function but seems the kg=
db exception has never occurred !!<br><br>------------------<br><span style=
=3D"background-color: rgb(204, 204, 204);">Debug Log:</span><br>
<br><font size=3D"1">root@10.1.2.55:~# echo g &gt; /proc/sysrq-trigger<br>S=
ysRq : GDB<br>1------------------------&gt;sysrq_handle_gdb<br>Entering KGD=
B<br>1-1-----------------------&gt;kgdb_breakpoint<br>1-2------------------=
-----&gt;kgdb_breakpoint<br>
1-3-----------------------&gt;kgdb_breakpoint<br>1-1-----------------------=
&gt;arch_kgdb_breakpoint<br><br><br>(gdb) target remote /dev/ttyS0<br>Remot=
e debugging using /dev/ttyS0<br>Ignoring packet error, continuing...<br>
warning: unrecognized item &quot;timeout&quot; in &quot;qSupported&quot; re=
sponse<br>Ignoring packet error, continuing...<br>Ignoring packet error, co=
ntinuing...</font><br><br>-------------------<br><br><span style=3D"backgro=
und-color: rgb(204, 204, 204);">Inserted printk&#39;s in kernel kgdb.c=A0 :=
</span><br>
<font size=3D"1">int<br><span style=3D"color: rgb(153, 0, 0);">kgdb_handle_=
exception(int evector, int signo, int ecode, struct pt_regs *regs)</span><b=
r style=3D"color: rgb(153, 0, 0);"><span style=3D"color: rgb(153, 0, 0);">{=
</span><br style=3D"color: rgb(153, 0, 0);">
<br style=3D"color: rgb(153, 0, 0);"><span style=3D"color: rgb(153, 0, 0);"=
>printk(&quot;1------------------------&gt;%s\n&quot;,__FUNCTION__);</span>=
<br style=3D"color: rgb(153, 0, 0);"><span style=3D"color: rgb(153, 0, 0);"=
>=A0=A0=A0=A0=A0=A0=A0 if (kgdb_reenter_check(ks)) {</span></font><br>
-----------------------------<br><br><b><span style=3D"color: rgb(255, 0, 0=
);">Does the PowerPC uses PowerPC64 hooks ??</span></b><br style=3D"color: =
rgb(255, 0, 0);"><br>as seen below from arch/powerpc/kernel/kgdb.c<br><br><=
span style=3D"color: rgb(153, 0, 0);">/* KGDB functions to use existing Pow=
erPC64 hooks. */</span><br style=3D"color: rgb(153, 0, 0);">
<span style=3D"color: rgb(153, 0, 0);">static int kgdb_debugger(struct pt_r=
egs *regs)</span><br style=3D"color: rgb(153, 0, 0);"><span style=3D"color:=
 rgb(153, 0, 0);">{</span><br style=3D"color: rgb(153, 0, 0);"><span style=
=3D"color: rgb(153, 0, 0);">=A0=A0=A0=A0=A0=A0=A0 printk(&quot;1-----------=
-------------&gt;%s\n&quot;,__FUNCTION__);</span><br style=3D"color: rgb(15=
3, 0, 0);">
<span style=3D"color: rgb(153, 0, 0);">=A0=A0=A0=A0=A0=A0=A0 return <b><spa=
n style=3D"color: rgb(0, 0, 0);">kgdb_handle_exception</span></b>(0, comput=
eSignal(TRAP(regs)), 0, regs);</span><br><br>------------------------------=
-<br><br><br>Thanks For your co-operation, patience and help.<br>
<br><br>Regards<br>Srikanth <br>**********<br>

--000e0cd175129311f8046929d85a--
