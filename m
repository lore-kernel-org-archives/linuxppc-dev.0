Return-Path: <mmeswani@utep.edu>
Received: from itdsrvmail02.utep.edu (itdsrvmail02.utep.edu [129.108.0.88])
	by ozlabs.org (Postfix) with ESMTP id E94E967B19
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 02:30:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C68986.74998C19"
Subject: Intercept System call using Kernel  module is 2.6 kernel
Date: Tue, 6 Jun 2006 10:25:08 -0600
Message-ID: <C26C730943E01145B4F89E37FE0A022002BBC7A6@itdsrvmail02.utep.edu>
References: <C26C730943E01145B4F89E37FE0A022002BBC7A2@itdsrvmail02.utep.edu>
From: "Meswani, Mitesh" <mmeswani@utep.edu>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68986.74998C19
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=20
=20
Hello=20
=20
=20
I am attempting to run some user code with kernel space permission. I am =
using the ppc64 kernel version 2.6.16-rc4-3-ppc64 for IBM Power5 =
processors.=20
In this kernel module I am trying to implement a function that can be =
called from user space.=20
=20
I have found through various posts that using unused system calls and =
replacing them temporarily can acheive this objective.=20
=20
This is what I am doing, but its not working, please bear with the =
slightly long code that follows:=20
=20
1) since the 2.6 kernel does not export sys_call_table, I grep it from =
the boot image
=20
2) Next I write the kernel module as :=20
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/syscalls.h>
unsigned long **sctable;
void *org_func;  /***** Copy of the original calls address ********/

asmlinkage int mitesh_func(void)  =20
{=20
        printk(KERN_ALERT "Executing mitesh_func...\n");=20
        return 2;
}=20

int init_module(void)
{
 unsigned long ptr;
 unsigned long *p;
 ptr =3D 0x23203404;  /*** some hard coded addresses from grepping for =
sys_call_table *****/
  p =3D (unsigned long *)ptr;
  sctable =3D (unsigned long **)p;
  printk("The address of the system call table is: 0x%x\n",&sctable[0]);
  printk("The address of syscall #137 is: 0x%x\n",sctable[137]);

org_func =3D (void *) (sctable[137]);  /**** Store the original sys call =
****/
 printk("Original func address 0x%x stored \n",org_func);
 sctable[137] =3D (void *) mitesh_func;  /**** replace with mitesh_func =
****/
printk("The new sys call address is 0x%x and stored as : =
0x%x\n",mitesh_func, sctable[137]);

  return 0;=20
}
void cleanup_module(void)

{
        sctable[137] =3D (void *) org_func;=20
        printk("Upon module unload the sctable #137 address is =
:0x%x\n",sctable[137]);
        printk("Module is unloaded!\n");
}

3) My user app looks like this:
#include <stdio.h>=20
#include <errno.h>=20
#include <asm-ppc64/unistd.h>=20
#define __NR_mitesh_func 137=20
=20
_syscall0(int, mitesh_func);=20
void main()=20
{
        int x=3D0;=20
        x=3Dmitesh_func();=20
        printf("mitesh_func returned %d\n",x);
} =20

=20
4) I verify from the system logs that when I insmod the kernel module I =
get all the print statements. I verified from the logs  that the address =
of the sys_call_table is correctly passed and from /proc/kallsysms I can =
see that my function mitesh_func has been defined and has the address as =
indicated in the logs.=20
=20
The problem is that when I execute my user app I expect to see two =
things:=20
 a) I should see a message in the log "Executing mitesh_func..." and=20
 b) A return value of 2=20
=20
However I get an error value -1 returned.=20
=20
Any help and ideas are highly appreciated. =20
=20
Thank you in advance,=20
Mitesh=20
=20

