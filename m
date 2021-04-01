Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ADC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 03:13:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3AC600D1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 03:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3AC600D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9pDK3wYLz3by1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 14:13:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=b/JcESCS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::231;
 helo=mail-lj1-x231.google.com; envelope-from=sxwjean@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=b/JcESCS; dkim-atps=neutral
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9nrH4CNyz2xfk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 13:56:14 +1100 (AEDT)
Received: by mail-lj1-x231.google.com with SMTP id z8so569420ljm.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 19:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EXCc4dNLHnTWxr3bOfiC/uY6ghCk/2gsVTZC4wiTQgA=;
 b=b/JcESCSrpsGvf6jXJRluS+qoxEiHx6maWn6wIv5koq8ozPk6g5YoEMydfl7HLiIVD
 9rb6Kshs66knQLkU67c/AoCFWpM7pcB/TOCL2hTEyeBk8EN2szfXwWUJEGI8xjerGiCV
 CU3KE71rXEjPhfLpK0397dR0ClwSNHoFhNOfoQ8OasDV1LZS8LMmHl6TfzFjjvVaEqF2
 BzrgeYDmC27c+SaPjZ96WCpsz4Bhl/N14QtvJ0gkgOcUvr+jDLNO6EfAgGRL33ROKznz
 JFeKgMlz7rdXIs0kFAISeCcRdI1haX4bHegnCCyqhmMUetTuTrLTY0HM37080XngSe6L
 nL6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EXCc4dNLHnTWxr3bOfiC/uY6ghCk/2gsVTZC4wiTQgA=;
 b=cF6yupK1jV0ofWm5RqlwwQcJq8hhdC9VCyeKUfWKX2yTVCxEoKcbdoE3nOCUz3Fmgr
 4djOmZP/UjN+ucXcX5tsit8pZL2onC3XTzLuOCmndCs5Q39+/ow5ggNfyUywz1uWQukh
 3IIFQansJzpGa4N5U2JdeGg0kFzadowIzZoPTPFSr5NzLnagwUCeGz7ofmlW6nGV7Lvb
 vE+EundCOdKVFD/Lly4S5lzs+sB2LxtDEE2Iuvg4HiWQgBH5Mh64BAI0aEZ9F4q5CLPy
 KmRpD7SqQkYb/55ECgvNnxk87q/WLrEQSbZ581p+fWWiIG5LX/Btf1cq/bLeNusjZDaj
 5LJg==
X-Gm-Message-State: AOAM532eqSGEKUS4kfvsD0+s/jZbKeLLDmM28HZRcCg59J+u/PxCfRoO
 gZDWSwkbLRnAvYS5iwShxnj++HHVJU3LhmI1rDg=
X-Google-Smtp-Source: ABdhPJxmF97PiCnzT1aHG2DmkxxV1f2v3PqKM8C8iC+ALyJ4RwBW0tOidA4rFhYsnXzdOQeAVjjxdx0oDeTwyL7Lf/c=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr4045797ljj.11.1617245769515; 
 Wed, 31 Mar 2021 19:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210330150425.10145-1-sxwjean@me.com>
 <875z17y79i.fsf@mpe.ellerman.id.au>
 <20210331212550.GD13863@gate.crashing.org>
In-Reply-To: <20210331212550.GD13863@gate.crashing.org>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Thu, 1 Apr 2021 10:55:58 +0800
Message-ID: <CAEVVKH8XDiEGHjXj6sJAHynhwqKWpNqj_Ws03AqwNjR8OmHf5w@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/traps: Enhance readability for trap types
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: multipart/alternative; boundary="0000000000009b43d305bee05f16"
X-Mailman-Approved-At: Thu, 01 Apr 2021 14:12:45 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: pmladek@suse.com, peterz@infradead.org, peterx@redhat.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, kan.liang@linux.intel.com,
 leobras.c@gmail.com, mikey@neuling.org, maddy@linux.ibm.com,
 aneesh.kumar@linux.ibm.com, haren@linux.ibm.com, aik@ozlabs.ru,
 kjain@linux.ibm.com, msuchanek@suse.de, ravi.bangoria@linux.ibm.com,
 john.ogness@linutronix.de, alistair@popple.id.au, npiggin@gmail.com,
 kvm-ppc@vger.kernel.org, jniethe5@gmail.com, atrajeev@linux.vnet.ibm.com,
 Xiongwei Song <sxwjean@me.com>, oleg@redhat.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, rppt@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--0000000000009b43d305bee05f16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Segher Boessenkool <segher@kernel.crashing.org> =E4=BA=8E2021=E5=B9=B44=E6=
=9C=881=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:15=E5=86=99=E9=81=93=
=EF=BC=9A

