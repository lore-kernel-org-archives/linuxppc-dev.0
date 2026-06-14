Return-Path: <linuxppc-dev+bounces-22613-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614ADCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jun 2026 19:04:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdjNB2cGMz2yFc;
	Mon, 15 Jun 2026 05:04:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781463850;
	cv=pass; b=mvjQ1juxRPoqvFbIOCvkIRxKhTbMzD8rP7k+R1mU4OytL4cId+7uevNEExyKHIxFWjY/6I3wp65EziRHak3wnVofkOH6WRsyvKEuiGBGLXk+Ir4MpK6nUFoKLaaK/CTCevh1JcLuDlALYSRIr4jPVmFSuNyhy5kSDWD2EampoeqMwZcwbX/U1pCpAmxQ3aOaGRdiAhqp/4jIncIXfKf//buvrJ+f356KReppOMBdsdaDrQjVKRmn+1ImJWgZL4NqJ+OoA2bLZ6QUtvGkRFDaZdGF2orv4scS6USNmyTpNJPCly9qtYSu+AKU8sSxSyFWpcVvAPXO6ZjN3dVY5lXm6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781463850; c=relaxed/relaxed;
	bh=JaE1dAP+QUxyb/PuM4ua6j3vVvRINrBklaaNqphjGs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO+txVDdsCfIxH+iWF3tiCLvS4wdLScsbyH0W+5rotfN1pJIr6aJI+ArU9EccZrn0qI0sFquHP0tGLpk3GMueeCxJk3pjH54cslVD/fGjIkK9Y90hFmV9+vYITmyfKPEGXgF+FLe63RARrv+15ycvHfaC6cGFYQUw16NmDESXPYcALWY7H5jV8JVN5tely/UQcfFp/QQlooBQLP5GHqvcO1nbwP9DD8UtISQ5a96iTOTFTOmaQ5ntRcAettxs4q7sRCopysXzGpXKvc6K/I2wTrsEVQ5UI4u7pOG5+xgfdEc0btZrWdyx+NpWWGZ+XMBrGy41pn+/XYCCtywRf8z9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qh7pf0tp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=randrianasulu@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Qh7pf0tp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=randrianasulu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdjN72Qhpz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 05:04:06 +1000 (AEST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-7e2f3646c10so28604547b3.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jun 2026 12:04:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781463844; cv=none;
        d=google.com; s=arc-20240605;
        b=b+bBteInv3729uSUn9ROpjFZfzT05b6YnQeeY0YagFg4epFHjOSKnCIyzLyj4HYHZ9
         4Xnn+sBlJlfw5ESIrmJxVT0iAc29k6Pb44VssGisZG/hgllIdf0RMS+qyT88NuZyqZSg
         fEhaSb3ygVevBvyHVhi3nw/TuQXqF76BOKWHCRtVU7J4kaI3J4XNR5ElYkXv+ww5n28d
         +Rq5PLtJRXDWYCp4t5J1PurSd4Lnq+cSmIZ60Hb4C4GA4PiUBsocKN3MoMKdkXL8YgSm
         dTmtwhcUcJL6/0+WVy26JEQfknuQ1lZ4pzTmbjYbAqIuYN9hi8zg7nJWAVKmYJ6ha+Rc
         EVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JaE1dAP+QUxyb/PuM4ua6j3vVvRINrBklaaNqphjGs4=;
        fh=2hQd2doMvpL/jle13SbGPu+lDaIK4VH7Xqtcn4pRwko=;
        b=aoNoTUGIWzLzRlPmB/oz985EIZmqjmO9DkMJrBa49LsA70p0Wlg6HTpQzlFFTKTXW9
         z6cefojaCizJlfJyGu1RT5NDp+HmqV9fHoLeMbd9fkjee4TxMg9+NB8hoEYzK9rti0Bo
         zP6pdO7onld8VZr7urZEXF39oMYs8RnWGBVrndBJCDGvhQ3QphOWHDtHwZ7Ve5kx5x3e
         ydrS+FyR+FS5oMvTqvFHayWKiyFV40Nryy3YIZ39o6sjtClGRVHTr6SH1+F0Hnbi/VlX
         RxriTjqpFQm1iv1D8rfvMuKb1kqKVdINW5+sFdqt+WAIufzX+T6MjCVfVFrd/TXKgYJ0
         9cFw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781463844; x=1782068644; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JaE1dAP+QUxyb/PuM4ua6j3vVvRINrBklaaNqphjGs4=;
        b=Qh7pf0tpCZEywqkV0I71FMVrFkFHTIOfPLzNWH0NqFpiOOv/XKMPTXsbVY6qyuYY3j
         9YtoUhVjP1gu4ZdxCKiyo/LMAwTzjKSxfWvoWmKHgGdjIfXegDwTfn4tgmanoxbtWr6I
         1leCI4aa49kLEDaePcds6myXh48O6fEo/Ih7q4j43jLhzUmb+Lo9EnhW5NiqaRu+CIIv
         CSzBDhqotn+9PhFQKNr7pFOR1EKiNTBj1PNMnXZ7LJIA0ugcTVHk7ADKtTjXMm7d1HLA
         crQUXSh6jm5Fj6HG2w/nlsxTlZFEEDOdPG69rSTbvE32UivvfpTdSPY69kj5tDdaVXNI
         18CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781463844; x=1782068644;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaE1dAP+QUxyb/PuM4ua6j3vVvRINrBklaaNqphjGs4=;
        b=QDdTgvkwVzj/FQmQNJq/j8OvJN7ZJMulV+5QN0G1PzLNTwb+m1AINqKrC5bfkzVgHC
         9pHdm9753jypXurl0GMXaUu2WSTZOryjClay1TV55W4PC3lWXr4NbY3gKjzkj07/R+8y
         ryMOGTnAQ/lY8Ka9mdwwXhiWt0AisaRdLsMweNgOFnmPF96O+TlnkYQLdcfT4kJpWrNg
         oZlvxD+iIzblUd3TZkpw8cj/czwbHwUE5ES5dKlKfFbpMp+6ReX00b4tq03j6doB5/TJ
         BNLdQqcOKMj0sS7BrlYXXzLn9DRnbBtGaMPSOvTLLrCZofd3uR+N9VTXd59Du2BSscvv
         W1HQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XFbKGX+yIsN82Knralo47xUl9DdSnsCcT9EeemE9K62MdN8osPXjKWZpLl4puJfTGmSyvlosQaQK4waI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMBgD62F/jJTnqt7K47DEErIpmwghoC1LHOqSxMWciIzGBiyXk
	rR289PipRRu967KEKopOSTbym4PruC5ELiAqoInicx2VmzJWg9+8/kbytEwA9F75ETt1LxkjQdf
	+vfkeXyt2KiXMwnbsGwQQ1whcQD5B0peA20oN
X-Gm-Gg: Acq92OH5ssgqFZv5QlgzaR2IWdwm68bTlJ+PBQFWs7IF2KJ5S5CKuhIJ+4cpkXd5mJp
	MPek5tlNB1O5WhVhnplzUvxh86QoGlzP1BsDjs3MlAhdqWEcoD1e/nhZj0uYQlmzoG1BtTocygA
	AfMlBIuyEiMYgIt9FleH5Md4U1o06d4/lXJEWlhdO2BKjUE5qBLM+n+xLJyP7+tqd+GhObCsT+f
	zXmRc0sIOjseByt8s12cPyh5YyzoKRb65nJ7cet5WEI6B4S/0oBZwMBfsmKnh0X8g6PALEeZogf
	JH+k4wGiJA==
X-Received: by 2002:a05:690c:e36e:b0:7dc:f7b3:8e08 with SMTP id
 00721157ae682-7f7b7d32bebmr107685727b3.23.1781463843581; Sun, 14 Jun 2026
 12:04:03 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <CA+rFky7UDpHYFXvEiq91dpnfLuKCiaONctmW-q2jONmNG25Wow@mail.gmail.com>
 <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu>
In-Reply-To: <418f045e-7aaf-c48b-4f08-018625b2c3e6@eik.bme.hu>
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Sun, 14 Jun 2026 22:03:50 +0300
X-Gm-Features: AVVi8Cd5TNRWdacIMM7k9VBQTSCGF7hZUXyDiwM7Swsmqc-ABDuzNE6B_FBU-zU
Message-ID: <CA+rFky73KGYwJRBuEBqFA1dKkDk0_W+u4VQL9bg2n1_AkeOU3g@mail.gmail.com>
Subject: Re: Does kvm_pr work on G5 mac with host kernel 6.12.xx ?
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000093b3d806543b5f49"

--00000000000093b3d806543b5f49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=81, 14 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 17:29 BALATON Zoltan <ba=
laton@eik.bme.hu>:

> On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:
> > I tried qemu 10.0.10 (qemu-system-ppc) compiled as ppc32 binary - fail
> >
> > I tried qemu 2.2.0 compiled as ppc64 binary (qemu-system-ppc and ppc64
> > variants) -fail
> >
> > I tried qemu 5.0.0 compiled as 32bit ppc (qemu-system-ppc) - fail.
> >
> > I tried qemu 6.1.1 compiled as 32bit ppc binary - qemu-system-ppc. Fail=
.
> >
> > I tried recompiling host kernel without preemtion - still fail.
> >
> > :(
> >
> > fail like this in dmesg
> >
> > [75573.287328] Couldn't emulate instruction 0x00000000 (op 0 xop 0)
> >                        [75573.287334] kvmppc_exit_pr_progint: emulation
> at
> > 100 failed (00000000)
> >
> >
> > lscpu output:
> > Architecture:                ppc64
> >
> > CPU op-mode(s):            32-bit, 64-bit
> > Byte Order:                Big Endian
> > CPU(s):                      2
> >
> > On-line CPU(s) list:       0,1
> >
> > Model name:                  PPC970MP, altivec supported
> > Model:                     1.1 (pvr 0044 0101)
> [...]
> > Why so old qemu? Well, it worked on OSX Leopard 10.5.8 on same machine,
> so
> > I compiled it as 64bit ppc64 binary - new qemu grow a lot  ... and
> keeping
> > effectively 3 different dev systems makes this 160 gb hdd look small :)
>
> I don't know about it but I think the only combination that ever worked
> was ppc on ppc (i.e. KVM on G4 Macs) or maybe ppc64 on ppc64. Running ppc
> on ppc64 is known not to work and I haven't heard about anybody fixing
> that. There was a blog entry about running MacOS on Power10:
>
> https://www.talospace.com/2018/08/making-your-talos-ii-into-power-mac_29.=
html
> but I think that was on ppc64le (which does not work on G5 as that's big
> endian only) and you still needed a guest kernel that could handle the G5
> due to different cache line size that affects at least dcbz which is used
> to clear memory so unless that's correctly emulated by KVM it may clear
> more bytes than intended and break.
>

https://forum.hyperion-entertainment.com/viewtopic.php?t=3D4736&start=3D141=
0

I thought this picture showed ppc64 kernel at host (not mac, neo amiga) and
qemu-system-ppc with non-obvious bitness?


> So considering the above, what may work is if you run a 32 bit ppc kernel
> (G4 version) on your G5 for the host not using it as 64 bit instead of
> ppc64 kernel and try a guest kernel that detects G5 CPU and knows how to
> handle the different cache line size.


Are you saying 32bit *Linux* ppc kvm as host can handle 64bit guest kernel =
?

I am not ever sure firmware here can load 32bit ppc Linux .. I'll try of
course.


Or find and fix the emulation of
> different instructions on ppc64 in Linux KVM when running 32 bit ppc code
> on 64 but host. There supposed to be some support for that but maybe it's
> broken or never finished.
>
> But as I said I don't know this and don't have PPC hardware to try, nor
> interest to do it so it's just my understanding and guess, which may be
> wrong, but that's probably where you should start looking. Hopefully ther=
e
> are others here with more knowledge about it or who want to look at it.
> You should also look at how to enable KVM debug logs in Linux kernel and
> see if you get any errors in the syslog. The usual QEMU debug options are
> not that helpful with KVM and you should look for KVM logs instead.
>

In theory I subscribed to linux-ppc (kernel) list. May be I should cc them
? (added to cc)

I tried kvm-unit-tests but they apparently require qemu (to my surprise!)
and mostly focus on pseries / kvm HV (not surprisingly)?

Is there anything smaller to test kvm_pr specifically?

I even tried to d/l svn version of Mac on Linux but this one failed to
compile with gcc 15.

svn checkout svn://svn.code.sf.net/p/mac-on-linux/code/trunk
mac-on-linux-code



> Regards,
> BALATON Zoltan
>

--00000000000093b3d806543b5f49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">=D0=B2=D1=81, 14 =D0=B8=D1=8E=D0=BD. 2026 =D0=B3., 17:=
29 BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_blan=
k" rel=3D"noreferrer">balaton@eik.bme.hu</a>&gt;:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">On Sun, 14 Jun 2026, Andrew Randrianasulu wrote:<br>
&gt; I tried qemu 10.0.10 (qemu-system-ppc) compiled as ppc32 binary - fail=
<br>
&gt;<br>
&gt; I tried qemu 2.2.0 compiled as ppc64 binary (qemu-system-ppc and ppc64=
<br>
&gt; variants) -fail<br>
&gt;<br>
&gt; I tried qemu 5.0.0 compiled as 32bit ppc (qemu-system-ppc) - fail.<br>
&gt;<br>
&gt; I tried qemu 6.1.1 compiled as 32bit ppc binary - qemu-system-ppc. Fai=
l.<br>
&gt;<br>
&gt; I tried recompiling host kernel without preemtion - still fail.<br>
&gt;<br>
&gt; :(<br>
&gt;<br>
&gt; fail like this in dmesg<br>
&gt;<br>
&gt; [75573.287328] Couldn&#39;t emulate instruction 0x00000000 (op 0 xop 0=
)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 [75573.287334] kvmppc_exit_pr_progint: emulation at<br>
&gt; 100 failed (00000000)<br>
&gt;<br>
&gt;<br>
&gt; lscpu output:<br>
&gt; Architecture:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 p=
pc64<br>
&gt;<br>
&gt; CPU op-mode(s):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 32-bit, 64-bi=
t<br>
&gt; Byte Order:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Big=
 Endian<br>
&gt; CPU(s):=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 2<br>
&gt;<br>
&gt; On-line CPU(s) list:=C2=A0 =C2=A0 =C2=A0 =C2=A00,1<br>
&gt;<br>
&gt; Model name:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 PPC970MP, altivec supported<br>
&gt; Model:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A01.1 (pvr 0044 0101)<br>
[...]<br>
&gt; Why so old qemu? Well, it worked on OSX Leopard 10.5.8 on same machine=
, so<br>
&gt; I compiled it as 64bit ppc64 binary - new qemu grow a lot=C2=A0 ... an=
d keeping<br>
&gt; effectively 3 different dev systems makes this 160 gb hdd look small :=
)<br>
<br>
I don&#39;t know about it but I think the only combination that ever worked=
 <br>
