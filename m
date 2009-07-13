Return-Path: <skrishnakar@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 62237B6F35
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 01:46:35 +1000 (EST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40907130802h3a6875f7gf21d41974974a7e4@mail.gmail.com>
References: <6213bc560907130016n2f2d5066t3dc88032200da8ef@mail.gmail.com>
	<fa686aa40907130802h3a6875f7gf21d41974974a7e4@mail.gmail.com>
Date: Mon, 13 Jul 2009 21:09:55 +0530
Message-ID: <6213bc560907130839t36e28d5fr34191ccb290c9cf8@mail.gmail.com>
Subject: Re: Soft Reset for PPC44x Virtex 5 hangs saying Restarting System
From: srikanth krishnakar <skrishnakar@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: multipart/alternative; boundary=001636e90f20418f7d046e98229b
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001636e90f20418f7d046e98229b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Jul 13, 2009 at 8:32 PM, Grant Likely <grant.likely@secretlab.ca>wrote:

> On Mon, Jul 13, 2009 at 1:16 AM, srikanth
> krishnakar<skrishnakar@gmail.com> wrote:
> > Hi all,
> >
> > Kernel : Linux-2.6.29
> > Arch: Powerpc (ppc44x)
> > Target: Xilinx ML507 Virtex5
> >
> > I have an issue in "Reset System" of Xilinx ML507 target board. I am
> using
> > Compact Flash to boot the target ( using system ACE file to boot the
> > target), during the process reset or reboot command on the target, I am
> not
> > able to reboot the target completely, here is the snapshot:
>
> Where is your boot code located?  In BRAM?  or SDRAM?


It is located in BRAM.


>  If it is in
> RAM, then it is likely that your boot code gets overwritten when the
> Linux kernel boots and so soft resetting the processor will result in
> a hung system (because it doesn't have any boot code to run).
>
> >
> -----------------------------------------------------------------------------------------------------
> >
> > The target again doesn't provide me the boot options as obtained when
> done
> > hard reset :
>
> What boot options are you referring to?


Boot options: console=ttyS0,9600 ip=bootp root=/dev/nfs rw


>  SystemACE boot configuration?


Yes. I have created SystemACE file using XMD to boot the target, I place
system.ace file in compact flash with rootfs NFS,

I see current ppc4xx_reset_system has been set to : DBCR_RST_SYSTEM  so that
is system reset but leaves the FPGA still programmed, I tried writing
DBCR_RST_CORE to DBCR0 that leads to segmentation fault as ;

void ppc4xx_reset_system(char *cmd)
{
        mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_RST_SYSTEM);  << Tried
using DBCR0_RST_CORE
        while (1)
                ;       /* Just in case the reset doesn't work */
}

--------------------------------------------------------------

root@xilinx-ml507:~# reboot

INIT: Sending processes the TERM signal
INIT: Stopping OpenBSD Secure Shell server: sshdstopped /usr/sbin/sshd (pid
105)
.
Stopping Vixie-cron.
Stopping network benchmark server: netserverstopped /usr/sbin/netserver (pid
10)
.
Stopping syslogd/klogd: stopped syslogd (pid 1060)
stopped klogd (pid 1062)
done
NOT deconfiguring network interfaces: / is an NFS mount
Sending all processes the TERM signal...
Sending all processes the KILL signal...
hwclock: can't open '/dev/misc/rtc': No such file or directory
Unmounting remote filesystems...
Deactivating swap...
/etc/rc6.d/S40umountfs: line 9: swapoff: not found
Unmounting local filesystems...
umount2: Device or resource busy
umount: none busy - remounted read-only
Rebooting... Restarting system.
Oops: Exception in kernel mode, sig: 11 [#1]
PREEMPT LTT NESTING LEVEL : 0
Xilinx Virtex440
Modules linked in: nls_iso8859_1 ipv6
NIP: fffffffc LR: c000d14c CTR: c0018b64
REGS: cf373d50 TRAP: 0700   Not tainted  (2.6.29.6)
MSR: 00000000 <>  CR: 22444428  XER: 20000001
TASK = cf9acbf0[1101] 'reboot' THREAD: cf372000
GPR00: 50000000 cf373e00 cf9acbf0 00000000 000018ef ffffffff c026493c
00004000
GPR08: c04a5c8c c04a0000 00003fff 000018ef 22444422 1001a5a0 00008000
ffffffff
GPR16: 00000000 00000000 10000000 00000004 00000001 00000000 00000000
00000001
GPR24: 01230000 00000001 00000000 00000000 00000000 01234567 28121969
00000000
NIP [fffffffc] 0xfffffffc
LR [c000d14c] machine_restart+0x34/0x48
Call Trace:
[cf373e00] [c000d130] machine_restart+0x18/0x48 (unreliable)
[cf373e10] [c0046530] kernel_restart+0x34/0x5c
[cf373e20] [c0046684] sys_reboot+0x124/0x1a4
[cf373f40] [c000e164] ret_from_syscall+0x0/0x3c
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
---[ end trace 51d087d0d6d3d0e5 ]---
Segmentation fault
----------------------------------------------------------------------------------

How can I reboot the system, while resetting the FPGA core completely ?


> The current system ace driver doesn't have any support for either
> setting the boot options or using the systemace to reboot the system
> by reconfiguring the FPGA.  It shouldn't be hard to do, it just hasn't
> been written.
>
> g.
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>

Thanks for you patience !

-Srikanth


-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--001636e90f20418f7d046e98229b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jul 13, 2009 at 8:32 PM, Grant L=
ikely <span dir=3D"ltr">&lt;<a href=3D"mailto:grant.likely@secretlab.ca">gr=
ant.likely@secretlab.ca</a>&gt;</span> wrote:<br><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Mon, Jul 13, 2009 at 1:16 AM, srikanth<br>
krishnakar&lt;<a href=3D"mailto:skrishnakar@gmail.com">skrishnakar@gmail.co=
m</a>&gt; wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Kernel : Linux-2.6.29<br>
&gt; Arch: Powerpc (ppc44x)<br>
&gt; Target: Xilinx ML507 Virtex5<br>
&gt;<br>
&gt; I have an issue in &quot;Reset System&quot; of Xilinx ML507 target boa=
rd. I am using<br>
&gt; Compact Flash to boot the target ( using system ACE file to boot the<b=
r>
&gt; target), during the process reset or reboot command on the target, I a=
m not<br>
&gt; able to reboot the target completely, here is the snapshot:<br>
<br>
</div>Where is your boot code located? =A0In BRAM? =A0or SDRAM? </blockquot=
e><div><br>It is located in BRAM.<br>=A0<br></div><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
=A0If it is in<br>
RAM, then it is likely that your boot code gets overwritten when the<br>
Linux kernel boots and so soft resetting the processor will result in<br>
a hung system (because it doesn&#39;t have any boot code to run).<br>
<div class=3D"im"><br>
&gt; ----------------------------------------------------------------------=
-------------------------------<br>
&gt;<br>
&gt; The target again doesn&#39;t provide me the boot options as obtained w=
hen done<br>
&gt; hard reset :<br>
<br>
</div>What boot options are you referring to? </blockquote><div><br>Boot op=
tions: console=3DttyS0,9600 ip=3Dbootp root=3D/dev/nfs rw <br>=A0<br></div>=
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
=A0SystemACE boot configuration?</blockquote><div><br>Yes. I have created S=
ystemACE file using XMD to boot the target, I place system.ace file in comp=
act flash with rootfs NFS, <br><br>I see current ppc4xx_reset_system has be=
en set to : DBCR_RST_SYSTEM=A0 so that is system reset but leaves the FPGA =
still programmed, I tried writing DBCR_RST_CORE to DBCR0 that leads to segm=
entation fault as ;<br>
<br>void ppc4xx_reset_system(char *cmd)<br>{<br>=A0=A0=A0=A0=A0=A0=A0 mtspr=
(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_RST_SYSTEM);=A0 <span style=3D"color=
: rgb(204, 0, 0);">&lt;&lt; <span style=3D"color: rgb(0, 0, 0);">Tried usin=
g</span> DBCR0_RST_CORE</span><br>
=A0=A0=A0=A0=A0=A0=A0 while (1)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 ;=A0=A0=A0=A0=A0=A0 /* Just in case the reset doesn&#39;t work */<br=
>}<br><br>--------------------------------------------------------------<br=
><br>root@xilinx-ml507:~# reboot<br><br>INIT: Sending processes the TERM si=
gnal<br>
INIT: Stopping OpenBSD Secure Shell server: sshdstopped /usr/sbin/sshd (pid=
 105)<br>.<br>Stopping Vixie-cron.<br>Stopping network benchmark server: ne=
tserverstopped /usr/sbin/netserver (pid 10)<br>.<br>Stopping syslogd/klogd:=
 stopped syslogd (pid 1060)<br>
stopped klogd (pid 1062)<br>done<br>NOT deconfiguring network interfaces: /=
 is an NFS mount<br>Sending all processes the TERM signal...<br>Sending all=
 processes the KILL signal...<br>hwclock: can&#39;t open &#39;/dev/misc/rtc=
&#39;: No such file or directory<br>
Unmounting remote filesystems...<br>Deactivating swap...<br>/etc/rc6.d/S40u=
mountfs: line 9: swapoff: not found<br>Unmounting local filesystems...<br>u=
mount2: Device or resource busy<br>umount: none busy - remounted read-only<=
br>
Rebooting... Restarting system.<br>Oops: Exception in kernel mode, sig: 11 =
[#1]<br>PREEMPT LTT NESTING LEVEL : 0 <br>Xilinx Virtex440<br>Modules linke=
d in: nls_iso8859_1 ipv6<br>NIP: fffffffc LR: c000d14c CTR: c0018b64<br>
REGS: cf373d50 TRAP: 0700=A0=A0 Not tainted=A0 (2.6.29.6)<br>MSR: 00000000 =
&lt;&gt;=A0 CR: 22444428=A0 XER: 20000001<br>TASK =3D cf9acbf0[1101] &#39;r=
eboot&#39; THREAD: cf372000<br>GPR00: 50000000 cf373e00 cf9acbf0 00000000 0=
00018ef ffffffff c026493c 00004000 <br>
GPR08: c04a5c8c c04a0000 00003fff 000018ef 22444422 1001a5a0 00008000 fffff=
fff <br>GPR16: 00000000 00000000 10000000 00000004 00000001 00000000 000000=
00 00000001 <br>GPR24: 01230000 00000001 00000000 00000000 00000000 0123456=
7 28121969 00000000 <br>
NIP [fffffffc] 0xfffffffc<br>LR [c000d14c] machine_restart+0x34/0x48<br>Cal=
l Trace:<br>[cf373e00] [c000d130] machine_restart+0x18/0x48 (unreliable)<br=
>[cf373e10] [c0046530] kernel_restart+0x34/0x5c<br>[cf373e20] [c0046684] sy=
s_reboot+0x124/0x1a4<br>
[cf373f40] [c000e164] ret_from_syscall+0x0/0x3c<br>Instruction dump:<br>XXX=
XXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <br>XX=
XXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX <br>
---[ end trace 51d087d0d6d3d0e5 ]---<br>Segmentation fault<br>-------------=
---------------------------------------------------------------------<br><b=
r>How can I reboot the system, while resetting the FPGA core completely ?<b=
r>
<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid=
 rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
The current system ace driver doesn&#39;t have any support for either<br>
setting the boot options or using the systemace to reboot the system<br>
by reconfiguring the FPGA. =A0It shouldn&#39;t be hard to do, it just hasn&=
#39;t<br>
been written.<br>
<br>
g.<br>
<font color=3D"#888888"><br>
--<br>
Grant Likely, B.Sc., P.Eng.<br>
Secret Lab Technologies Ltd.<br>
</font></blockquote></div><br>Thanks for you patience !<br><br>-Srikanth<br=
><br clear=3D"all"><br>-- <br>&quot;The Good You Do, The Best You GET&quot;=
<br><br>Regards<br>Srikanth Krishnakar<br>**********************<br>

--001636e90f20418f7d046e98229b--
