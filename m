Return-Path: <Bryan.Hundven@watchguard.com>
Received: from watchguard.com (mx1.watchguard.com [206.191.171.101])
 by ozlabs.org (Postfix) with ESMTP id 46C11B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 05:34:25 +1100 (EST)
From: Bryan Hundven <Bryan.Hundven@watchguard.com>
To: Kumar Gala <galak@kernel.crashing.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Subject: Re: powerpc/85xx: p2020rdb - move the NAND address.
Date: Thu, 29 Mar 2012 18:28:49 +0000
Message-ID: <5cfxnrfxtgpc584nns33030w.1333045723838@email.android.com>
References: <E9CCADB024EDCD44A9C1083605680C42B9053302@ES05CO.wgti.net>
 <4F740E98.50104@linutronix.de>,
 <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
In-Reply-To: <9460468D-281C-4960-839A-F8435638DE4B@kernel.crashing.org>
Content-Type: multipart/alternative;
 boundary="_000_5cfxnrfxtgpc584nns33030w1333045723838emailandroidcom_"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_5cfxnrfxtgpc584nns33030w1333045723838emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Kumar,

Sorry, i should have posted to the ml.

Thank you, I was looking in the wrong spot.

Cheers,

-Bryan



Kumar Gala <galak@kernel.crashing.org> wrote:



On Mar 29, 2012, at 2:26 AM, Sebastian Andrzej Siewior wrote:

> On 03/28/2012 10:30 PM, Bryan Hundven wrote:
>> > It is not at 0xffa00000. According to current u-boot source the NAND
>> > controller is always at 0xff800000 and it is either at CS0 or CS1
>> > depending on NAND or NAND+NOR mode. In 36bit mode it is shifted to
>> > 0xfff800000 but it has always an eight there and never an A.
>> >
>> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>
>> I am having a hard time verifying this change. I don't think you are
>> wrong, I'm just having a hard time following.
>>
>> I do not see where this has always been 0xff800000 in u-boot.
>
> <cut>
>
>> But while I was checking changes in arch/powerpc/, I found this change
>> and wanted to understand why 0xffa00000 has worked for us for so long?
>
> Kumar, I wasn't wrong entirely I just missed one detail. U-Boot
> provides two different configs, not just one define like its for
> SPL/SPI/...:
>
> - include/configs/P1_P2_RDB.h
>
> #ifndef CONFIG_NAND_SPL
> #define CONFIG_SYS_NAND_BASE            0xffa00000
> #ifdef CONFIG_PHYS_64BIT
> #define CONFIG_SYS_NAND_BASE_PHYS       0xfffa00000ull
> #else
> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
> #endif
> #else
> #define CONFIG_SYS_NAND_BASE            0xfff00000
> #ifdef CONFIG_PHYS_64BIT
> #define CONFIG_SYS_NAND_BASE_PHYS       0xffff00000ull
> #else
> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
> #endif
> #endif
>
> - include/configs/p1_p2_rdb_pc.h
>
> #ifdef CONFIG_NAND_FSL_ELBC
> #define CONFIG_SYS_NAND_BASE            0xff800000
> #ifdef CONFIG_PHYS_64BIT
> #define CONFIG_SYS_NAND_BASE_PHYS       0xfff800000ull
> #else
> #define CONFIG_SYS_NAND_BASE_PHYS       CONFIG_SYS_NAND_BASE
> #endif
>
> and for kernel they use both the same device tree. So with the change,
> the _pc variant finds its flash. Before that it worked for the non-pc
> variant only if NAND_SPL wasn't used.
> Any suggestion on fixing that? Providing a new dt for _pc would "fix"
> it but the non pc variant won't find it in the case of NAND_SPL.

There are two (well 3 since rdb-pc has both 32b & 36b) in the tree now:

arch/powerpc/boot/dts/p2020rdb.dts
arch/powerpc/boot/dts/p2020rdb-pc_32b.dts
arch/powerpc/boot/dts/p2020rdb-pc_36b.dts

>
> Since both system have the same SoC and the NAND_SPL is always linked
> against 0xfff00000 I don't see anything wrong to relocate the NAND CS
> later to 0xff800000 (or to 0xffa00000) and having it consistent among
> both configs.


- k

--_000_5cfxnrfxtgpc584nns33030w1333045723838emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>Kumar,
<div><br>
</div>
<div>Sorry, i should have posted to the ml.</div>
<div><br>
</div>
<div>Thank you, I was looking in the wrong spot.</div>
<div><br>
</div>
<div>Cheers,</div>
<div><br>
</div>
<div>-Bryan</div>
<br>
<br>
<br>
Kumar Gala &lt;galak@kernel.crashing.org&gt; wrote:<br>
<br>
<br>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText"><br>
On Mar 29, 2012, at 2:26 AM, Sebastian Andrzej Siewior wrote:<br>
<br>
&gt; On 03/28/2012 10:30 PM, Bryan Hundven wrote:<br>
&gt;&gt; &gt; It is not at 0xffa00000. According to current u-boot source t=
he NAND<br>
&gt;&gt; &gt; controller is always at 0xff800000 and it is either at CS0 or=
 CS1<br>