was ppc on ppc (i.e. KVM on G4 Macs) or maybe ppc64 on ppc64. Running ppc <=
br>
on ppc64 is known not to work and I haven&#39;t heard about anybody fixing =
<br>
that. There was a blog entry about running MacOS on Power10: <br>
<a href=3D"https://www.talospace.com/2018/08/making-your-talos-ii-into-powe=
r-mac_29.html" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">h=
ttps://www.talospace.com/2018/08/making-your-talos-ii-into-power-mac_29.htm=
l</a> <br>
but I think that was on ppc64le (which does not work on G5 as that&#39;s bi=
g <br>
endian only) and you still needed a guest kernel that could handle the G5 <=
br>
due to different cache line size that affects at least dcbz which is used <=
br>
to clear memory so unless that&#39;s correctly emulated by KVM it may clear=
 <br>
more bytes than intended and break.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><a href=3D"https://forum.hyperion-entert=
ainment.com/viewtopic.php?t=3D4736&amp;start=3D1410" target=3D"_blank" rel=
=3D"noreferrer">https://forum.hyperion-entertainment.com/viewtopic.php?t=3D=
4736&amp;start=3D1410</a></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">I thought this picture showed ppc64 kernel at host (not mac, neo amiga) a=
nd qemu-system-ppc with non-obvious bitness?</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
So considering the above, what may work is if you run a 32 bit ppc kernel <=
br>
(G4 version) on your G5 for the host not using it as 64 bit instead of <br>
ppc64 kernel and try a guest kernel that detects G5 CPU and knows how to <b=
r>
handle the different cache line size. </blockquote></div></div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Are you saying 32bit *Linux* ppc kvm as h=
ost can handle 64bit guest kernel ?</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">I am not ever sure firmware here can load 32bit ppc Linux .. I&=
#39;ll try of course.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Or find and fix the emulation of <br>
different instructions on ppc64 in Linux KVM when running 32 bit ppc code <=
br>
on 64 but host. There supposed to be some support for that but maybe it&#39=
;s <br>
broken or never finished.<br>
<br>
But as I said I don&#39;t know this and don&#39;t have PPC hardware to try,=
 nor <br>
