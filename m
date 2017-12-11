Return-Path: <cyrilbur@gmail.com>
Received: from mail-qt0-x234.google.com (mail-qt0-x234.google.com
 [IPv6:2607:f8b0:400d:c0d::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yw7yY3XY4zDqvM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Dec 2017 14:40:37 +1100 (AEDT)
Received: by mail-qt0-x234.google.com with SMTP id g10so35121904qtj.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Dec 2017 19:40:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871sk2c985.fsf@concordia.ellerman.id.au>
References: <20171121071720.24619-1-cyrilbur@gmail.com>
 <20171121071720.24619-2-cyrilbur@gmail.com>
 <5A142ABD.9060705@linux.vnet.ibm.com> <1511307683.7121.5.camel@gmail.com>
 <871sk2c985.fsf@concordia.ellerman.id.au>
From: Cyril Bur <cyrilbur@gmail.com>
Date: Mon, 11 Dec 2017 14:40:04 +1100
Message-ID: <CAN-ccASct4zQCh6wjob_kReufsYpMLhYPZkGz+zBG=XoHGA9Sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/powerpc: Calculate spin time in
 tm-unavailable
To: Michael Ellerman <mpe@ellerman.id.au>,
 Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Content-Type: multipart/alternative; boundary="001a114d7496068fe70560084cc1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114d7496068fe70560084cc1
Content-Type: text/plain; charset="UTF-8"

On Mon, 2017-12-11 at 13:02 +1100, Michael Ellerman wrote:

> Cyril Bur <cyrilbur@gmail.com> writes:

>

> > On Tue, 2017-11-21 at 11:31 -0200, Gustavo Romero wrote:

> > > Hi Cyril,

> > >

> > > On 21-11-2017 05:17, Cyril Bur wrote:

> > > > Currently the tm-unavailable test spins for a fixed amount of time in

> > > > an attempt to ensure the FPU/VMX/VSX facilities are off. This value was

> > > > experimentally tested to be long enough.

> > > >

> > > > Problems may arise if kernel heuristics were to change. This patch

> > > > should future proof this test.

> > >

> > > I've tried it on a VM running on '4.14.0-rc7' and apparently it gets stuck

> > > pretty slow on calibration, since it ran ~7m without finding the correct value

> > > (before it would take about 3m), like:

> > >

> > > $ time ./tm-unavailable

> > > Testing required spin time required for facility unavailable...

> > > 	Trying 0x18000000...

> > > 	Trying 0x19000000...

> > > 	Trying 0x1a000000...

> > > ...

> > > 	Trying 0xfd000000... ^C

> > >

> > > real	7m15.304s

> > > user	7m15.291s

> > > sys	0m0.004s

> > >

> >

> > Interesting! I didn't test in a VM. I guess hypervisor switching

> > completely changes the heuristic. Ok I'll have to rethink.

> >

> > Maybe the increase should be a multiplier to get to a good state more

> > quickly.

>

> Yeah this sucks in a VM:

>

> # /home/michael/tm-unavailable

> Testing required spin time required for facility unavailable...

> 	Trying 0x18000000...

> 	Trying 0x19000000...

> ...

> 	Trying 0x110000000...

>

> etc.

>

> I got sick of waiting for it, but it's causing my selftests job to time

> out so it must be taking > ~1 hour.

>


Yeah sorry, I'll see if I can come up with a better way for a VM. Needs a
few more cycles from me.

Cyril

> cheers

--001a114d7496068fe70560084cc1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div bgcolor=3D"#232729" text=3D"#eeeeec" link=3D"#4a90d9"=
 vlink=3D"#eeeeec" style=3D"word-wrap:break-word;line-break:after-white-spa=
ce"><div style=3D"width:71ch">On Mon, 2017-12-11 at 13:02 +1100, Michael El=
lerman wrote:</div><blockquote type=3D"cite"><pre><span class=3D"m_61096493=
51531200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-=
character">&gt; </span></span>Cyril Bur &lt;<a href=3D"mailto:cyrilbur@gmai=
l.com" target=3D"_blank">cyrilbur@gmail.com</a>&gt; writes:</pre><pre><span=
 class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_610964935153=
1200957-x-evo-quote-character">&gt; </span></span><br></pre><blockquote typ=
e=3D"cite"><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span cl=
ass=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=
=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span>On Tue,=
 2017-11-21 at 11:31 -0200, Gustavo Romero wrote:</pre><blockquote type=3D"=
cite"><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=
=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=3D=
"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_=
6109649351531200957-x-evo-quote-character">&gt; </span></span>Hi Cyril,</pr=
e><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_=
6109649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_610=
9649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_610964=
9351531200957-x-evo-quote-character">&gt; </span></span><br></pre><pre><spa=
n class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61096493515=
31200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515312=
00957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515312009=
57-x-evo-quote-character">&gt; </span></span>On 21-11-2017 05:17, Cyril Bur=
 wrote:</pre><blockquote type=3D"cite"><pre><span class=3D"m_61096493515312=
00957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-charac=
ter">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-character=
">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-character">&=
gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt;=
 </span></span>Currently the tm-unavailable test spins for a fixed amount o=
f time in</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><spa=
n class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span c=
lass=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span clas=
s=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=
=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span>an atte=
mpt to ensure the FPU/VMX/VSX facilities are off. This value was</pre><pre>=
<span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6109649=
351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351=
531200957-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531=
200957-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200=
957-x-evo-quote-character">&gt; </span></span>experimentally tested to be l=
ong enough.</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><s=
pan class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span=
 class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span cl=
ass=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=
=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span><br></p=
re><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m=
_6109649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61=
09649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096=
49351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493=
51531200957-x-evo-quote-character">&gt; </span></span>Problems may arise if=
 kernel heuristics were to change. This patch</pre><pre><span class=3D"m_61=
09649351531200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-=
quote-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quo=
te-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-=
character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-cha=
racter">&gt; </span></span>should future proof this test.</pre></blockquote=
><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6=
109649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_6109=
649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_6109649=
351531200957-x-evo-quote-character">&gt; </span></span><br></pre><pre><span=
 class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_610964935153=
1200957-x-evo-quote-character">&gt; </span><span class=3D"m_610964935153120=
0957-x-evo-quote-character">&gt; </span><span class=3D"m_610964935153120095=
7-x-evo-quote-character">&gt; </span></span>I&#39;ve tried it on a VM runni=
ng on &#39;4.14.0-rc7&#39; and apparently it gets stuck</pre><pre><span cla=
ss=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6109649351531200=
957-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200957=
-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200957-x-=
evo-quote-character">&gt; </span></span>pretty slow on calibration, since i=
t ran ~7m without finding the correct value</pre><pre><span class=3D"m_6109=
649351531200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-qu=
ote-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote=
-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-ch=
aracter">&gt; </span></span>(before it would take about 3m), like:</pre><pr=
e><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61096=
49351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493=
51531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515=
31200957-x-evo-quote-character">&gt; </span></span><br></pre><pre><span cla=
ss=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6109649351531200=
957-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200957=
-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200957-x-=
evo-quote-character">&gt; </span></span>$ time ./tm-unavailable</pre><pre><=
span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61096493=
51531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515=
31200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515312=
00957-x-evo-quote-character">&gt; </span></span>Testing required spin time =
required for facility unavailable...</pre><pre><span class=3D"m_61096493515=
31200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-cha=
racter">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-charac=
ter">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-character=
">&gt; </span></span><span class=3D"m_6109649351531200957Apple-tab-span" st=
yle=3D"white-space:pre-wrap">	</span>Trying 0x18000000...</pre><pre><span c=
lass=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61096493515312=
00957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515312009=
57-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200957-=
x-evo-quote-character">&gt; </span></span><span class=3D"m_6109649351531200=
957Apple-tab-span" style=3D"white-space:pre-wrap">	</span>Trying 0x19000000=
...</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span clas=
s=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=
=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span class=3D=
"m_6109649351531200957-x-evo-quote-character">&gt; </span></span><span clas=
s=3D"m_6109649351531200957Apple-tab-span" style=3D"white-space:pre-wrap">	<=
/span>Trying 0x1a000000...</pre><pre><span class=3D"m_6109649351531200957-x=
-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-character">&g=
t; </span><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; =
</span><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </s=
pan></span>...</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"=
><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><s=
pan class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span=
 class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span><=
span class=3D"m_6109649351531200957Apple-tab-span" style=3D"white-space:pre=
-wrap">	</span>Trying 0xfd000000... ^C</pre><pre><span class=3D"m_610964935=
1531200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-c=
haracter">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-char=
acter">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-charact=
er">&gt; </span></span><br></pre><pre><span class=3D"m_6109649351531200957-=
x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-character">&=
gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt;=
 </span><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </=
span></span>real<span class=3D"m_6109649351531200957Apple-tab-span" style=
=3D"white-space:pre-wrap">	</span>7m15.304s</pre><pre><span class=3D"m_6109=
649351531200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-qu=
ote-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote=
-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quote-ch=
aracter">&gt; </span></span>user<span class=3D"m_6109649351531200957Apple-t=
ab-span" style=3D"white-space:pre-wrap">	</span>7m15.291s</pre><pre><span c=
lass=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61096493515312=
00957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515312009=
57-x-evo-quote-character">&gt; </span><span class=3D"m_6109649351531200957-=
x-evo-quote-character">&gt; </span></span>sys<span class=3D"m_6109649351531=
200957Apple-tab-span" style=3D"white-space:pre-wrap">	</span>0m0.004s</pre>=
<pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61=
09649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096=
49351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493=
51531200957-x-evo-quote-character">&gt; </span></span><br></pre></blockquot=
e><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_=
6109649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_610=
9649351531200957-x-evo-quote-character">&gt; </span></span><br></pre><pre><=
span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_61096493=
51531200957-x-evo-quote-character">&gt; </span><span class=3D"m_61096493515=
31200957-x-evo-quote-character">&gt; </span></span>Interesting! I didn&#39;=
t test in a VM. I guess hypervisor switching</pre><pre><span class=3D"m_610=
9649351531200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-q=
uote-character">&gt; </span><span class=3D"m_6109649351531200957-x-evo-quot=
e-character">&gt; </span></span>completely changes the heuristic. Ok I&#39;=
ll have to rethink.</pre><pre><span class=3D"m_6109649351531200957-x-evo-qu=
oted"><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </sp=
an><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span>=
</span><br></pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><s=
pan class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span><span=
 class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span>M=
aybe the increase should be a multiplier to get to a good state more</pre><=
pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_610=
9649351531200957-x-evo-quote-character">&gt; </span><span class=3D"m_610964=
9351531200957-x-evo-quote-character">&gt; </span></span>quickly.</pre></blo=
ckquote><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=
=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span><br></p=
re><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m=
_6109649351531200957-x-evo-quote-character">&gt; </span></span>Yeah this su=
cks in a VM:</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><=
span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></sp=
an><br></pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span =
class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span># =
/home/michael/tm-unavailable </pre><pre><span class=3D"m_610964935153120095=
7-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-character"=
>&gt; </span></span>Testing required spin time required for facility unavai=
lable...</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span=
 class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span><=
span class=3D"m_6109649351531200957Apple-tab-span" style=3D"white-space:pre=
-wrap">	</span>Trying 0x18000000... </pre><pre><span class=3D"m_61096493515=
31200957-x-evo-quoted"><span class=3D"m_6109649351531200957-x-evo-quote-cha=
racter">&gt; </span></span><span class=3D"m_6109649351531200957Apple-tab-sp=
an" style=3D"white-space:pre-wrap">	</span>Trying 0x19000000... </pre><pre>=
<span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6109649=
351531200957-x-evo-quote-character">&gt; </span></span>...</pre><pre><span =
class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6109649351531=
200957-x-evo-quote-character">&gt; </span></span><span class=3D"m_610964935=
1531200957Apple-tab-span" style=3D"white-space:pre-wrap">	</span>Trying 0x1=
10000000...  </pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted">=
<span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></s=
pan><br></pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span=
 class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span>e=
tc.</pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span clas=
s=3D"m_6109649351531200957-x-evo-quote-character">&gt; </span></span><br></=
pre><pre><span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"=
m_6109649351531200957-x-evo-quote-character">&gt; </span></span>I got sick =
of waiting for it, but it&#39;s causing my selftests job to time</pre><pre>=
<span class=3D"m_6109649351531200957-x-evo-quoted"><span class=3D"m_6109649=
351531200957-x-evo-quote-character">&gt; </span></span>out so it must be ta=
king &gt; ~1 hour.</pre><pre><span class=3D"m_6109649351531200957-x-evo-quo=
ted"><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </spa=
n></span><br></pre></blockquote><div style=3D"width:71ch"><br></div><div st=
yle=3D"width:71ch">Yeah sorry, I&#39;ll see if I can come up with a better =
way for a VM. Needs a few more cycles from me.</div><div style=3D"width:71c=
h"><br></div><div style=3D"width:71ch">Cyril<span id=3D"m_61096493515312009=
57-x-evo-selection-start-marker"></span><span id=3D"m_6109649351531200957-x=
-evo-selection-end-marker"></span></div><div style=3D"width:71ch"><br></div=
><blockquote type=3D"cite"><pre><span class=3D"m_6109649351531200957-x-evo-=
quoted"><span class=3D"m_6109649351531200957-x-evo-quote-character">&gt; </=
span></span>cheers</pre></blockquote><div class=3D"m_6109649351531200957-x-=
evo-signature-wrapper"><span class=3D"m_6109649351531200957-x-evo-signature=
" id=3D"m_6109649351531200957none"></span></div></div></div>

--001a114d7496068fe70560084cc1--
