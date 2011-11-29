Return-Path: <tinamdar@apm.com>
Received: from exprod5og117.obsmtp.com (exprod5og117.obsmtp.com [64.18.0.149])
 by ozlabs.org (Postfix) with SMTP id 7BFA7B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 17:11:41 +1100 (EST)
Received: by mail-iy0-f175.google.com with SMTP id k25so10094555iah.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2011 22:11:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322435957.23348.23.camel@pasglop>
References: <1322041464-20605-1-git-send-email-tinamdar@apm.com>
 <201111231415.51985.arnd@arndb.de>
 <CACoXjcnfCM8Z5qFfrHtxsXkpf492LVbkDA3X=a9dRv9Lcv7Asw@mail.gmail.com>
 <1322435957.23348.23.camel@pasglop>
Date: Tue, 29 Nov 2011 11:41:37 +0530
Message-ID: <CACoXjc=tcZr_82JwfTzT+6re3d_e3pbn-yXvq=2ofbFSvSXM5g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: Add APM8018X SOC support
From: Tanmay Inamdar <tinamdar@apm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 28, 2011 at 4:49 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2011-11-25 at 17:49 +0530, Tanmay Inamdar wrote:
>
>>
>> =A0 =A0 =A0 =A0 >
>> =A0 =A0 =A0 =A0 > +#if defined(CONFIG_APM8018X)
>> =A0 =A0 =A0 =A0 > +/* CPR */
>> =A0 =A0 =A0 =A0 > +#define DCRN_CPR0_CONFIG_ADDR =A0 =A0 =A0 =A00xa
>> =A0 =A0 =A0 =A0 > +#define DCRN_CPR1_CONFIG_DATA =A0 =A0 =A0 =A00xb
>> =A0 =A0 =A0 =A0 > +/* AHB */
>> =A0 =A0 =A0 =A0 > +#define DCRN_SDR1_CONFIG_ADDR =A0 =A0 =A0 =A00xc
>> =A0 =A0 =A0 =A0 > +#define DCRN_SDR1_CONFIG_DATA =A0 =A0 =A0 =A00xd
>> =A0 =A0 =A0 =A0 > +#else
>> =A0 =A0 =A0 =A0 > =A0/* CPRs (440GX and 440SP/440SPe) */
>> =A0 =A0 =A0 =A0 > =A0#define DCRN_CPR0_CONFIG_ADDR =A0 =A0 =A0 =A00xc
>> =A0 =A0 =A0 =A0 > =A0#define DCRN_CPR0_CONFIG_DATA =A0 =A0 =A0 =A00xd
>> =A0 =A0 =A0 =A0 > +#endif /* CONFIG_APM8018X */
>>
>>
>> =A0 =A0 =A0 =A0 same comment as above.
>>
>> Some existing drivers use these macros. If I change the names, I will
>> have to update the
>> driver code.
>
> Right, the best approach is to create a small wrapper that provides cpr
> and sdr accesses using helpers. That way you can:
>
> =A0- Properly lock since it's all indirect
>
> =A0- Obtain the right DCRs at boot time, stick them in variables
> =A0 and use them at runtime, avoiding the hard coded constants completely
>
> =A0- Make the code generally look much better
>
> Ie. Provide something like read_sdr1() and write_sdr1() accessors and
> change the drivers to use them.

Ok.
There are 'mfdcri' and 'mtdcri' macros in
"arch/powerpc/include/asm/dcr-native.h" file.
They internally use '__mfdcri' and '__mtdcri' functions which can be
used for the same
purpose as mentioned above.
Instead of putting this change in current patch, I will make separate
patch for this purpose.

