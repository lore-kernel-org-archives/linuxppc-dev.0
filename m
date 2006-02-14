Return-Path: <pantelis.antoniou@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by ozlabs.org (Postfix) with ESMTP id E153267A59
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 02:28:40 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so1105652wra
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 07:28:39 -0800 (PST)
Message-ID: <449c76a00602140728g3a9eb46sd70f23b894c4b96@mail.gmail.com>
Date: Tue, 14 Feb 2006 10:28:37 -0500
From: Pantelis Antoniou <pantelis.antoniou@gmail.com>
To: Laurent Lagrange <lagrange@fr.oleane.com>
Subject: Re: Gianfar is slower than fcc_enet on MPC8541 ???
In-Reply-To: <000001c6317b$148162c0$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19718_1414721.1139930917934"
References: <000001c6317b$148162c0$5201a8c0@GEG2400>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_19718_1414721.1139930917934
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Laurent,

I found that pretty hard to believe.

What are you measuring exactly?

Speed of replies? If so it's explainable since the TSECs use
NAPI.

Regards

Pantelis

On 2/14/06, Laurent Lagrange <lagrange@fr.oleane.com> wrote:
>
>
> Hello,
>
> I work on a cutom MPC8541 board with Linux 2.6.9.
> The kernel activates the L1 cache (instructions and data)
> and the L2 cache (entirely used as cache and not as sram).
>
> I configure
> 1 FCC (FCC1),
> 2 TSECs with or without NAPI (no effect) but without stashing in L2 sram.
> All PHYs are automatically configured in 100MB full duplex.
>
>         eth0: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e0
>         eth0: Running with NAPI disabled
>         eth0: 64/64 RX/TX BD ring size
>         eth1: Gianfar Ethernet Controller Version 1.1, 00:10:cd:48:48:e1
>         eth1: Running with NAPI disabled
>         eth1: 64/64 RX/TX BD ring size
>         eth2: FCC ENET Version custom, 00:10:cd:48:48:e2
>
> Then I launch 3 simple TCP servers, one on each ports.
>
> From remote machines I runs 3 TCP clients.
> The client sends messages of 1000 bytes,
> The server receives and echoes the message
> The client receives the echoed message, check the content
> and sends a new message again.
>
> The result is that the 2 TSECs are 2 times slower than the FCC.
>
> If I run a "top" application on the board, I use less than 10% of the CPU
> Each port consumes about 1/3 of the CPU.
>
> Any idea on how to configure the gianfar driver ?
>
> Thanks
> Laurent
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

------=_Part_19718_1414721.1139930917934
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Laurent,<br><br>I found that pretty hard to believe.<br><br>What are you=
 measuring exactly?<br><br>Speed of replies? If so it's explainable since t=
he TSECs use<br>NAPI.<br><br>Regards<br><br>Pantelis<br><br><div><span clas=
s=3D"gmail_quote">
On 2/14/06, <b class=3D"gmail_sendername">Laurent Lagrange</b> &lt;<a href=
=3D"mailto:lagrange@fr.oleane.com">lagrange@fr.oleane.com</a>&gt; wrote:</s=
pan><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(2=
04, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>Hello,<br><br>I work on a cutom MPC8541 board with Linux 2.6.9.<br>The =
kernel activates the L1 cache (instructions and data)<br>and the L2 cache (=
entirely used as cache and not as sram).<br><br>I configure<br>1 FCC (FCC1)=
,
<br>2 TSECs with or without NAPI (no effect) but without stashing in L2 sra=
m.<br>All PHYs are automatically configured in 100MB full duplex.<br><br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: Gianfar Ethernet Contro=
ller Version 1.1, 00:10:cd:48:48:e0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: Running with NAPI dis=
abled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth0: 64/64 RX/TX =
BD ring size<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1: Gianf=
ar Ethernet Controller Version 1.1, 00:10:cd:48:48:e1<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1: Running with NAPI disabled<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth1: 64/64 RX/TX BD ring size
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;eth2: FCC ENET Version =
custom, 00:10:cd:48:48:e2<br><br>Then I launch 3 simple TCP servers, one on=
 each ports.<br><br>From remote machines I runs 3 TCP clients.<br>The clien=
t sends messages of 1000 bytes,<br>The server receives and echoes the messa=
ge
<br>The client receives the echoed message, check the content<br>and sends =
a new message again.<br><br>The result is that the 2 TSECs are 2 times slow=
er than the FCC.<br><br>If I run a &quot;top&quot; application on the board=
, I use less than 10% of the CPU
<br>Each port consumes about 1/3 of the CPU.<br><br>Any idea on how to conf=
igure the gianfar driver ?<br><br>Thanks<br>Laurent<br><br><br>____________=
___________________________________<br>Linuxppc-embedded mailing list<br>
<a href=3D"mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.or=
g</a><br><a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded">=
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote><=
/div>
<br>

------=_Part_19718_1414721.1139930917934--
