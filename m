Return-Path: <hbausley@deltatau.com>
Received: from Barracuda.deltatau.com (barracuda.deltatau.com [76.79.246.10])
 by ozlabs.org (Postfix) with ESMTP id 552CD2C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 05:00:40 +1000 (EST)
From: "Henry Bausley" <hbausley@deltatau.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
 "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: Critical Interrupt Input
Date: Mon, 19 Aug 2013 12:00:25 -0700
Message-ID: <63d2635a$648939a4$b3aeac8$@deltatau.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----=_NextPart_000_0001_59684433.2E39B445"
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: hbausley@deltatau.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.

------=_NextPart_000_0001_59684433.2E39B445
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


Support does appear to be present but there is a problem returning back to 
user space I suspect.

What fails is it causes Linux user space programs to get Segmentation 
errors.
Issuing a simple ls causes a segmentation fault sometimes.  The shell gets 
terminated 
and you cannot log back in.  INIT: Id "T0" respawning too fast: disabled 
for 5 minutes pops up.

However, the critical interrupt handler keeps running.  I know this by 
adding the reading 
of a physical I/O location in the handler and can see it is being read on 
the scope.

The only code in the handler is below.

void critintr_handler(void *dev)
{
  critintrcount++;          // increment a variable
  iodata = *piom;           // read an I/O location 
  mtdcr(0x0c0, 0x00002000); // clear critical interrupt
}

Below is a log of the type of crashes that occur:

root@10.34.9.213:/opt/ppmac/ktest# ls
Segmentation fault
root@10.34.9.213:/opt/ppmac/ktest# ls
Segmentation fault
root@10.34.9.213:/opt/ppmac/ktest# ls
Makefile        ktest.c    ktest.ko     ktest.mod.o  modules.order
Module.symvers  ktest.cbp  ktest.mod.c  ktest.o
root@10.34.9.213:/opt/ppmac/ktest# ls

Debian GNU/Linux 7 powerpmac ttyS0

powerpmac login: root

Debian GNU/Linux 7 powerpmac ttyS0

powerpmac login: root

Debian GNU/Linux 7 powerpmac ttyS0

powerpmac login: root

Debian GNU/Linux 7 powerpmac ttyS0

powerpmac login: root
Password: 
Last login: Thu Nov 30 20:42:16 UTC 1933 on ttyS0
Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mon Aug 19 08:49:12 PDT 2013 ppc

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
INIT: Id "T0" respawning too fast: disabled for 5 minutes

----------------------------------------
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Sent: Saturday, August 17, 2013 3:05 PM
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, hbausley@deltatau.com
Subject: Re: Critical Interrupt Input

On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:
> The 44x low level code needs to handle exception stacks properly for
> this to work.  Since its possible to have a critical exception occur
> while in a normal exception level, you have to have proper saving of
> additional register state and a stack frame for the critical
> exception, etc.  I'm not sure if that was ever done for 44x.

Don't 44x and FSL BookE share the same macros ? I would think 44x does
indeed implement the same crit support as e500...

What does the crash look like ?

Ben.

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev




Outbound scan for Spam or Virus by Barracuda at Delta Tau


------=_NextPart_000_0001_59684433.2E39B445
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: Tahoma, Geneva, sans-serif; font-size: 10pt"><b=
r>Support does appear to be present but there is a problem returning back t=
o user space I suspect.<br><br>What fails is it causes Linux user space pro=
grams to get Segmentation errors.<br>Issuing a simple ls causes a segmentat=
ion fault sometimes.&nbsp; The shell gets terminated <br>and you cannot log=
 back in.&nbsp; INIT: Id "T0" respawning too fast: disabled for 5 minutes p=
ops up.<br><br>However, the critical interrupt handler keeps running.&nbsp;=
 I know this by adding the reading <br>of a physical I/O location in the ha=
ndler and can see it is being read on the scope.<br><br><br>The only code i=
n the handler is below.<br><br>void critintr_handler(void *dev)<br>{<br>&nb=
sp; critintrcount++;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
// increment a variable<br>&nbsp; iodata =3D *piom;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // read an I/O location <br>&nbsp; mtd=
cr(0x0c0, 0x00002000); // clear critical interrupt<br>}<br><br><br>Below is=
 a log of the type of crashes that occur:<br><br>root@10.34.9.213:/opt/ppma=
c/ktest# ls<br>
Segmentation fault<br>
root@10.34.9.213:/opt/ppmac/ktest# ls<br>Segmentation fault<br>root@10.34.9=
.213:/opt/ppmac/ktest# ls<br>Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; ktest.c&nbsp;&nbsp;&nbsp; ktest.ko&nbsp;&nbsp;&nbsp;&nbsp; ktest.mod.o=
&nbsp; modules.order<br>Module.symvers&nbsp; ktest.cbp&nbsp; ktest.mod.c&nb=
sp; ktest.o<br>root@10.34.9.213:/opt/ppmac/ktest# ls<br><br>Debian GNU/Linu=
x 7 powerpmac ttyS0<br><br>powerpmac login: root<br><br>Debian GNU/Linux 7 =
powerpmac ttyS0<br><br>powerpmac login: root<br><br>Debian GNU/Linux 7 powe=
rpmac ttyS0<br><br>powerpmac login: root<br><br>Debian GNU/Linux 7 powerpma=
c ttyS0<br><br>powerpmac login: root<br>Password: <br>Last login: Thu Nov 3=
0 20:42:16 UTC 1933 on ttyS0<br>Linux powerpmac 3.2.21-aspen_2.01.09 #10 Mo=
n Aug 19 08:49:12 PDT 2013 ppc<br><br>The programs included with the Debian=
 GNU/Linux system are free software;<br>the exact distribution terms for ea=
ch program are described in the<br>individual files in /usr/share/doc/*/cop=
yright.<br><br>Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the e=
xtent<br>permitted by applicable law.<br>INIT: Id "T0" respawning too fast:=
 disabled for 5 minutes<br><br><span style=3D"font-family: tahoma,arial,san=
s-serif; font-size: 10pt;"><hr size=3D"2" width=3D"100%" align=3D"center"><=
b>From</b>: "Benjamin Herrenschmidt" &lt;benh@kernel.crashing.org&gt;<br><b=
>Sent</b>: Saturday, August 17, 2013 3:05 PM<br><b>To</b>: "Kumar Gala" &lt=
;galak@kernel.crashing.org&gt;<br><b>Cc</b>: linuxppc-dev@lists.ozlabs.org,=
 hbausley@deltatau.com<br><b>Subject</b>: Re: Critical Interrupt Input</spa=
n><br><br>On Fri, 2013-08-16 at 06:04 -0500, Kumar Gala wrote:<br>&gt; The =
44x low level code needs to handle exception stacks properly for<br>&gt; th=
is to work.  Since its possible to have a critical exception occur<br>&gt; =
while in a normal exception level, you have to have proper saving of<br>&gt=
; additional register state and a stack frame for the critical<br>&gt; exce=
ption, etc.  I'm not sure if that was ever done for 44x.<br><br>Don't 44x a=
nd FSL BookE share the same macros ? I would think 44x does<br>indeed imple=
ment the same crit support as e500...<br><br>What does the crash look like =
?<br><br>Ben.<br><br><br>_______________________________________________<br=
>Linuxppc-dev mailing list<br>Linuxppc-dev@lists.ozlabs.org<br>https://list=
s.ozlabs.org/listinfo/linuxppc-dev<br><br></span>
<br>
&nbsp;&nbsp;&shy;&shy;&nbsp;&nbsp;=

------=_NextPart_000_0001_59684433.2E39B445--