interest to do it so it&#39;s just my understanding and guess, which may be=
 <br>
wrong, but that&#39;s probably where you should start looking. Hopefully th=
ere <br>
are others here with more knowledge about it or who want to look at it. <br=
>
You should also look at how to enable KVM debug logs in Linux kernel and <b=
r>
see if you get any errors in the syslog. The usual QEMU debug options are <=
br>
not that helpful with KVM and you should look for KVM logs instead.<br></bl=
ockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">In theor=
y I subscribed to linux-ppc (kernel) list. May be I should cc them ? (added=
 to cc)</div><div dir=3D"auto"><br></div><div dir=3D"auto">I tried kvm-unit=
-tests but they apparently require qemu (to my surprise!) and mostly focus =
on pseries / kvm HV (not surprisingly)?</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Is there anything smaller to test kvm_pr specifically?</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">I even tried to d/l svn vers=
ion of Mac on Linux but this one failed to compile with gcc 15.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">svn checkout svn://<a href=3D"http:=
//svn.code.sf.net/p/mac-on-linux/code/trunk">svn.code.sf.net/p/mac-on-linux=
/code/trunk</a> mac-on-linux-code</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
Regards,<br>
BALATON Zoltan<br>
</blockquote></div></div></div>

--00000000000093b3d806543b5f49--