------_=_NextPart_001_01C68986.74998C19
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.5296.0" name=3DGENERATOR><BASE href=3DHEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText14380 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV></DIV>=0A=
<DIV id=3DidSignature28149 dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>=0A=
<DIV></FONT><FONT face=3DArial color=3D#000000 size=3D2>Hello =
</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 size=3D2>I am =
attempting to run some user code with kernel space permission. I am =
using the ppc64 kernel version 2.6.16-rc4-3-ppc64 for IBM Power5 =
processors. </FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2>In this kernel module I =
am trying to implement a function that can be called from user space. =
</FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT =
size=3D2></FONT></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2>I have found through =
various posts that using unused system calls and replacing them =
temporarily can acheive this objective. </FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT =
size=3D2></FONT></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#000000>This is what I am doing, but its not working, please =
bear with the slightly long code that follows: =
</FONT></FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#000000></FONT></FONT></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#000000>1) since the 2.6 kernel does not export sys_call_table, =
I grep it from the boot image</FONT></FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#000000></FONT></FONT></FONT><FONT face=3DArial><FONT =
size=3D2><FONT color=3D#000000></FONT></FONT></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#000000>2) Next I write the kernel module as : =
</FONT></FONT></FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial><FONT size=3D2><FONT =
color=3D#000000>#include &lt;linux/kernel.h&gt;<BR>#include =
&lt;linux/module.h&gt;<BR>#include &lt;linux/sched.h&gt;<BR>#include =
&lt;linux/syscalls.h&gt;<BR>unsigned long **sctable;<BR>void =
*org_func;&nbsp; /***** Copy of the original calls address =
********/<BR></FONT></FONT></FONT></DIV>=0A=
<DIV dir=3Dltr>asmlinkage int mitesh_func(void)&nbsp;&nbsp; <BR>{ =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk(KERN_ALERT =
"Executing mitesh_func...\n"); =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 2;<BR>} <BR></DIV>=0A=
<DIV dir=3Dltr>int init_module(void)<BR>{<BR>&nbsp;unsigned long =
ptr;<BR>&nbsp;unsigned long *p;<BR>&nbsp;ptr =3D 0x23203404;&nbsp; /*** =
some hard coded addresses from grepping for sys_call_table *****/</DIV>=0A=
<DIV dir=3Dltr>&nbsp; p =3D (unsigned long *)ptr;<BR>&nbsp; sctable =3D =
(unsigned long **)p;<BR>&nbsp; printk("The address of the system call =
table is: 0x%x\n",&amp;sctable[0]);<BR>&nbsp; printk("The address of =
syscall #137 is: 0x%x\n",sctable[137]);<BR></DIV>=0A=
<DIV dir=3Dltr>org_func =3D (void *) (sctable[137]);&nbsp; /**** Store =
the original sys call ****/<BR>&nbsp;printk("Original func address 0x%x =
stored \n",org_func);</DIV>=0A=
<DIV dir=3Dltr><PRE dir=3Dltr>&nbsp;sctable[137] =3D (void *) =
mitesh_func;&nbsp; /**** replace with mitesh_func ****/<BR></PRE></DIV>=0A=
<DIV dir=3Dltr>printk("The new sys call address is 0x%x and stored as : =
0x%x\n",mitesh_func, sctable[137]);<BR><BR>&nbsp; return 0; <BR>}</DIV>=0A=
<DIV dir=3Dltr>void cleanup_module(void)<BR></DIV>=0A=
<DIV dir=3Dltr>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sctable[137] =3D (void *) org_func; </DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printk("Upon =
module unload the sctable #137 address is =
:0x%x\n",sctable[137]);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printk("Module is unloaded!\n");<BR>}<BR></DIV>=0A=
<DIV dir=3Dltr>3) My user app looks like this:</DIV>=0A=
<DIV dir=3Dltr>#include &lt;stdio.h&gt; <BR>#include &lt;errno.h&gt; =
<BR>#include &lt;asm-ppc64/unistd.h&gt; <BR>#define __NR_mitesh_func 137 =
<BR>&nbsp;<BR>_syscall0(int, mitesh_func); </DIV>=0A=
<DIV dir=3Dltr>void main() =
<BR>{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int x=3D0; =
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; x=3Dmitesh_func(); </DIV>=0A=
<DIV dir=3Dltr>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
printf("mitesh_func returned %d\n",x);</DIV>=0A=
<DIV dir=3Dltr>}&nbsp; <BR></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>4) I verify from the system logs that when I insmod the =
kernel module I get all the print statements. I verified from the =
logs&nbsp; that the address of the sys_call_table is correctly passed =
and from /proc/kallsysms I can see that my function mitesh_func has been =
defined and has the address as indicated in the logs. </DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>The problem is that when I execute my user app I expect =
to see two things: </DIV>=0A=
<DIV dir=3Dltr>&nbsp;a) I should see a message in the log "Executing =
mitesh_func..." and </DIV>=0A=
<DIV dir=3Dltr>&nbsp;b) A return value of 2 </DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>However I get an error value <FONT =
color=3D#ff0000>-1</FONT> returned. </DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Any help and ideas are highly appreciated.&nbsp; </DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>Thank you in advance, </DIV>=0A=
<DIV dir=3Dltr>Mitesh </DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV></DIV></BODY></HTML>
------_=_NextPart_001_01C68986.74998C19--