>
>> =A0 =A0 =A0 =A0 > diff --git a/arch/powerpc/kernel/cputable.c
>> =A0 =A0 =A0 =A0 b/arch/powerpc/kernel/cputable.c
>> =A0 =A0 =A0 =A0 > index edae5bb..e5c51a6 100644
>> =A0 =A0 =A0 =A0 > --- a/arch/powerpc/kernel/cputable.c
>> =A0 =A0 =A0 =A0 > +++ b/arch/powerpc/kernel/cputable.c
>> =A0 =A0 =A0 =A0 > @@ -1505,6 +1505,58 @@ static struct cpu_spec __initda=
ta
>> =A0 =A0 =A0 =A0 cpu_specs[] =3D {
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .machine_check =A0 =A0 =A0=
 =A0 =A0=3D machine_check_4xx,
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =3D "ppc405",
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 },
>> =A0 =A0 =A0 =A0 > + =A0 =A0 { =A0 =A0 =A0 /* APM80186-SK */
>> =A0 =A0 =A0 =A0 > + =A0 =A0 =A0 =A0 =A0 =A0 .pvr_mask =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =3D 0xffffffff,
>> =A0 =A0 =A0 =A0 > + =A0 =A0 =A0 =A0 =A0 =A0 .pvr_value =A0 =A0 =A0 =A0 =
=A0 =A0 =A0=3D 0x7ff11432,
>>
>>
>> =A0 =A0 =A0 =A0 If you mask out the lower bits, you only need a single e=
ntry
>> =A0 =A0 =A0 =A0 instead of
>> =A0 =A0 =A0 =A0 four identical ones.
>>
>> You are right. But each PVR represent different version of SOC. If I
>> create single entry, then I will have to give generic cpu_name which I
>> don't want.
>
> Note that you should really tell you designers to move away from using
> the PVR to identify the SoC's. This is BAD and isn't sustainable long
> run. Stick to representing the core itself in the PVR and provide a
> different mechanism to identify the SoC (different SPR would do, or even
> a DCR).
>
>> =A0 =A0 =A0 =A0 > --- a/arch/powerpc/kernel/udbg_16550.c
>> =A0 =A0 =A0 =A0 > +++ b/arch/powerpc/kernel/udbg_16550.c
>> =A0 =A0 =A0 =A0 > @@ -18,6 +18,19 @@ extern void real_writeb(u8 data, vo=
latile
>> =A0 =A0 =A0 =A0 u8 __iomem *addr);
>> =A0 =A0 =A0 =A0 > =A0extern u8 real_205_readb(volatile u8 __iomem =A0*ad=
dr);
>> =A0 =A0 =A0 =A0 > =A0extern void real_205_writeb(u8 data, volatile u8 __=
iomem
>> =A0 =A0 =A0 =A0 *addr);
>> =A0 =A0 =A0 =A0 >
>> =A0 =A0 =A0 =A0 > +#ifdef CONFIG_UART_16550_WORD_ADDRESSABLE
>> =A0 =A0 =A0 =A0 > +struct NS16550 {
>> =A0 =A0 =A0 =A0 > + =A0 =A0 /* this struct must be packed */
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char rbr; =A0/* 0 */ u8 s0[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char ier; =A0/* 1 */ u8 s1[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char fcr; =A0/* 2 */ u8 s2[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char lcr; =A0/* 3 */ u8 s3[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char mcr; =A0/* 4 */ u8 s4[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char lsr; =A0/* 5 */ u8 s5[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char msr; =A0/* 6 */ u8 s6[3];
>> =A0 =A0 =A0 =A0 > + =A0 =A0 unsigned char scr; =A0/* 7 */ u8 s7[3];
>> =A0 =A0 =A0 =A0 > +};
>> =A0 =A0 =A0 =A0 > +#else
>> =A0 =A0 =A0 =A0 > =A0struct NS16550 {
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 /* this struct must be packed */
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 unsigned char rbr; =A0/* 0 */
>> =A0 =A0 =A0 =A0 > @@ -29,6 +42,7 @@ struct NS16550 {
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 unsigned char msr; =A0/* 6 */
>> =A0 =A0 =A0 =A0 > =A0 =A0 =A0 unsigned char scr; =A0/* 7 */
>> =A0 =A0 =A0 =A0 > =A0};
>> =A0 =A0 =A0 =A0 > +#endif /* CONFIG_UART_16550_WORD_ADDRESSABLE */
>> =A0 =A0 =A0 =A0 >
>>
>>
>> =A0 =A0 =A0 =A0 Same things as with the register definitions. Please mak=
e this
>> =A0 =A0 =A0 =A0 run-time selectable to allow build-time configurations t=
hat
>> =A0 =A0 =A0 =A0 support both layouts.
>>
>> Yes. I will try to find better solution.
>
> Cheers,
> Ben.
>
>
>
Regards,
Tanmay
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, =

is for the sole use of the intended recipient(s) and contains information=
=A0
that is confidential and proprietary to AppliedMicro Corporation or its s=
ubsidiaries. =

It is to be used solely for the purpose of furthering the parties' busine=
ss relationship. =

All unauthorized review, use, disclosure or distribution is prohibited. =

If you are not the intended recipient, please contact the sender by reply=
 e-mail =

and destroy all copies of the original message.
=0D
