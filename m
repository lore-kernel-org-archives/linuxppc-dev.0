Return-Path: <oohall@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405Ccb4fZ6zF1Yx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 23:56:47 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id e195-v6so2286631ita.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 05:56:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9jjf6jy.fsf@concordia.ellerman.id.au>
References: <20180319051403.23275-1-oohall@gmail.com>
 <20180319051403.23275-3-oohall@gmail.com>
 <87o9jjf6jy.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Tue, 20 Mar 2018 23:56:44 +1100
Message-ID: <CAOSf1CGFsAu_AufQ3BPqUc6ycLUnpi=oh+QGOtMnX6bcc27VuQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] powerpc/zImage: Check compatible at driver init
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2018 at 8:19 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
>> diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-psc.c
>> index c2c08633ee35..75470936e661 100644
>> --- a/arch/powerpc/boot/mpc52xx-psc.c
>> +++ b/arch/powerpc/boot/mpc52xx-psc.c
>> @@ -52,6 +52,9 @@ static unsigned char psc_getc(void)
>>
>>  int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp)
>>  {
>> +     if (!dt_is_compatible(devp, "fsl,mpc5200-psc-uart"))
>> +             return 1;
>
> Returning 1 raises the question of whether this is a bool-style function
> that returns 1 on success and 0 on failure - or a UNIX style function
> that returns 0 for sucesss and 1 on failure.
>
> Can we return ENODEV, or just -1 instead to make it clearer?

I figured we would want to differentiate between a mis-matched driver
and any other error type. There's no existing definition of ENODEV and
friends in the wrapper so I just used positive 1 as a half-assed
workaround. I don't have particularly strong feelings about it so
adding an explicit ENODEV would make things a bit cleaner. I'll fix it
on the respin.

>
> cheers
