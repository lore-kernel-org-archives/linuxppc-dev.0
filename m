Return-Path: <caleb@crome.org>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2c5G6G6NzF0B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 03:08:49 +1100 (AEDT)
Received: by mail-pl0-x236.google.com with SMTP id g2so11199941pli.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 08:08:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4c727cc2-2338-4e99-df09-a088a72cfd61@invoxia.com>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
 <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
 <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
 <20171218230220.GA16161@Asurada-Nvidia>
 <CAG5mAdzPuUo8SkJ_AqrgrouLWash4tge4YG7EMrdCTv9=K5FOQ@mail.gmail.com>
 <4c727cc2-2338-4e99-df09-a088a72cfd61@invoxia.com>
From: Caleb Crome <caleb@crome.org>
Date: Thu, 21 Dec 2017 08:08:26 -0800
Message-ID: <CAG5mAdwC8BjL9QmzoeqOLg8r9osJbbZBxb_oe6kJ2jy1wc6j3w@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding style level
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 mail@maciej.szmigiero.name,
 lukma@denx.de, Sascha Hauer <kernel@pengutronix.de>
Content-Type: multipart/alternative; boundary="f40304380f8c39a3220560dbea4a"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f40304380f8c39a3220560dbea4a
Content-Type: text/plain; charset="UTF-8"

On Wed, Dec 20, 2017 at 3:40 AM, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
wrote:

>
>
> On 19/12/2017 01:25, Caleb Crome wrote:
>
>> On Mon, Dec 18, 2017 at 3:02 PM, Nicolin Chen <nicoleotsuka@gmail.com>
>> wrote:
>>
>>> On Mon, Dec 18, 2017 at 02:19:08PM -0800, Caleb Crome wrote:
>>>
>>> Acked-by: Timur Tabi <timur@tabi.org>
>>>>>
>>>> --- To Mark ---
>>>
>>> Mark, can you still take these changes first? Since this failed
>>> test that Caleb reported here is already existing on the top of
>>> the mainline tree, I would like to treat this mail as a separate
>>> bug report and fix it with a separate patch.
>>>
>>> Besides, this series of changes don't change any function flow.
>>>
>>> Thank you
>>>
>>> Sorry!  I should have created a separate thread for this subject.  My
>> comments have *nothing* to do with this patch set, except they are
>> about the same source files.
>>
>> --- To Caleb ---
>>>
>>> I'm re-setting up my loopback test to try to verify these most recent
>>>> changes.
>>>>
>>> I really appreciate your verification and help.
>>>
>> Of course!  I have this wandboard permanently set up for this
>> verification test, so that I can easily repeat whenever I touch our
>> kernel.
>>
>> It's a dead-simple hardware mod just to connect TX to RX.
>>
>> warn:   11a0 11a1 1160 11a3 11a4 11a5 11a6 11a7
>>>> warn: Valid frame after 1 invalid frames
>>>> warn:   11c0 11c1 11c2 11c3 11c4 11c5 11c6 11c7
>>>> warn: first invalid frame while expecting frame 0x00a0
>>>> warn:   13e7 1400 1401 1402 1403 1404 1405 1404
>>>> warn:   1407 1420 1421 1422 1423 1424 1425 1426
>>>> warn:   1427 1440 1441 1442 1443 1444 1445 1484
>>>> warn:   1447 1460 1461 1462 1463 1464 1465 1466
>>>>
>>>> Those last 4 lines are the channel slips -- the least significant
>>>> nibble should be the channel number:  i.e. should go 0, 1, 2, 3, 4, 5,
>>>> 6, 7.
>>>>
>>>> Ugh, so it's basically quite broken again -- before these patches.
>>>>
>>> I remember Arnaud reviewed one of my changes back to September.
>>> So I suppose the test should be fine at that time -- so a change
>>> being merged recently might have impacted the test result.
>>>
>>
>> It's certainly possible that I'm doing something wrong again -- it
>> wouldn't be the first time :-)
>>
>
> Hi All,
>
> Sorry but I will be busy until mid January, I could help testing and
> fixing broken multi channel after.
> Anyway, I don't see specific issues with Nicolin patches.
> We can take time to fix what was broken before this patch set... after.
>
> Arnaud
>
>
>
>> I guess I need to go backwards in time and see what rev re-broke it.
>>>> I don't really have time to dig too deep on this again.
>>>>
>>>> I'd be happy to provide the hardware to anybody that can diagnose and
>>>> debug this more quickly than I can.  I'm very inefficient at kernel
>>>> drivers I think.   My day job is acoustical and electrical
>>>> engineering.
>>>>
>>>> Here's what the hardware looks like for anybody that's interested.
>>>> Just a single wire loopback on the wandboard header.
>>>>
>>> I would definitely like to take the hardware to debug it as long
>>> as you are willing to provide me. Can you send me a private mail
>>> to discuss about it?
>>>
>> Absolutely.
>> -Caleb
>>
>>
>> Thanks
>>> Nicolin
>>>
>>
>
Okay, operator error on my part.  There was an old clock setting in my ssi3
dtsi file that (falsely) modified the ssi baud clock frequency.  Nicolin's
patch

    ASoC: fsl_ssi: Caculate bit clock rate using slot number and width

now properly computes the master clock, and the old dtsi settings that were
necessary to fake things into the right speed are now obsolete.

So... basically, everything is back to working properly.  it wasn't broken
at all -- just my oversight on a ssi clock setting in the dtb.

-Caleb

