Return-Path: <saysai.gajula@gmail.com>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC7B82C0151
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 15:04:12 +1000 (EST)
Received: by mail-vc0-f174.google.com with SMTP id kw10so1025965vcb.33
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:04:10 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 17 Apr 2013 10:34:10 +0530
Message-ID: <CAGstqXHrHWdiE=RvZ=1sV+=mPd9LiUZHL0gHPa89AVZRSND2Tg@mail.gmail.com>
Subject: PowerPC, P2020RDB, application debug when the application is in tight
 loop, Sysrq
From: saikrishna gajula <saysai.gajula@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=20cf307c9b6a92144c04da876ad6
Cc: mikey@neuling.org, linux-kernel@vger.kernel.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf307c9b6a92144c04da876ad6
Content-Type: text/plain; charset=ISO-8859-1

HI All,

             I am new to this group. I am working on Freescale P2020
platform running linux 2.6.21.   I am looking for debug mechanism/utility,
when a multi threaded application running on linux , appears to be hung (
running in a tight loop,deadlock)  while not able to access the board
through serial/SSH/Telnet.

   I was looking at Magic sysrq option in linux to generate the stack,
register dump when the application is hung. I am able to dump the call
trace in normal working conditions. But i can't use  echo  t >
/proc/sysrq-trigger and debug when the application hung.

 I am using below piece of code(drivers/serial/8250.c) on P2020RDB to debug
the application where in , in hung situation, when i press 'y'  followed by
't'  on serial console it should go to sysrq handler, and dump the call
trace, but it is not happening.(simply board hung)

{
           if(sysrq_enable_flag)
                  handle_sysrq(ch, up->port.info->tty);

        sysrq_enable_flag = 0;

        if(ch == 'y')
            sysrq_enable_flag = 1;
}

It would be helpful if you provide any hint on the issue, or any other way
to debug the application in hang situations.

Thanks,
Sai


On Tue, Apr 16, 2013 at 9:24 PM, Anshuman Khandual <
khandual@linux.vnet.ibm.com> wrote:

>                 Branch History Rolling Buffer (BHRB) is a new PMU feaure
> in IBM
> POWER8 processor which records the branch instructions inside the execution
> pipeline. This patchset enables the basic functionality of the feature
> through
> generic perf branch stack sampling framework.
>
> Sample output
> -------------
> $./perf record -b top
> $./perf report
>
> Overhead  Command  Source Shared Object                           Source
> Symbol  Target Shared Object                        Target Symbol
> # ........  .......  ....................
>  ......................................  ....................
>  ...................................
> #
>
>      7.82%      top  libc-2.11.2.so        [k] _IO_vfscanf
>           libc-2.11.2.so        [k] _IO_vfscanf
>      6.17%      top  libc-2.11.2.so        [k] _IO_vfscanf
>           [unknown]             [k] 00000000
>      2.37%      top  [unknown]             [k] 0xf7aafb30
>          [unknown]             [k] 00000000
>      1.80%      top  [unknown]             [k] 0x0fe07978
>          libc-2.11.2.so        [k] _IO_vfscanf
>      1.60%      top  libc-2.11.2.so        [k] _IO_vfscanf
>           [kernel.kallsyms]     [k] .do_task_stat
>      1.20%      top  [kernel.kallsyms]     [k] .do_task_stat
>         [kernel.kallsyms]     [k] .do_task_stat
>      1.02%      top  libc-2.11.2.so        [k] vfprintf
>          libc-2.11.2.so        [k] vfprintf
>      0.92%      top  top                   [k] _init
>         [unknown]             [k] 0x0fe037f4
>
> Changes in V2
> --------------
> - Added copyright messages to the newly created files
> - Modified couple of commit messages
>
> Anshuman Khandual (5):
>   powerpc, perf: Add new BHRB related instructions on POWER8
>   powerpc, perf: Add basic assembly code to read BHRB entries on POWER8
>   powerpc, perf: Add new BHRB related generic functions, data and flags
>   powerpc, perf: Define BHRB generic functions, data and flags for POWER8
>   powerpc, perf: Enable branch stack sampling framework support with BHRB
>
>  arch/powerpc/include/asm/perf_event_server.h |  6 ++
>  arch/powerpc/include/asm/ppc-opcode.h        |  7 ++
>  arch/powerpc/perf/Makefile                   |  2 +-
>  arch/powerpc/perf/bhrb.S                     | 44 +++++++++++++
>  arch/powerpc/perf/core-book3s.c              | 96
> +++++++++++++++++++++++++++-
>  arch/powerpc/perf/perf_event_bhrb.c          | 85 ++++++++++++++++++++++++
>  arch/powerpc/perf/power8-pmu.c               | 57 ++++++++++++++++-
>  7 files changed, 292 insertions(+), 5 deletions(-)
>  create mode 100644 arch/powerpc/perf/bhrb.S
>  create mode 100644 arch/powerpc/perf/perf_event_bhrb.c
>
> --
> 1.7.11.7
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>

