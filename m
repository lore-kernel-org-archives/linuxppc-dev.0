Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49CE71A0681
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 20:21:11 +1100 (AEDT)
Received: from mail-yk0-f173.google.com (mail-yk0-f173.google.com
 [209.85.160.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ADD6B14076B
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2015 20:21:10 +1100 (AEDT)
Received: by yknn9 with SMTP id n9so68380921ykn.0
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2015 02:21:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445159851.4271.1.camel@ellerman.id.au>
References: <1445106671-5028-1-git-send-email-kda@linux-powerpc.org>
 <1445159851.4271.1.camel@ellerman.id.au>
Date: Sun, 18 Oct 2015 12:21:08 +0300
Message-ID: <CAOJe8K3DMXE7o1nx6YDrin78SMBD_gD7HuhHNuSZkdBrjjE5ng@mail.gmail.com>
Subject: Re: [PATCH] selftests/powerpc: run eeb tests only on POWER8
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/18/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sat, 2015-10-17 at 21:31 +0300, Denis Kirjanov wrote:
>
>> Event Based Branches currenly available on POWER8.
>> so we can skip them on other CPUs.
>
> Thanks for the patch, but ..
>
>> I've found that at least one test loops forever
>> on 970MP (cycles_with_freeze_test).
>
> Ooo interesting. The harness should kill it after a timeout.
>
>> diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
>> b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
>> index d7a72ce..a252637 100644
>> --- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
>> +++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
>> @@ -319,6 +319,19 @@ void ebb_global_disable(void)
>>  	mb();
>>  }
>>
>> +#define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF)
>> +bool ebb_is_supported(void)
>> +{
>> +	unsigned long pvr;
>> +
>> +	__asm__ __volatile__("mfpvr %0" : "=b"(pvr));
>> +	/* EBB requires at least POWER8 */
>> +	if (PVR_VER(pvr) >= 0x004D)
>> +		return true;
>> +
>> +	return false;
>> +}
>
> The right way to do this is not to look at the PVR but instead look at
> AT_HWCAP2, and see if it contains PPC_FEATURE2_EBB.
>
> You can see an example in tm-syscall.c
>
> Can you please respin with that change?

Sure, no problem!

Thanks!

>
> cheers
>
>