--f40304380f8c39a3220560dbea4a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Dec 20, 2017 at 3:40 AM, Arnaud Mouiche <span dir=3D"ltr">&lt;<=
a href=3D"mailto:arnaud.mouiche@invoxia.com" target=3D"_blank">arnaud.mouic=
he@invoxia.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div class=3D"m_1402007462445227494gmail-HOEnZb"><div class=
=3D"m_1402007462445227494gmail-h5"><br>
<br>
On 19/12/2017 01:25, Caleb Crome wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On Mon, Dec 18, 2017 at 3:02 PM, Nicolin Chen &lt;<a href=3D"mailto:nicoleo=
tsuka@gmail.com" target=3D"_blank">nicoleotsuka@gmail.com</a>&gt; wrote:<br=
>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On Mon, Dec 18, 2017 at 02:19:08PM -0800, Caleb Crome wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
Acked-by: Timur Tabi &lt;<a href=3D"mailto:timur@tabi.org" target=3D"_blank=
">timur@tabi.org</a>&gt;<br>
</blockquote></blockquote>
--- To Mark ---<br>
<br>
Mark, can you still take these changes first? Since this failed<br>
test that Caleb reported here is already existing on the top of<br>
the mainline tree, I would like to treat this mail as a separate<br>
bug report and fix it with a separate patch.<br>
<br>
Besides, this series of changes don&#39;t change any function flow.<br>
<br>
Thank you<br>
<br>
</blockquote>
Sorry!=C2=A0 I should have created a separate thread for this subject.=C2=
=A0 My<br>
comments have *nothing* to do with this patch set, except they are<br>
about the same source files.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
--- To Caleb ---<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
I&#39;m re-setting up my loopback test to try to verify these most recent c=
hanges.<br>
</blockquote>
I really appreciate your verification and help.<br>
</blockquote>
Of course!=C2=A0 I have this wandboard permanently set up for this<br>
verification test, so that I can easily repeat whenever I touch our<br>
kernel.<br>
<br>
It&#39;s a dead-simple hardware mod just to connect TX to RX.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
warn:=C2=A0 =C2=A011a0 11a1 1160 11a3 11a4 11a5 11a6 11a7<br>
warn: Valid frame after 1 invalid frames<br>
warn:=C2=A0 =C2=A011c0 11c1 11c2 11c3 11c4 11c5 11c6 11c7<br>
warn: first invalid frame while expecting frame 0x00a0<br>
warn:=C2=A0 =C2=A013e7 1400 1401 1402 1403 1404 1405 1404<br>
warn:=C2=A0 =C2=A01407 1420 1421 1422 1423 1424 1425 1426<br>
warn:=C2=A0 =C2=A01427 1440 1441 1442 1443 1444 1445 1484<br>
warn:=C2=A0 =C2=A01447 1460 1461 1462 1463 1464 1465 1466<br>
<br>
Those last 4 lines are the channel slips -- the least significant<br>
nibble should be the channel number:=C2=A0 i.e. should go 0, 1, 2, 3, 4, 5,=
<br>
6, 7.<br>
<br>
Ugh, so it&#39;s basically quite broken again -- before these patches.<br>
</blockquote>
I remember Arnaud reviewed one of my changes back to September.<br>
So I suppose the test should be fine at that time -- so a change<br>
being merged recently might have impacted the test result.<br>
</blockquote>
<br>
It&#39;s certainly possible that I&#39;m doing something wrong again -- it<=
br>
wouldn&#39;t be the first time :-)<br>
</blockquote>
<br></div></div>
Hi All,<br>
<br>
Sorry but I will be busy until mid January, I could help testing and fixing=
 broken multi channel after.<br>
Anyway, I don&#39;t see specific issues with Nicolin patches.<br>
We can take time to fix what was broken before this patch set... after.<spa=
n class=3D"m_1402007462445227494gmail-HOEnZb"><font color=3D"#888888"><br>
<br>
Arnaud</font></span><div class=3D"m_1402007462445227494gmail-HOEnZb"><div c=
lass=3D"m_1402007462445227494gmail-h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
I guess I need to go backwards in time and see what rev re-broke it.<br>
I don&#39;t really have time to dig too deep on this again.<br>
<br>
I&#39;d be happy to provide the hardware to anybody that can diagnose and<b=
r>
debug this more quickly than I can.=C2=A0 I&#39;m very inefficient at kerne=
l<br>
drivers I think.=C2=A0 =C2=A0My day job is acoustical and electrical<br>
engineering.<br>
<br>
Here&#39;s what the hardware looks like for anybody that&#39;s interested.<=
br>
Just a single wire loopback on the wandboard header.<br>
</blockquote>
I would definitely like to take the hardware to debug it as long<br>
as you are willing to provide me. Can you send me a private mail<br>
to discuss about it?<br>
</blockquote>
Absolutely.<br>
-Caleb<br>
<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Thanks<br>
Nicolin<br>
</blockquote></blockquote>
<br></div></div></blockquote><div><br></div><div>Okay, operator error on my=
 part.=C2=A0 There was an old clock setting in my ssi3 dtsi file that (fals=
ely) modified the ssi baud clock frequency.=C2=A0 Nicolin&#39;s patch=C2=A0=
</div><div><br></div><div>=C2=A0 =C2=A0 ASoC: fsl_ssi: Caculate bit clock r=
ate using slot number and width</div><div><br></div><div>now properly compu=
tes the master clock, and the old dtsi settings that were necessary to fake=
 things into the right speed are now obsolete.</div><div><br></div><div>So.=
.. basically, everything is back to working properly.=C2=A0 it wasn&#39;t b=
roken at all -- just my oversight on a ssi clock setting in the dtb.</div><=
div><br></div><div>-Caleb</div><div><br></div><div><br></div></div><br></di=
v></div>

--f40304380f8c39a3220560dbea4a--
