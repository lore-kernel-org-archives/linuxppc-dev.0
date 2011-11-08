Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EFA3AB6F18
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 20:07:11 +1100 (EST)
Received: from mail100-am1 (localhost.localdomain [127.0.0.1])	by
 mail100-am1-R.bigfish.com (Postfix) with ESMTP id 7503C180446	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 09:06:50 +0000 (UTC)
Received: from AM1EHSMHS020.bigfish.com (unknown [10.3.201.254])	by
 mail100-am1.bigfish.com (Postfix) with ESMTP id 147FCE7806C	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 09:06:50 +0000 (UTC)
From: Li Yang-R58472 <r58472@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Zhao Chenhui-B35336
 <B35336@freescale.com>
Subject: RE: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
 KEXEC patch
Date: Tue, 8 Nov 2011 09:06:55 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052BC5F8@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320409787-14360-1-git-send-email-chenhui.zhao@freescale.com>
 <4EB421FD.6010805@freescale.com>
In-Reply-To: <4EB421FD.6010805@freescale.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>-----Original Message-----
>From: linuxppc-dev-bounces+leoli=3Dfreescale.com@lists.ozlabs.org
>[mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@lists.ozlabs.org] On
>Behalf Of Scott Wood
>Sent: Saturday, November 05, 2011 1:34 AM
>To: Zhao Chenhui-B35336
>Cc: linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH 1/7] powerpc/85xx: re-enable timebase sync disabled by
>KEXEC patch
>
>On 11/04/2011 07:29 AM, Zhao Chenhui wrote:
>> From: Li Yang <leoli@freescale.com>
>>
>> The timebase sync is not only necessary when using KEXEC. It should also
>> be used by normal boot up and cpu hotplug. Remove the ifdef added by
>> the KEXEC patch.
>
>The KEXEC patch didn't just add the ifdef, it also added the initializers:

Yes.  But the code suggests that the timebase synchronization is only neces=
sary for KEXEC, but it turns out that sleep/wakeup also need it.  Maybe the=
 description of the patch need to be changed as KEXEC is not to be blamed.

>
>> @@ -105,8 +107,64 @@ smp_85xx_setup_cpu(int cpu_nr)
>>
>>  struct smp_ops_t smp_85xx_ops =3D {
>>         .kick_cpu =3D smp_85xx_kick_cpu,
>> +#ifdef CONFIG_KEXEC
>> +       .give_timebase  =3D smp_generic_give_timebase,
>> +       .take_timebase  =3D smp_generic_take_timebase,
>> +#endif
>>  };
>
>U-Boot synchronizes the timebase on 85xx.  With what chip and U-Boot
>version are you seeing this not happen?

I'm curious why don't we make it happen in kernel as we are against adding =
dependency to the bootloader?  Other architectures don't have this dependen=
cy, it will be better if we don't add this dependency either IMO.


>
>If you are seeing only a small (around one tick) difference, make sure
>you're running a U-Boot that has this commit:
>
>> commit 7afc45ad7d9493208d89072cbb78a5bfc8034b59
>> Author: Kumar Gala <galak@kernel.crashing.org>
>> Date:   Sun Mar 13 10:55:53 2011 -0500
>>
>>     powerpc/85xx: Fix synchronization of timebase on MP boot
>>
>>     There is a small ordering issue in the master core in that we need
>to
>>     make sure the disabling of the timebase in the SoC is visible before
>we
>>     set the value to 0.  We can simply just read back the value to
>>     synchronizatize the write, before we set TB to 0.
>>
>>     Reported-by: Dan Hettena
>>     Tested-by: Dan Hettena
>>     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
>
>-Scott
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