--20cf307c9b6a92144c04da876ad6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>HI All,<br><br></div>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 I am new to this group.
 I am working on Freescale P2020 platform running linux 2.6.21.=A0=A0 I am=
=20
looking for debug mechanism/utility, when a multi threaded application=20
running on linux , appears to be hung ( running in a tight loop,deadlock)=
=A0 while not
 able to access the board through serial/SSH/Telnet.<br><br></div>=A0=A0 I=
=20
was looking at Magic sysrq option in linux to generate the stack,=20
register dump when the application is hung. I am able to dump the call=20
trace in normal working conditions. But i can&#39;t use=A0 echo=A0 t &gt;=
=20
/proc/sysrq-trigger and debug when the application hung. <br><br></div>=A0I
 am using below piece of code(drivers/serial/8250.c) on P2020RDB to=20
debug the application where in , in hung situation, when i press &#39;y&#39=
;=A0=20
followed by &#39;t&#39;=A0 on serial console it should go to sysrq handler,=
 and=20
dump the call trace, but it is not happening.(simply board hung)<br><div><b=
r>{<br>=A0=A0 =A0=A0=A0=A0=A0=A0=A0 if(sysrq_enable_flag) <br>=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 handle_sysrq(ch, up-&gt;port.info-&=
gt;tty);<br>=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0 sysrq_enable_fl=
ag =3D 0;<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <br>=A0=A0=A0=A0=A0=A0=A0 if(ch =3D=3D &#=
39;y&#39;)<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysrq_enable_flag =3D 1;<br=
>}<br><br></div><div>It would be helpful if you provide any hint on the iss=
ue, or any other way to debug the application in hang situations.<br>
<br></div>Thanks,<br>Sai<div class=3D"gmail_extra"><br><br><div class=3D"gm=
ail_quote">On Tue, Apr 16, 2013 at 9:24 PM, Anshuman Khandual <span dir=3D"=
ltr">&lt;<a href=3D"mailto:khandual@linux.vnet.ibm.com" target=3D"_blank">k=
handual@linux.vnet.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Branch Histo=
ry Rolling Buffer (BHRB) is a new PMU feaure in IBM<br>
POWER8 processor which records the branch instructions inside the execution=
<br>
pipeline. This patchset enables the basic functionality of the feature thro=
ugh<br>
generic perf branch stack sampling framework.<br>
<br>
Sample output<br>
-------------<br>
$./perf record -b top<br>
$./perf report<br>
<br>
Overhead =A0Command =A0Source Shared Object =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 Source Symbol =A0Target Shared Object =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Target Symbol<br>
# ........ =A0....... =A0.................... =A0..........................=
............ =A0.................... =A0...................................=
<br>
#<br>
<br>
=A0 =A0 =A07.82% =A0 =A0 =A0top =A0<a href=3D"http://libc-2.11.2.so" target=
=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] _IO_vfscanf =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 <a href=3D"http://libc-2.11.2.so" targe=
t=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] _IO_vfscanf<br>

