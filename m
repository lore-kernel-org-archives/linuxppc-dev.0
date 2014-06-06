Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-x22b.google.com (mail-la0-x22b.google.com
 [IPv6:2a00:1450:4010:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2AF91A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 16:30:59 +1000 (EST)
Received: by mail-la0-f43.google.com with SMTP id mc6so1256053lab.30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jun 2014 23:30:52 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <539152B3.5070702@linux.vnet.ibm.com>
References: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <539152B3.5070702@linux.vnet.ibm.com>
Date: Fri, 6 Jun 2014 08:30:52 +0200
Message-ID: <CAMuHMdXrKUoj_+ApkJpyxKSUiduTNJ4svJD0qNcMbSM1CspiEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: include asm/smp.h to handle UP config
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 6, 2014 at 7:33 AM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> On 06/05/2014 08:51 PM, Shreyas B. Prabhu wrote:
>> Build throws following errors when CONFIG_SMP=3Dn
>> arch/powerpc/platforms/powernv/setup.c: In function =E2=80=98pnv_kexec_w=
ait_secondaries_down=E2=80=99:
>> arch/powerpc/platforms/powernv/setup.c:179:4: error: implicit declaratio=
n of function =E2=80=98get_hard_smp_processor_id=E2=80=99
>>     rc =3D opal_query_cpu_status(get_hard_smp_processor_id(i),
>>
>> The usage of get_hard_smp_processor_id() needs the declaration from
>> <asm/smp.h>. The file setup.c includes <linux/sched.h>, which in-turn
>> includes <linux/smp.h>. However, <linux/smp.h> includes <asm/smp.h>
>> only on SMP configs and hence UP builds fail.
>>
>> Fix this by directly including <asm/smp.h> in setup.c unconditionally.
>
> Can you please clean up the description in the commit message ? and also
> the first line in the commit message should mention that the patch is
> trying to fix a UP specific build failure.

Both the one-line summary and the first line already mention "UP" or
"CONFIG_SMP=3Dn".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
