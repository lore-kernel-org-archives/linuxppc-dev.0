Return-Path: <oohall@gmail.com>
Received: from mail-qg0-x241.google.com (mail-qg0-x241.google.com
 [IPv6:2607:f8b0:400d:c04::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3GZw5mjXzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 19:01:28 +1000 (AEST)
Received: by mail-qg0-x241.google.com with SMTP id e35so11214981qge.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 May 2016 02:01:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ccffddae-6e91-d8ad-5d33-f926b021b76b@gmail.com>
References: <1462347433-26150-1-git-send-email-oohall@gmail.com>
 <ccffddae-6e91-d8ad-5d33-f926b021b76b@gmail.com>
Date: Mon, 9 May 2016 19:01:26 +1000
Message-ID: <CAOSf1CEAuXV8p5nDm1Pqsx90Jek-SE7ev_37bjjh+7gsc=fY_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/timer - large decrementer support
From: oliver <oohall@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jack Miller <jack@codezen.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 9, 2016 at 4:28 PM, Balbir Singh <bsingharora@gmail.com> wrote:
>
>
> On 04/05/16 17:37, Oliver O'Halloran wrote:
>> POWER ISA v3 adds large decrementer (LD) mode of operation which increases
>> the size of the decrementer register from 32 bits to an implementation
>> defined with of up to 64 bits.
>>
>> This patch adds support for the LD on processors with the CPU_FTR_ARCH_300
>> cpu feature flag set. Even for CPUs with this feature LD mode is only
>> enabled when the property ibm,dec-bits devicetree property is supplied
>> for the boot CPU. The decrementer value is a signed quantity (with
>> negative values indicating a pending exception) and this property is
>> required to find the maximum positive decrementer value. If this property
>> is not supplied then the traditional decrementer width of 32 bits is
>> assumed and LD mode is disabled.
>>
>> This patch was based on initial work by Jack Miller.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> Cc: Jack Miller <jack@codezen.org>
>> Cc: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  arch/powerpc/include/asm/reg.h  |  1 +
>>  arch/powerpc/include/asm/time.h |  6 +--
>>  arch/powerpc/kernel/time.c      | 89 +++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 86 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index f5f4c66bbbc9..ff581ed1ab9d 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -332,6 +332,7 @@
>>  #define   LPCR_AIL_0 0x00000000      /* MMU off exception offset 0x0 */
>>  #define   LPCR_AIL_3 0x01800000      /* MMU on exception offset 0xc00...4xxx */
>>  #define   LPCR_ONL   0x00040000      /* online - PURR/SPURR count */
>> +#define   LPCR_LD    0x00020000      /* large decremeter */
>>  #define   LPCR_PECE  0x0001f000      /* powersave exit cause enable */
>>  #define     LPCR_PECEDP      0x00010000      /* directed priv dbells cause exit */
>>  #define     LPCR_PECEDH      0x00008000      /* directed hyp dbells cause exit */
>> diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
>> index 1092fdd7e737..09211640a0e0 100644
>> --- a/arch/powerpc/include/asm/time.h
>> +++ b/arch/powerpc/include/asm/time.h
>> @@ -146,7 +146,7 @@ static inline void set_tb(unsigned int upper, unsigned int lower)
>>   * in auto-reload mode.  The problem is PIT stops counting when it
>>   * hits zero.  If it would wrap, we could use it just like a decrementer.
>>   */
>> -static inline unsigned int get_dec(void)
>> +static inline u64 get_dec(void)
>>  {
>>  #if defined(CONFIG_40x)
>>       return (mfspr(SPRN_PIT));
>> @@ -160,10 +160,10 @@ static inline unsigned int get_dec(void)
>>   * in when the decrementer generates its interrupt: on the 1 to 0
>>   * transition for Book E/4xx, but on the 0 to -1 transition for others.
>>   */
>> -static inline void set_dec(int val)
>> +static inline void set_dec(u64 val)
>>  {
>>  #if defined(CONFIG_40x)
>> -     mtspr(SPRN_PIT, val);
>> +     mtspr(SPRN_PIT, (u32) val);
>>  #else
>>  #ifndef CONFIG_BOOKE
>>       --val;
>> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
>> index 81b0900a39ee..fab34abfb4cd 100644
>> --- a/arch/powerpc/kernel/time.c
>> +++ b/arch/powerpc/kernel/time.c
>> @@ -95,7 +95,8 @@ static struct clocksource clocksource_timebase = {
>>       .read         = timebase_read,
>>  };
>>
>> -#define DECREMENTER_MAX      0x7fffffff
>> +#define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
>> +u64 decrementer_max = DECREMENTER_DEFAULT_MAX;
>
> Should this be signed, given that the decrementer is signed?

Maybe, but there's no particular reason to prefer signed since we (almost)
never look at the decrementer value directly. I used u64 since the value to
be loaded into the decrementer is calculated using a u64 and the explicit
cast to int when calling set_dec() in __timer_interrupt() was the only place I
could find where an int was expected.

>> +static inline bool large_dec_supp(void)
>> +{
>> +     return cpu_has_feature(CPU_FTR_ARCH_300);
>> +}
>> +
>
> Can we rename this to is_large_dec()?

Honestly, I don't like either. How about have_large_dec() ?

>> +/* enables the large decrementer for the current CPU */
>> +static void enable_large_decrementer(void)
>> +{
>> +     /* do we have a large decrementer? */
>> +     if (!large_dec_supp())
>> +             return;
>> +
>> +     /* do we need a large decrementer? */
>> +     if (decrementer_max <= DECREMENTER_DEFAULT_MAX)
>> +             return;
>> +
>> +     mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_LD);
>> +
>> +     if (!large_dec_on()) {
>> +             decrementer_max = DECREMENTER_DEFAULT_MAX;
>> +
>> +             pr_warn("time_init: Failed to enable LD mode on CPU %d\n",
>
> I think stating "Failed to enable Large Decrementer" might be easier to understand in the logs

You're right, I was just trying to keep it under 80 cols :)

>
>> +                     smp_processor_id());
>> +     }
>> +}
>> +
>> +static void __init set_decrementer_max(void)
>> +{
>> +     struct device_node *cpu;
>> +     const __be32 *fp;
>> +     u64 bits = 32;
>> +
>> +     /* dt node exists? */
>> +     cpu = of_find_node_by_type(NULL, "cpu");
>> +     if (cpu)
>> +             fp = of_get_property(cpu, "ibm,dec-bits", NULL);
>> +
>> +     if (cpu && fp) {
>> +             bits = of_read_number(fp, 1);
>> +
>> +             /* clamp to sane values */
>> +             if (bits > 64)
>> +                     bits = 64;
>> +             if (bits < 32)
>> +                     bits = 32;
>> +
>
> Shouldn't we warn about a firmware bug if we wrap the bits for > 64 or < 32?

Good idea.
