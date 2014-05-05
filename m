Return-Path: <olofj@google.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
 [209.85.212.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E27E1402CC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:55:02 +1000 (EST)
Received: by mail-wi0-f182.google.com with SMTP id r20so2369671wiv.15
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 May 2014 07:54:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5367A39D.9080709@suse.de>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
 <5367A39D.9080709@suse.de>
Date: Mon, 5 May 2014 07:54:58 -0700
Message-ID: <CALiw-2G2LL55WfZpDTrGr198W4uokcoZn5JxYNVYHbt4Bu_DhA@mail.gmail.com>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
From: Olof Johansson <olofj@google.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: multipart/alternative; boundary=f46d0442885eaaf27804f8a850f5
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--f46d0442885eaaf27804f8a850f5
Content-Type: text/plain; charset=UTF-8

2014-05-05 7:43 GMT-07:00 Alexander Graf <agraf@suse.de>:

> On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
>
>> Alexander Graf <agraf@suse.de> writes:
>>
>>  On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>
>>>> Although it's optional IBM POWER cpus always had DAR value set on
>>>> alignment interrupt. So don't try to compute these values.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> ---
>>>> Changes from V3:
>>>> * Use make_dsisr instead of checking feature flag to decide whether to
>>>> use
>>>>     saved dsisr or not
>>>>
>>>>  ....
>>
>>     ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
>>>>    {
>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>> +       return vcpu->arch.fault_dar;
>>>>
>>> How about PA6T and G5s?
>>>
>>>
>>>  Paul mentioned that BOOK3S always had DAR value set on alignment
>> interrupt. And the patch is to enable/collect correct DAR value when
>> running with Little Endian PR guest. Now to limit the impact and to
>> enable Little Endian PR guest, I ended up doing the conditional code
>> only for book3s 64 for which we know for sure that we set DAR value.
>>
>
> Yes, and I'm asking whether we know that this statement holds true for
> PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is at
> least developed by IBM, I'd assume its semantics here are similar to
> POWER4, but for PA6T I wouldn't be so sure.
>
>
Thanks for looking out for us, obviously IBM doesn't (based on the reply a
minute ago).

In the end, since there's been no work to enable KVM on PA6T, I'm not too
worried. I guess it's one more thing to sort out (and check for) whenever
someone does that.

I definitely don't have cycles to deal with that myself at this time. I can
help find hardware for someone who wants to, but even then I'm guessing the
interest is pretty limited.


-Olof

--f46d0442885eaaf27804f8a850f5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">2014=
-05-05 7:43 GMT-07:00 Alexander Graf <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:agraf@suse.de" target=3D"_blank" class=3D"cremed">agraf@suse.de</a>&gt;</=
span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Alexander Graf &lt;<a href=3D"mailto:agraf@suse.de" target=3D"_blank" class=
=3D"cremed">agraf@suse.de</a>&gt; writes:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Although it&#39;s optional IBM POWER cpus always had DAR value set on<br>
alignment interrupt. So don&#39;t try to compute these values.<br>
<br>
Signed-off-by: Aneesh Kumar K.V &lt;<a href=3D"mailto:aneesh.kumar@linux.vn=
et.ibm.com" target=3D"_blank" class=3D"cremed">aneesh.kumar@linux.vnet.ibm.=
<u></u>com</a>&gt;<br>
---<br>
Changes from V3:<br>
* Use make_dsisr instead of checking feature flag to decide whether to use<=
br>
=C2=A0 =C2=A0 saved dsisr or not<br>
<br>
</blockquote></blockquote>
....<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0 =C2=A0ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int=
 inst)<br>
=C2=A0 =C2=A0{<br>
+#ifdef CONFIG_PPC_BOOK3S_64<br>
+ =C2=A0 =C2=A0 =C2=A0 return vcpu-&gt;arch.fault_dar;<br>
</blockquote>
How about PA6T and G5s?<br>
<br>
<br>
</blockquote>
Paul mentioned that BOOK3S always had DAR value set on alignment<br>
interrupt. And the patch is to enable/collect correct DAR value when<br>
running with Little Endian PR guest. Now to limit the impact and to<br>
enable Little Endian PR guest, I ended up doing the conditional code<br>
only for book3s 64 for which we know for sure that we set DAR value.<br>
</blockquote>
<br>
Yes, and I&#39;m asking whether we know that this statement holds true for =
PA6T and G5 chips which I wouldn&#39;t consider IBM POWER. Since the G5 is =
at least developed by IBM, I&#39;d assume its semantics here are similar to=
 POWER4, but for PA6T I wouldn&#39;t be so sure.<br>
<br></blockquote><div><br></div><div>Thanks for looking out for us, obvious=
ly IBM doesn&#39;t (based on the reply a minute ago).</div><div><br></div><=
div>In the end, since there&#39;s been no work to enable KVM on PA6T, I&#39=
;m not too worried. I guess it&#39;s one more thing to sort out (and check =
for) whenever someone does that.</div>
<div><br></div><div>I definitely don&#39;t have cycles to deal with that my=
self at this time. I can help find hardware for someone who wants to, but e=
ven then I&#39;m guessing the interest is pretty limited.</div><div><br>
</div><div><br></div><div>-Olof=C2=A0</div></div><br></div></div>

--f46d0442885eaaf27804f8a850f5--
