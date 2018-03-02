Return-Path: <bharata.rao@gmail.com>
Received: from mail-oi0-x22b.google.com (mail-oi0-x22b.google.com
 [IPv6:2607:f8b0:4003:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zt29K4tLTzF1nx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 19:12:53 +1100 (AEDT)
Received: by mail-oi0-x22b.google.com with SMTP id f186so6495953oig.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Mar 2018 00:12:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302022144.GG13135@umbus.fritz.box>
References: <CAGZKiBoy5kZxijbGg0VaRr_HbgPyoHS-UnkXyhHt15sCpcT4ow@mail.gmail.com>
 <20180302022144.GG13135@umbus.fritz.box>
From: Bharata B Rao <bharata.rao@gmail.com>
Date: Fri, 2 Mar 2018 13:42:49 +0530
Message-ID: <CAGZKiBrkxuzBsvOm_KbqCcEeJnPqqF2dLBcEYumdiBYAKdiLmQ@mail.gmail.com>
Subject: Re: Hotplug + Reboot is crashing HPT guest with HPT resizing enabled
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: multipart/alternative; boundary="001a113cd4b6cdce0a0566698a40"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113cd4b6cdce0a0566698a40
Content-Type: text/plain; charset="UTF-8"

On Fri, Mar 2, 2018 at 7:51 AM, David Gibson <david@gibson.dropbear.id.au>
wrote:

> On Fri, Feb 23, 2018 at 03:02:40PM +0530, Bharata B Rao wrote:
> > Hi,
> >
> > Rebooting a hash guest after hotplugging memory to it is crashing the
> > guest. This is seen only when HPT resizing is enabled. I see guest
> crashing
> > at multiple places, but this location is fairly commonly seen:
> >
> > kernel BUG at mm/slub.c:3912!
> >
> > Testing with latest guest kernel and ppc-for-2.12 branch of QEMU.
>
> Ugh.  We had several bugs along these lines, but I thought I'd fixed
> them.  I wonder what this one is.
>
> > A bit of debugging shows me that when memory is added, the guest kernel
> > tries to resize HPT to a htab_shift value lesser than the value with
> which
> > the guest has booted. For eg. a 8GB guest boots with htab_shift of 26.
> When
> > 1G is hot-added,
> > arch/powerpc/mm/hash_utils_64.c:resize_hpt_for_hotplug() ends up
> assigning
> > 24 to target_hpt_shift. This looks suspicious as we are increasing the
> > memory, but kernel is asking for shrinking the HPT size.
>
> So the shrink-HPT-on-add-memory is actually expected and should be
> harmless.  It occurs because qemu estimates HPT size on the
> traditional HPT == RAM size / 64 formular, which was devised with 4k
> pages in mind.  The kernel on the other hand, knows it is using 64k
> pages and so estimates a smaller HPT size.  Hot plugging memory always
> prompts the guest to re-estimate the required HPT size, but if the
> added memory is small enough, that size can still be smaller than
> qemu's initial guess.
>

Thanks for the clarification.


>
> > HPT resizing
> > requests fail though, but next reboot crashes the guest.
>
> As noted the shrink is expected, so we need to debug the crash
> separately.  Do you have 9478956794c11239b7c1c3ef9ce95c883bb839a3 in
> your tree?
>

I do now and I no longer see the crash that I was observing last week.

Regards,
Bharata.

--001a113cd4b6cdce0a0566698a40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Mar 2, 2018 at 7:51 AM, David Gibson <span dir=3D"ltr">&lt;<a href=
=3D"mailto:david@gibson.dropbear.id.au" target=3D"_blank">david@gibson.drop=
bear.id.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D"">On Fri, Feb 23, 2018 at 03:02:40PM +0530, Bharata B Rao wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; Rebooting a hash guest after hotplugging memory to it is crashing the<=
br>
&gt; guest. This is seen only when HPT resizing is enabled. I see guest cra=
shing<br>
&gt; at multiple places, but this location is fairly commonly seen:<br>
&gt;<br>
&gt; kernel BUG at mm/slub.c:3912!<br>
&gt;<br>
&gt; Testing with latest guest kernel and ppc-for-2.12 branch of QEMU.<br>
<br>
</span>Ugh.=C2=A0 We had several bugs along these lines, but I thought I&#3=
9;d fixed<br>
them.=C2=A0 I wonder what this one is.<br>
<span class=3D""><br>
&gt; A bit of debugging shows me that when memory is added, the guest kerne=
l<br>
&gt; tries to resize HPT to a htab_shift value lesser than the value with w=
hich<br>
&gt; the guest has booted. For eg. a 8GB guest boots with htab_shift of 26.=
 When<br>
&gt; 1G is hot-added,<br>
&gt; arch/powerpc/mm/hash_utils_64.<wbr>c:resize_hpt_for_hotplug() ends up =
assigning<br>
&gt; 24 to target_hpt_shift. This looks suspicious as we are increasing the=
<br>
&gt; memory, but kernel is asking for shrinking the HPT size.<br>
<br>
</span>So the shrink-HPT-on-add-memory is actually expected and should be<b=
r>
harmless.=C2=A0 It occurs because qemu estimates HPT size on the<br>
traditional HPT =3D=3D RAM size / 64 formular, which was devised with 4k<br=
>
pages in mind.=C2=A0 The kernel on the other hand, knows it is using 64k<br=
>
pages and so estimates a smaller HPT size.=C2=A0 Hot plugging memory always=
<br>
prompts the guest to re-estimate the required HPT size, but if the<br>
added memory is small enough, that size can still be smaller than<br>
qemu&#39;s initial guess.<br></blockquote><div><br></div><div>Thanks for th=
e clarification.<br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; HPT resizing<br>
&gt; requests fail though, but next reboot crashes the guest.<br>
<br>
</span>As noted the shrink is expected, so we need to debug the crash<br>
separately.=C2=A0 Do you have 9478956794c11239b7c1c3ef9ce95c<wbr>883bb839a3=
 in<br>
your tree?<br></blockquote><div><br></div><div>I do now and I no longer see=
 the crash that I was observing last week.<br><br></div><div>Regards,<br></=
div><div>Bharata.</div></div></div></div>

--001a113cd4b6cdce0a0566698a40--