> On Wed, Mar 31, 2021 at 08:58:17PM +1100, Michael Ellerman wrote:
> > So perhaps:
> >
> >   EXC_SYSTEM_RESET
> >   EXC_MACHINE_CHECK
> >   EXC_DATA_STORAGE
> >   EXC_DATA_SEGMENT
> >   EXC_INST_STORAGE
> >   EXC_INST_SEGMENT
> >   EXC_EXTERNAL_INTERRUPT
> >   EXC_ALIGNMENT
> >   EXC_PROGRAM_CHECK
> >   EXC_FP_UNAVAILABLE
> >   EXC_DECREMENTER
> >   EXC_HV_DECREMENTER
> >   EXC_SYSTEM_CALL
> >   EXC_HV_DATA_STORAGE
> >   EXC_PERF_MONITOR
>
> These are interrupt (vectors), not exceptions.  It doesn't matter all
> that much, but confusing things more isn't useful either!  There can be
> multiple exceptions that all can trigger the same interrupt.
>
>  When looking at the reference manual of e500 and e600 from NXP
 official, they call them as interrupts.While looking at the "The
Programming Environments"
 that is also from NXP, they call them exceptions. Looks like there is
 no explicit distinction between interrupts and exceptions.

Here are the links for the reference manual of e600 and e500:
https://www.nxp.com.cn/docs/en/reference-manual/E600CORERM.pdf
https://www.nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf

Here is the "The Programming Environments" link:
https://www.nxp.com.cn/docs/en/user-guide/MPCFPE_AD_R1.pdf

As far as I know, the values of interrupts or exceptions above are defined
explicitly in reference manual or the programming environments. Could
you please provide more details about multiple exceptions with the same
interrupts?

Xiongwei

--0000000000009b43d305bee05f16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_sign=
ature" data-smartmail=3D"gmail_signature"><br></div></div></div><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Segher Boessenkool &=
lt;<a href=3D"mailto:segher@kernel.crashing.org">segher@kernel.crashing.org=
</a>&gt; =E4=BA=8E2021=E5=B9=B44=E6=9C=881=E6=97=A5=E5=91=A8=E5=9B=9B =E4=
=B8=8A=E5=8D=886:15=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On Wed, Mar 31, 2021 at 08:58:17PM +1100, =
Michael Ellerman wrote:<br>
&gt; So perhaps:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0EXC_SYSTEM_RESET<br>
&gt;=C2=A0 =C2=A0EXC_MACHINE_CHECK<br>
&gt;=C2=A0 =C2=A0EXC_DATA_STORAGE<br>
&gt;=C2=A0 =C2=A0EXC_DATA_SEGMENT<br>
&gt;=C2=A0 =C2=A0EXC_INST_STORAGE<br>
&gt;=C2=A0 =C2=A0EXC_INST_SEGMENT<br>
&gt;=C2=A0 =C2=A0EXC_EXTERNAL_INTERRUPT<br>
&gt;=C2=A0 =C2=A0EXC_ALIGNMENT<br>
&gt;=C2=A0 =C2=A0EXC_PROGRAM_CHECK<br>
&gt;=C2=A0 =C2=A0EXC_FP_UNAVAILABLE<br>
&gt;=C2=A0 =C2=A0EXC_DECREMENTER<br>
&gt;=C2=A0 =C2=A0EXC_HV_DECREMENTER<br>
&gt;=C2=A0 =C2=A0EXC_SYSTEM_CALL<br>
&gt;=C2=A0 =C2=A0EXC_HV_DATA_STORAGE<br>
&gt;=C2=A0 =C2=A0EXC_PERF_MONITOR<br>
<br>
These are interrupt (vectors), not exceptions.=C2=A0 It doesn&#39;t matter =
all<br>
that much, but confusing things more isn&#39;t useful either!=C2=A0 There c=
an be<br>
multiple exceptions that all can trigger the same interrupt.<br>
<br></blockquote><div>=C2=A0When looking at the reference manual of e500 an=
d e600 from NXP</div><div>=C2=A0official, they call them as interrupts.Whil=
e looking at the &quot;The Programming Environments&quot;</div><div>=C2=A0t=
hat is also from NXP, they call them exceptions. Looks like there is</div><=
div>=C2=A0no explicit distinction between interrupts and exceptions.=C2=A0<=
/div><br>Here are the links for the reference manual of e600 and e500:</div=
><div class=3D"gmail_quote"><a href=3D"https://www.nxp.com.cn/docs/en/refer=
ence-manual/E600CORERM.pdf">https://www.nxp.com.cn/docs/en/reference-manual=
/E600CORERM.pdf</a></div><div class=3D"gmail_quote"><a href=3D"https://www.=
nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf">https://www.nxp.com/=
files-static/32bit/doc/ref_manual/EREF_RM.pdf</a><br><br></div><div class=
=3D"gmail_quote">Here is the &quot;The Programming Environments&quot; link:=
</div><div class=3D"gmail_quote"><a href=3D"https://www.nxp.com.cn/docs/en/=
user-guide/MPCFPE_AD_R1.pdf">https://www.nxp.com.cn/docs/en/user-guide/MPCF=
PE_AD_R1.pdf</a></div><div class=3D"gmail_quote"><br></div><div class=3D"gm=
ail_quote">As far as I know, the values of interrupts or exceptions above a=
re defined</div><div class=3D"gmail_quote">explicitly in reference manual o=
r the programming environments. Could</div><div class=3D"gmail_quote">you p=
lease provide more details about multiple exceptions with the same</div><di=
v class=3D"gmail_quote">interrupts?=C2=A0</div><div class=3D"gmail_quote"><=
br></div><div class=3D"gmail_quote">Xiongwei</div></div>

--0000000000009b43d305bee05f16--
