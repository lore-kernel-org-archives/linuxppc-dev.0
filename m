Return-Path: <jcrigby@gmail.com>
Received: from mail-px0-f176.google.com (mail-px0-f176.google.com
	[209.85.216.176]) by ozlabs.org (Postfix) with ESMTP id 9F746DDF91
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 06:51:43 +1000 (EST)
Received: by pxi6 with SMTP id 6so2668022pxi.17
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 13:51:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4b73d43f0905291330i67c20bd3y2fa3f1a127077b74@mail.gmail.com>
References: <1243595599.9769.35.camel@localhost.localdomain>
	<4b73d43f0905291330i67c20bd3y2fa3f1a127077b74@mail.gmail.com>
Date: Fri, 29 May 2009 14:45:44 -0600
Message-ID: <4b73d43f0905291345p5a87f763m4a080a662feed214@mail.gmail.com>
Subject: Re: fastboot.
From: John Rigby <jcrigby@gmail.com>
To: Kenneth Johansson <kenneth@southpole.se>
Content-Type: multipart/alternative; boundary=000e0cd2e6e610f0b6046b1329d2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--000e0cd2e6e610f0b6046b1329d2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

One more thing.  You can get another speed up if you can do burst reads from
NOR.  This requires using the fifo in the local bus controller.  On the
ADS5121 board you need a cpld change to increment the address lines.  With
the cpld as shipped you end up reading bursts that have the first 4 bytes
repeated because the address lines do not increment.  I don't know if this
is feature or bug with the 5121 but I do know you can work around it in the
cpld.

With burst access working you should be able to speed up the kernel copy and
also the jffs2 mount and filesystem access.

I also found that coping an uncompressed kernel was faster than
decompressing a compressed kernel.  But your mileage may vary if you have
the data cache on.  I found that working around all the problems with
turning data cache on were going to take more time than I had.

John

On Fri, May 29, 2009 at 2:30 PM, John Rigby <jcrigby@gmail.com> wrote:

> Kenneth,
>
> I did some fastboot work for 5121 a few months ago.  U-boot, kernel and
> JFFS2 rootfs in NOR.  My reset to userland time was 2.0 seconds, where
> userland was first command executed in first rc.whatever file, so it
> included the time for /sbin/init to get up and start running the rc scripts.
>
> I did some profiling and noticed that the JFFS2 boot time was a significant
> hunk (not just the first time but everytime).  I ran sumtool on the JFFS2
> image and it dropped 600 ms from the boot time so my final time was 1.4
> seconds.  The sumtool program has been around for a few years but it was
> news to mean when I found it.
>
> John
>
>
> On Fri, May 29, 2009 at 5:13 AM, Kenneth Johansson <kenneth@southpole.se>wrote:
>
>> http://www.cambridgewireless.co.uk/news/article/default.aspx?objid=36792
>>
>> Anybody know what they mean by booting here.
>>
>> I have started the ads5121 board using u-boot and kernel in NOR flash
>> and root file system on a compact flash card connected to the IDE
>> interface in 2.05 second until init is started from the rootfs.
>>
>> This was fast enough for what was needed I did not try to optimize
>> further but since I already was in the domain where changes impacted
>> only a few milliseconds I have a hard time imagining going down to less
>> than a second.
>>
>> So I guess the only way is to skip u-boot and run linux kernel directly
>> out of NOR. Anyone know what MontaVista is doing ??
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>
>

--000e0cd2e6e610f0b6046b1329d2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

One more thing.=A0 You can get another speed up if you can do burst reads f=
rom NOR.=A0 This requires using the fifo in the local bus controller.=A0 On=
 the ADS5121 board you need a cpld change to increment the address lines.=
=A0 With the cpld as shipped you end up reading bursts that have the first =
4 bytes repeated because the address lines do not increment.=A0 I don&#39;t=
 know if this is feature or bug with the 5121 but I do know you can work ar=
ound it in the cpld.<br>
<br>With burst access working you should be able to speed up the kernel cop=
y and also the jffs2 mount and filesystem access.<br><br>I also found that =
coping an uncompressed kernel was faster than decompressing a compressed ke=
rnel.=A0 But your mileage may vary if you have the data cache on.=A0 I foun=
d that working around all the problems with turning data cache on were goin=
g to take more time than I had.<br>
<br>John<br><br><div class=3D"gmail_quote">On Fri, May 29, 2009 at 2:30 PM,=
 John Rigby <span dir=3D"ltr">&lt;<a href=3D"mailto:jcrigby@gmail.com">jcri=
gby@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;">
Kenneth,<br><br>I did some fastboot work for 5121 a few months ago.=A0 U-bo=
ot, kernel and JFFS2 rootfs in NOR.=A0 My reset to userland time was 2.0 se=
conds, where userland was first command executed in first rc.whatever file,=
 so it included the time for /sbin/init to get up and start running the rc =
scripts.<br>

<br>I did some profiling and noticed that the JFFS2 boot time was a signifi=
cant hunk (not just the first time but everytime).=A0 I ran sumtool on the =
JFFS2 image and it dropped 600 ms from the boot time so my final time was 1=
.4 seconds.=A0 The sumtool program has been around for a few years but it w=
as news to mean when I found it.<br>
<font color=3D"#888888">
<br>John</font><div><div></div><div class=3D"h5"><br><br><div class=3D"gmai=
l_quote">On Fri, May 29, 2009 at 5:13 AM, Kenneth Johansson <span dir=3D"lt=
r">&lt;<a href=3D"mailto:kenneth@southpole.se" target=3D"_blank">kenneth@so=
uthpole.se</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<a href=3D"http://www.cambridgewireless.co.uk/news/article/default.aspx?obj=
id=3D36792" target=3D"_blank">http://www.cambridgewireless.co.uk/news/artic=
le/default.aspx?objid=3D36792</a><br>
<br>
Anybody know what they mean by booting here.<br>
<br>
I have started the ads5121 board using u-boot and kernel in NOR flash<br>
and root file system on a compact flash card connected to the IDE<br>
interface in 2.05 second until init is started from the rootfs.<br>
<br>
This was fast enough for what was needed I did not try to optimize<br>
further but since I already was in the domain where changes impacted<br>
only a few milliseconds I have a hard time imagining going down to less<br>
than a second.<br>
<br>
So I guess the only way is to skip u-boot and run linux kernel directly<br>
out of NOR. Anyone know what MontaVista is doing ??<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@ozlabs.org" target=3D"_blank">Linuxppc-dev@o=
zlabs.org</a><br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-dev" target=3D"_bla=
nk">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</blockquote></div><br>
</div></div></blockquote></div><br>

--000e0cd2e6e610f0b6046b1329d2--
