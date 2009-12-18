Return-Path: <preben.myrvoll@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by ozlabs.org (Postfix) with ESMTP id 054A2B6F01
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Dec 2009 23:40:04 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 4so59423eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Dec 2009 04:40:01 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 18 Dec 2009 13:40:01 +0100
Message-ID: <8e04e50a0912180440j14a9da55g50d4750dc3fe378@mail.gmail.com>
Subject: Oprofile 0.9.6 on ppc 603 - samples reported for wrong
	function/symbol?
From: Preben Rynning Myrvoll <preben.myrvoll@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=000e0ce0445ad027b7047b000953
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0ce0445ad027b7047b000953
Content-Type: text/plain; charset=ISO-8859-1

Hi all.

I'm running oprofile on a ppc 603 (in timer mode) and believe I'm getting
reports on samples for the wrong symbol/function.

When running opreport for a specific network module (MyEth), I get a number
of samples reported in a function (below: MyCos_Init) used when loading the
module. This occurs for every test (iperf), although I reset the profiling
data in between I do not reload the module for each run, so there should be
no reason for the opreport to report samples for this function. I've also
instrumented the module, to verify that i do not call the MyCos_Init
repeatedly (in fact it is not called at all after I've loaded it)

The report looks like this..

>~# opreport -l -p /lib/modules/  MyEth
Overflow stats not available
CPU: CPU with timer interrupt, speed 0 MHz (estimated)
Profiling through timer interrupt
warning: could not check that the binary file /lib/modules/MyEth has not
been modified since the profile was taken. Results may be inaccurate.
samples  %        symbol name
228      39.3782  MyEth_TxThread
219      37.8238  MyEth_TxDone
83       14.3351  MyCos_Init
49        8.4629  MyEth_start_xmit


Looking at a more detailed report (with "-d" option in opreport), I see
where the samples for the function MyCos_Init are taken (from address 230c
to 238c). MyCos_Init is located at 1e3c.

00001e3c 83       14.3351  MyCos_Init
  0000230c 9        10.8434
  00002318 5         6.0241
  0000231c 1         1.2048
  00002324 9        10.8434
  00002338 21       25.3012
  0000233c 2         2.4096
  00002344 10       12.0482
  0000237c 14       16.8675
  00002384 10       12.0482
  0000238c 2         2.4096

Running "nm -n /lib/modules/MyEth" to list symbols (sorted), I find the
MyCos_Init at the bottom of the list (Last function / higest address). Is
Oprofile just
reporting defaulting to the last symbol if it can find any reasonable
symbol/function?

If I then look in "/proc/kallsyms" I find where the function is located, and
see there are functions below it belonging to my module. The
list shows me that the function MyCos_Init takes 3E8 address..

c9088e3c t MyCos_Init  [MyEth]
c9089224 t MyEth_p_cleanup   [MyEth]
c90892a4 t MyEth_exit  [MyEth]
c90892a4 t cleanup_module       [MyEth]
c9089e58 r __func__.0   [MyEth]
c9089e60 r __func__.1   [MyEth]

Then finally. Adding 3E8 (size allocated for function in kernel) to the
address found from "opreport" /"nm" for the MyCos_Init function (
0x00001e3c) I get 0x00002224.
So the reported samples from opreport is after the addresses for this
function. So is oprofile reporting samples for a wrong function or what? Or
I'm I doing something wrong?

Thanks for any assistance.

Best Regards

Preben

--000e0ce0445ad027b7047b000953
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all.<br><br>I&#39;m running oprofile on a ppc 603 (in timer mode) and be=
lieve I&#39;m getting reports on samples for the wrong symbol/function. <br=
><br>When running opreport for a specific network module (MyEth), I get a n=
umber of samples reported in a function (below: MyCos_Init) used when loadi=
ng the module. This occurs for every test (iperf), although I reset the pro=
filing data in between I do not reload the module for each run, so there sh=
ould be no reason for the opreport to report samples for this function. I&#=
39;ve also instrumented the module, to verify that i do not call the MyCos_=
Init repeatedly (in fact it is not called at all after I&#39;ve loaded it)<=
br>
<br>The report looks like this..<br>
<br>&gt;~# opreport -l -p /lib/modules/=A0 MyEth<br>Overflow stats not avai=
lable<br>CPU: CPU with timer interrupt, speed 0 MHz (estimated)<br>Profilin=
g through timer interrupt<br>warning: could not check that the binary file =
/lib/modules/MyEth has not been modified since the profile was taken. Resul=
ts may be inaccurate.<br>

samples=A0 %=A0=A0=A0=A0=A0=A0=A0 symbol name<br>228=A0=A0=A0=A0=A0 39.3782=
=A0 MyEth_TxThread<br>219=A0=A0=A0=A0=A0 37.8238=A0 MyEth_TxDone<br>83=A0=
=A0=A0=A0=A0=A0 14.3351=A0 MyCos_Init<br>49=A0=A0=A0=A0=A0=A0=A0 8.4629=A0 =
MyEth_start_xmit<br><br><br>Looking at a more detailed report (with &quot;-=
d&quot; option in opreport), I see where the samples for the function MyCos=
_Init are taken (from address 230c to 238c). MyCos_Init is located at 1e3c.=
<br>

<br>00001e3c 83=A0=A0=A0=A0=A0=A0 14.3351=A0 MyCos_Init<br>=A0 0000230c 9=
=A0=A0=A0=A0=A0=A0=A0 10.8434<br>=A0 00002318 5=A0=A0=A0=A0=A0=A0=A0=A0 6.0=
241<br>=A0 0000231c 1=A0=A0=A0=A0=A0=A0=A0=A0 1.2048<br>=A0 00002324 9=A0=
=A0=A0=A0=A0=A0=A0 10.8434<br>=A0 00002338 21=A0=A0=A0=A0=A0=A0 25.3012<br>=
=A0 0000233c 2=A0=A0=A0=A0=A0=A0=A0=A0 2.4096<br>

=A0 00002344 10=A0=A0=A0=A0=A0=A0 12.0482<br>=A0 0000237c 14=A0=A0=A0=A0=A0=
=A0 16.8675<br>=A0 00002384 10=A0=A0=A0=A0=A0=A0 12.0482<br>=A0 0000238c 2=
=A0=A0=A0=A0=A0=A0=A0=A0 2.4096<br><br>Running &quot;nm -n /lib/modules/MyE=
th&quot; to list symbols (sorted), I find the MyCos_Init at the bottom of t=
he list (Last function / higest address). Is Oprofile just <br>
reporting defaulting to the last symbol if it can find any reasonable symbo=
l/function?<br><br>If I then look in &quot;/proc/kallsyms&quot; I find wher=
e the function is located, and see there are functions below it belonging t=
o my module. The <br>
list shows me that the function MyCos_Init takes 3E8 address..<br><br>c9088=
e3c t MyCos_Init=A0 [MyEth]<br>c9089224 t MyEth_p_cleanup=A0=A0 [MyEth]<br>=
c90892a4 t MyEth_exit=A0 [MyEth]<br>c90892a4 t cleanup_module=A0=A0=A0=A0=
=A0=A0 [MyEth]<br>
c9089e58 r __func__.0=A0=A0 [MyEth]<br>c9089e60 r __func__.1=A0=A0 [MyEth]<=
br><br>Then finally. Adding 3E8 (size allocated for function in kernel) to =
the address found from &quot;opreport&quot; /&quot;nm&quot; for the MyCos_I=
nit function ( 0x00001e3c) I get 0x00002224. <br>
So the reported samples from opreport is after the addresses for this funct=
ion. So is oprofile reporting samples for a wrong function or what? Or I&#3=
9;m I doing something wrong?<br><br>Thanks for any assistance.<br><br>Best =
Regards<br>
<br>Preben<br>
<br><br>

--000e0ce0445ad027b7047b000953--
