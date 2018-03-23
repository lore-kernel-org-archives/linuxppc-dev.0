Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ot0-x232.google.com (mail-ot0-x232.google.com
 [IPv6:2607:f8b0:4003:c0f::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072mr3qlKzF1kn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:25:16 +1100 (AEDT)
Received: by mail-ot0-x232.google.com with SMTP id r30-v6so13012713otr.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 05:25:16 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-15-malat@debian.org>
 <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 23 Mar 2018 13:24:53 +0100
Message-ID: <CA+7wUsxVW1a2yvyhYv=YFNV1VEQCcro5JDN1RewghVaHDq5znw@mail.gmail.com>
Subject: Re: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 23, 2018 at 1:19 PM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 22/03/2018 =C3=A0 21:20, Mathieu Malaterre a =C3=A9crit :
>>
>> Some functions prototypes were missing for the non-altivec code. Add the
>> missing prototypes directly in xor_vmx, fix warnings treated as errors
>> with
>> W=3D1:
>>
>>    arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype fo=
r
>> =E2=80=98xor_altivec_2=E2=80=99 [-Werror=3Dmissing-prototypes]
>>    arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype fo=
r
>> =E2=80=98xor_altivec_3=E2=80=99 [-Werror=3Dmissing-prototypes]
>>    arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype fo=
r
>> =E2=80=98xor_altivec_4=E2=80=99 [-Werror=3Dmissing-prototypes]
>>    arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype fo=
r
>> =E2=80=98xor_altivec_5=E2=80=99 [-Werror=3Dmissing-prototypes]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
>> index 5c2b0839b179..2173e3c84151 100644
>> --- a/arch/powerpc/lib/xor_vmx.h
>> +++ b/arch/powerpc/lib/xor_vmx.h
>> @@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned lo=
ng
>> *v1_in,
>>   void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>>                              unsigned long *v2_in, unsigned long *v3_in,
>>                              unsigned long *v4_in, unsigned long *v5_in)=
;
>> +
>> +void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in);
>> +
>
>
> Only used in one place, should be static instead of adding it in a .h
>
> Same for the other ones.

$ git grep xor_altivec_2
[...]
arch/powerpc/lib/xor_vmx_glue.c:EXPORT_SYMBOL(xor_altivec_2);

Are you sure I can change this function to static ?

> Christophe
>
>
>> +void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in, unsigned long *v3_in)=
;
>> +
>> +void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in, unsigned long *v3_in,
>> +                            unsigned long *v4_in);
>> +
>> +void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>> +                            unsigned long *v2_in, unsigned long *v3_in,
>> +                            unsigned long *v4_in, unsigned long *v5_in)=
;
>>
>
> ---
> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
