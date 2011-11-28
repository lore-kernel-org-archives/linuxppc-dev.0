Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F00AAB6F67
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 03:23:46 +1100 (EST)
Received: by vbbfp1 with SMTP id fp1so3030501vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 08:23:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
References: <20111125163557.5a464006@kryten>
 <F744714B-0527-415C-92BE-A5CB678F1C29@kernel.crashing.org>
Date: Mon, 28 Nov 2011 11:23:43 -0500
Message-ID: <CA+5PVA4kkeuWqdKWAJOJSUue=XsEC=27T2zptb-1P_H+HwNymg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Decode correct MSR bits in oops output
From: Josh Boyer <jwboyer@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2011 at 11:04 AM, Kumar Gala <galak@kernel.crashing.org> wr=
ote:
>
> On Nov 24, 2011, at 11:35 PM, Anton Blanchard wrote:
>
>>
>> On a 64bit book3s machine I have an oops from a system reset that
>> claims the book3e CE bit was set:
>>
>> MSR: 8000000000021032 <ME,CE,IR,DR> =A0CR: 24004082 =A0XER: 00000010
>>
>> On a book3s machine system reset sets IBM bit 46 and 47 depending on
>> the power saving mode. Separate the definitions by type and for
>> completeness add the rest of the bits in.
>>
>> Signed-off-by: Anton Blanchard <anton@samba.org>
>> ---
>>
>> Index: linux-build/arch/powerpc/kernel/process.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-build.orig/arch/powerpc/kernel/process.c =A0 =A02011-11-25 13:=
22:24.294919094 +1100
>> +++ linux-build/arch/powerpc/kernel/process.c 2011-11-25 13:36:23.213834=
524 +1100
>> @@ -584,16 +584,32 @@ static struct regbit {
>> =A0 =A0 =A0 unsigned long bit;
>> =A0 =A0 =A0 const char *name;
>> } msr_bits[] =3D {
>> +#if defined(CONFIG_PPC64) && !defined(CONFIG_BOOKE)
>> + =A0 =A0 {MSR_SF, =A0 =A0 =A0 =A0"SF"},
>> + =A0 =A0 {MSR_HV, =A0 =A0 =A0 =A0"HV"},
>> +#endif
>> + =A0 =A0 {MSR_VEC, =A0 =A0 =A0 "VEC"},
>> + =A0 =A0 {MSR_VSX, =A0 =A0 =A0 "VSX"},
>> +#ifdef CONFIG_BOOKE
>> + =A0 =A0 {MSR_CE, =A0 =A0 =A0 =A0"CE"},
>> +#endif
>> =A0 =A0 =A0 {MSR_EE, =A0 =A0 =A0 =A0"EE"},
>> =A0 =A0 =A0 {MSR_PR, =A0 =A0 =A0 =A0"PR"},
>> =A0 =A0 =A0 {MSR_FP, =A0 =A0 =A0 =A0"FP"},
>> - =A0 =A0 {MSR_VEC, =A0 =A0 =A0 "VEC"},
>> - =A0 =A0 {MSR_VSX, =A0 =A0 =A0 "VSX"},
>> =A0 =A0 =A0 {MSR_ME, =A0 =A0 =A0 =A0"ME"},
>> - =A0 =A0 {MSR_CE, =A0 =A0 =A0 =A0"CE"},
>> +#ifdef CONFIG_BOOKE
>> =A0 =A0 =A0 {MSR_DE, =A0 =A0 =A0 =A0"DE"},
>> +#else
>> + =A0 =A0 {MSR_SE, =A0 =A0 =A0 =A0"SE"},
>> + =A0 =A0 {MSR_BE, =A0 =A0 =A0 =A0"BE"},
>> +#endif
>> =A0 =A0 =A0 {MSR_IR, =A0 =A0 =A0 =A0"IR"},
>> =A0 =A0 =A0 {MSR_DR, =A0 =A0 =A0 =A0"DR"},
>> + =A0 =A0 {MSR_PMM, =A0 =A0 =A0 "PMM"},
>> +#ifndef CONFIG_BOOKE
>> + =A0 =A0 {MSR_RI, =A0 =A0 =A0 =A0"RI"},
>
> We have 'RI' on some BOOKE so lets allow for it to be decoded
>
>> + =A0 =A0 {MSR_LE, =A0 =A0 =A0 =A0"LE"},
>> +#endif
>> =A0 =A0 =A0 {0, =A0 =A0 =A0 =A0 =A0 =A0 NULL}
>> };
>
> Since you're fixing this can you add the following for CONFIG_BOOKE:
>
> MSR_GS, MSR_UCLE, MSR_PMM, MSR_CM

Those don't exist on 4xx, so CONFIG_BOOKE doesn't seem appropriate.

josh