&gt;&gt; &gt; depending on NAND or NAND&#43;NOR mode. In 36bit mode it is s=
hifted to<br>
&gt;&gt; &gt; 0xfff800000 but it has always an eight there and never an A.<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Sebastian Andrzej Siewior &lt;bigeasy@linutron=
ix.de&gt;<br>
&gt;&gt; &gt; Signed-off-by: Kumar Gala &lt;galak@kernel.crashing.org&gt;<b=
r>
&gt;&gt; <br>
&gt;&gt; I am having a hard time verifying this change. I don't think you a=
re<br>
&gt;&gt; wrong, I'm just having a hard time following.<br>
&gt;&gt; <br>
&gt;&gt; I do not see where this has always been 0xff800000 in u-boot.<br>
&gt; <br>
&gt; &lt;cut&gt;<br>
&gt; <br>
&gt;&gt; But while I was checking changes in arch/powerpc/, I found this ch=
ange<br>
&gt;&gt; and wanted to understand why 0xffa00000 has worked for us for so l=
ong?<br>
&gt; <br>
&gt; Kumar, I wasn't wrong entirely I just missed one detail. U-Boot<br>
&gt; provides two different configs, not just one define like its for<br>
&gt; SPL/SPI/...:<br>
&gt; <br>
&gt; - include/configs/P1_P2_RDB.h<br>
&gt; <br>
&gt; #ifndef CONFIG_NAND_SPL<br>
&gt; #define CONFIG_SYS_NAND_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0xffa00000<br>
&gt; #ifdef CONFIG_PHYS_64BIT<br>
&gt; #define CONFIG_SYS_NAND_BASE_PHYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xfffa00000ull<br>
&gt; #else<br>
&gt; #define CONFIG_SYS_NAND_BASE_PHYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CONFIG_SYS_NAND_BASE<br>
&gt; #endif<br>
&gt; #else<br>
&gt; #define CONFIG_SYS_NAND_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0xfff00000<br>
&gt; #ifdef CONFIG_PHYS_64BIT<br>
&gt; #define CONFIG_SYS_NAND_BASE_PHYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xffff00000ull<br>
&gt; #else<br>
&gt; #define CONFIG_SYS_NAND_BASE_PHYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CONFIG_SYS_NAND_BASE<br>
&gt; #endif<br>
&gt; #endif<br>
&gt; <br>
&gt; - include/configs/p1_p2_rdb_pc.h<br>
&gt; <br>
&gt; #ifdef CONFIG_NAND_FSL_ELBC<br>
&gt; #define CONFIG_SYS_NAND_BASE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0xff800000<br>
&gt; #ifdef CONFIG_PHYS_64BIT<br>
&gt; #define CONFIG_SYS_NAND_BASE_PHYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0xfff800000ull<br>
&gt; #else<br>
&gt; #define CONFIG_SYS_NAND_BASE_PHYS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CONFIG_SYS_NAND_BASE<br>
&gt; #endif<br>
&gt; <br>
&gt; and for kernel they use both the same device tree. So with the change,=
<br>
&gt; the _pc variant finds its flash. Before that it worked for the non-pc<=
br>
&gt; variant only if NAND_SPL wasn't used.<br>
&gt; Any suggestion on fixing that? Providing a new dt for _pc would &quot;=
fix&quot;<br>
&gt; it but the non pc variant won't find it in the case of NAND_SPL.<br>
<br>
There are two (well 3 since rdb-pc has both 32b &amp; 36b) in the tree now:=
<br>
<br>
arch/powerpc/boot/dts/p2020rdb.dts<br>
arch/powerpc/boot/dts/p2020rdb-pc_32b.dts<br>
arch/powerpc/boot/dts/p2020rdb-pc_36b.dts<br>
<br>
&gt; <br>
&gt; Since both system have the same SoC and the NAND_SPL is always linked<=
br>
&gt; against 0xfff00000 I don't see anything wrong to relocate the NAND CS<=
br>
&gt; later to 0xff800000 (or to 0xffa00000) and having it consistent among<=
br>
&gt; both configs.<br>
<br>
<br>
- k<br>
</div>
</span></font>
</body>
</html>

--_000_5cfxnrfxtgpc584nns33030w1333045723838emailandroidcom_--
