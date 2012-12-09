Return-Path: <shuahkhan@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B85842C01FB
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Dec 2012 12:21:06 +1100 (EST)
Received: by mail-pb0-f51.google.com with SMTP id ro12so982694pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Dec 2012 17:21:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
References: <1354932445.7407.15.camel@lorien2>
 <1354987359.20838.67.camel@deadeye.wl.decadent.org.uk>
Date: Sat, 8 Dec 2012 18:21:04 -0700
Message-ID: <CAKocOOPYv0L5dnVJ-jcKw6u3Axbe-tFRdz+F8FvE6fq-xRQH5A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix wii_memory_fixups() compile error on 3.0.y
 tree
From: Shuah Khan <shuahkhan@gmail.com>
To: Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset=windows-1252
Cc: stable <stable@vger.kernel.org>, paulus@samba.org,
 Greg KH <gregkh@linuxfoundation.org>, shuah.khan@hp.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 8, 2012 at 10:22 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Fri, 2012-12-07 at 19:07 -0700, Shuah Khan wrote:
>> Fix wii_memory_fixups() the following compile error on 3.0.y tree with
>> wii_defconfig on 3.0.y tree.
>>
>>   CC      arch/powerpc/platforms/embedded6xx/wii.o
>> arch/powerpc/platforms/embedded6xx/wii.c: In function =91wii_memory_fixu=
ps=92:
>> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format =91%llx=92 =
expects argument of type =91long long unsigned int=92, but argument 2 has t=
ype =91phys_addr_t=92 [-Werror=3Dformat]
>> arch/powerpc/platforms/embedded6xx/wii.c:88:2: error: format =91%llx=92 =
expects argument of type =91long long unsigned int=92, but argument 3 has t=
ype =91phys_addr_t=92 [-Werror=3Dformat]
>> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format =91%llx=92 =
expects argument of type =91long long unsigned int=92, but argument 2 has t=
ype =91phys_addr_t=92 [-Werror=3Dformat]
>> arch/powerpc/platforms/embedded6xx/wii.c:90:2: error: format =91%llx=92 =
expects argument of type =91long long unsigned int=92, but argument 3 has t=
ype =91phys_addr_t=92 [-Werror=3Dformat]
>> cc1: all warnings being treated as errors
>> make[2]: *** [arch/powerpc/platforms/embedded6xx/wii.o] Error 1
>> make[1]: *** [arch/powerpc/platforms/embedded6xx] Error 2
>> make: *** [arch/powerpc/platforms] Error 2
>>
>> Signed-off-by: Shuah Khan <shuah.khan@hp.com>
>> CC: stable@vger.kernel.org 3.0.y
>> ---
>>  arch/powerpc/platforms/embedded6xx/wii.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/pla=
tforms/embedded6xx/wii.c
>> index 1b5dc1a..13d58dd 100644
>> --- a/arch/powerpc/platforms/embedded6xx/wii.c
>> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
>> @@ -85,9 +85,9 @@ void __init wii_memory_fixups(void)
>>       wii_hole_start =3D p[0].base + p[0].size;
>>       wii_hole_size =3D p[1].base - wii_hole_start;
>>
>> -     pr_info("MEM1: <%08llx %08llx>\n", p[0].base, p[0].size);
>> +     pr_info("MEM1: <%08ulx %08ulx>\n", p[0].base, p[0].size);
>
> "%08ulx" is the conversion specification "%08u" followed by literal
> "lx".  If phys_addr_t is always defined as unsigned long or always
> unsigned int for this platform then you could use "%08lx" or "%08x"
> respectively.  But usually the right thing to do is to cast the
> arguments of type phys_addr_t to unsigned long long (or, equivalently,
> u64).
>
> Ben.

Thanks. I should have gone with my first instinct of typecasting :)  Will
resend the patch with typecast instead of the change I made in a couple
of days.

Thanks,
-- Shuah