=A0 =A0 =A06.17% =A0 =A0 =A0top =A0<a href=3D"http://libc-2.11.2.so" target=
=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] _IO_vfscanf =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [unknown] =A0 =A0 =A0 =A0 =A0 =A0 [k] 0=
0000000<br>
=A0 =A0 =A02.37% =A0 =A0 =A0top =A0[unknown] =A0 =A0 =A0 =A0 =A0 =A0 [k] 0x=
f7aafb30 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[unknown] =A0 =
=A0 =A0 =A0 =A0 =A0 [k] 00000000<br>
=A0 =A0 =A01.80% =A0 =A0 =A0top =A0[unknown] =A0 =A0 =A0 =A0 =A0 =A0 [k] 0x=
0fe07978 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"http=
://libc-2.11.2.so" target=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] =
_IO_vfscanf<br>
=A0 =A0 =A01.60% =A0 =A0 =A0top =A0<a href=3D"http://libc-2.11.2.so" target=
=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] _IO_vfscanf =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [kernel.kallsyms] =A0 =A0 [k] .do_task_=
stat<br>
=A0 =A0 =A01.20% =A0 =A0 =A0top =A0[kernel.kallsyms] =A0 =A0 [k] .do_task_s=
tat =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [kernel.kallsyms] =A0 =A0 [=
k] .do_task_stat<br>
=A0 =A0 =A01.02% =A0 =A0 =A0top =A0<a href=3D"http://libc-2.11.2.so" target=
=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] vfprintf =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<a href=3D"http://libc-2.11.2.so" ta=
rget=3D"_blank">libc-2.11.2.so</a> =A0 =A0 =A0 =A0[k] vfprintf<br>

=A0 =A0 =A00.92% =A0 =A0 =A0top =A0top =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
[k] _init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [unkn=
own] =A0 =A0 =A0 =A0 =A0 =A0 [k] 0x0fe037f4<br>
<br>
Changes in V2<br>
--------------<br>
- Added copyright messages to the newly created files<br>
- Modified couple of commit messages<br>
<br>
Anshuman Khandual (5):<br>
=A0 powerpc, perf: Add new BHRB related instructions on POWER8<br>
=A0 powerpc, perf: Add basic assembly code to read BHRB entries on POWER8<b=
r>
=A0 powerpc, perf: Add new BHRB related generic functions, data and flags<b=
r>
=A0 powerpc, perf: Define BHRB generic functions, data and flags for POWER8=
<br>
=A0 powerpc, perf: Enable branch stack sampling framework support with BHRB=
<br>
<br>
=A0arch/powerpc/include/asm/perf_event_server.h | =A06 ++<br>
=A0arch/powerpc/include/asm/ppc-opcode.h =A0 =A0 =A0 =A0| =A07 ++<br>
=A0arch/powerpc/perf/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A02 +-=
<br>
=A0arch/powerpc/perf/bhrb.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 44 ++=
+++++++++++<br>
=A0arch/powerpc/perf/core-book3s.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| 96 ++++++++=
+++++++++++++++++++-<br>
=A0arch/powerpc/perf/perf_event_bhrb.c =A0 =A0 =A0 =A0 =A0| 85 ++++++++++++=
++++++++++++<br>
=A0arch/powerpc/perf/power8-pmu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 57 ++++++++=
++++++++-<br>
=A07 files changed, 292 insertions(+), 5 deletions(-)<br>
=A0create mode 100644 arch/powerpc/perf/bhrb.S<br>
=A0create mode 100644 arch/powerpc/perf/perf_event_bhrb.c<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.11.7<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
</font></span></blockquote></div><br></div></div>

--20cf307c9b6a92144c04da876ad6--
