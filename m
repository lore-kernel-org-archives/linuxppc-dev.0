Return-Path: <saysai.gajula@gmail.com>
Received: from mail-ve0-x22d.google.com (mail-ve0-x22d.google.com
 [IPv6:2607:f8b0:400c:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 767822C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 00:35:46 +1000 (EST)
Received: by mail-ve0-f173.google.com with SMTP id ox1so2608506veb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 May 2013 07:35:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367438057.29231.9@snotra>
References: <CAGstqXHrHWdiE=RvZ=1sV+=mPd9LiUZHL0gHPa89AVZRSND2Tg@mail.gmail.com>
 <1367438057.29231.9@snotra>
Date: Sun, 5 May 2013 20:05:41 +0530
Message-ID: <CAGstqXHOxnxv8TZtX0A2XLnxpNnqCoO3ZRYOdpTr=y3Fsy7htQ@mail.gmail.com>
Subject: Re: PowerPC, P2020RDB, application debug when the application is in
 tight loop, Sysrq
From: saikrishna gajula <saysai.gajula@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: multipart/alternative; boundary=047d7bf0c630a3fbe804dbf97faf
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bf0c630a3fbe804dbf97faf
Content-Type: text/plain; charset=ISO-8859-1

Hi Scott,

           Thanks for the information. "sysrq_enable_flag" is custom code
introduced as part of  'y' hack implementation. I will check with the
latest kernels to make use of "sysrq"  feature.

Regrads,
Sai


On Thu, May 2, 2013 at 1:24 AM, Scott Wood <scottwood@freescale.com> wrote:

> On 04/17/2013 12:04:10 AM, saikrishna gajula wrote:
>
>> HI All,
>>
>>              I am new to this group. I am working on Freescale P2020
>> platform running linux 2.6.21.   I am looking for debug mechanism/utility,
>> when a multi threaded application running on linux , appears to be hung (
>> running in a tight loop,deadlock)  while not able to access the board
>> through serial/SSH/Telnet.
>>
>>    I was looking at Magic sysrq option in linux to generate the stack,
>> register dump when the application is hung. I am able to dump the call
>> trace in normal working conditions. But i can't use  echo  t >
>> /proc/sysrq-trigger and debug when the application hung.
>>
>>  I am using below piece of code(drivers/serial/8250.c) on P2020RDB to
>> debug
>> the application where in , in hung situation, when i press 'y'  followed
>> by
>> 't'  on serial console it should go to sysrq handler, and dump the call
>> trace, but it is not happening.(simply board hung)
>>
>> {
>>            if(sysrq_enable_flag)
>>                   handle_sysrq(ch, up->port.info->tty);
>>
>>         sysrq_enable_flag = 0;
>>
>>         if(ch == 'y')
>>             sysrq_enable_flag = 1;
>> }
>>
>> It would be helpful if you provide any hint on the issue, or any other way
>> to debug the application in hang situations.
>>
>
> There's an erratum regarding breaks in Freescale's serial port
> implementation that has been worked around in more recent kernels.  2.6.21
> is six years old.  If you update to a kernel that has the workaround, or
> backport the workaround yourself to your old kernel, you should be able to
> use a break instead of hacking in a check for 'y'.
>
> Other than that, either the kernel is hung too badly to respond to serial
> input at all (in which case use JTAG to debug) or there's something wrong
> with your 'y' hack (sysrq_enable_flag doesn't even appear in current
> kernels so I can't see if this is the case without digging through old
> code).
>
> In any case, upgrade to a newer kernel -- maybe you're hitting a bug that
> has been fixed since then.
>
> -Scott
>

--047d7bf0c630a3fbe804dbf97faf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi Scott,<br><br></div>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 Thanks for the information. &quot;sysrq_enable_flag&quot; is c=
ustom code introduced as part of=A0 &#39;y&#39; hack implementation. I will=
 check with the latest kernels to make use of &quot;sysrq&quot;=A0 feature.=
<br>
<br></div>Regrads,<br></div>Sai<br><div class=3D"gmail_extra"><br><br><div =
class=3D"gmail_quote">On Thu, May 2, 2013 at 1:24 AM, Scott Wood <span dir=
=3D"ltr">&lt;<a href=3D"mailto:scottwood@freescale.com" target=3D"_blank">s=
cottwood@freescale.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 04/17/2013 12:04:10 AM,=
 saikrishna gajula wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
HI All,<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0I am new to this group. I am working on Freescal=
e P2020<br>
platform running linux 2.6.21. =A0 I am looking for debug mechanism/utility=
,<br>
when a multi threaded application running on linux , appears to be hung (<b=
r>
running in a tight loop,deadlock) =A0while not able to access the board<br>
through serial/SSH/Telnet.<br>
<br>
=A0 =A0I was looking at Magic sysrq option in linux to generate the stack,<=
br>
register dump when the application is hung. I am able to dump the call<br>
trace in normal working conditions. But i can&#39;t use =A0echo =A0t &gt;<b=
r>
/proc/sysrq-trigger and debug when the application hung.<br>
<br>
=A0I am using below piece of code(drivers/serial/8250.c) on P2020RDB to deb=
ug<br>
the application where in , in hung situation, when i press &#39;y&#39; =A0f=
ollowed by<br>
&#39;t&#39; =A0on serial console it should go to sysrq handler, and dump th=
e call<br>
trace, but it is not happening.(simply board hung)<br>
<br>
{<br>
=A0 =A0 =A0 =A0 =A0 =A0if(sysrq_enable_flag)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_sysrq(ch, up-&gt;port.info-&gt;t=
ty);<br>
<br>
=A0 =A0 =A0 =A0 sysrq_enable_flag =3D 0;<br>
<br>
=A0 =A0 =A0 =A0 if(ch =3D=3D &#39;y&#39;)<br>
=A0 =A0 =A0 =A0 =A0 =A0 sysrq_enable_flag =3D 1;<br>
}<br>
<br>
It would be helpful if you provide any hint on the issue, or any other way<=
br>
to debug the application in hang situations.<br>
</blockquote>
<br></div>
There&#39;s an erratum regarding breaks in Freescale&#39;s serial port impl=
ementation that has been worked around in more recent kernels. =A02.6.21 is=
 six years old. =A0If you update to a kernel that has the workaround, or ba=
ckport the workaround yourself to your old kernel, you should be able to us=
e a break instead of hacking in a check for &#39;y&#39;.<br>

<br>
Other than that, either the kernel is hung too badly to respond to serial i=
nput at all (in which case use JTAG to debug) or there&#39;s something wron=
g with your &#39;y&#39; hack (sysrq_enable_flag doesn&#39;t even appear in =
current kernels so I can&#39;t see if this is the case without digging thro=
ugh old code).<br>

<br>
In any case, upgrade to a newer kernel -- maybe you&#39;re hitting a bug th=
at has been fixed since then.<span class=3D"HOEnZb"><font color=3D"#888888"=
><br>
<br>
-Scott<br>
</font></span></blockquote></div><br></div></div>

--047d7bf0c630a3fbe804dbf97faf--
