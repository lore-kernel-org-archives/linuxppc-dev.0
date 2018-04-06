Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HpG731l1zF1xP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 04:32:31 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id 71-v6so1909329oie.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2018 11:32:31 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180406173335.Horde.Qgml03BtHOxSl6SzIPgQLA9@messagerie.si.c-s.fr>
References: <20180322202007.23088-4-malat@debian.org>
 <20180405202648.2836-1-malat@debian.org>
 <20180406173335.Horde.Qgml03BtHOxSl6SzIPgQLA9@messagerie.si.c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 6 Apr 2018 20:32:08 +0200
Message-ID: <CA+7wUswhZHNabB6kAcX8Cu8zMai15RzGn9euwdKau8kY48i-CA@mail.gmail.com>
Subject: Re: [PATCH v4 03/19] powerpc: Mark variable `l` as unused,
 remove `path`
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: LKML <linux-kernel@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 6, 2018 at 5:33 PM, LEROY Christophe
<christophe.leroy@c-s.fr> wrote:
> Mathieu Malaterre <malat@debian.org> a =C3=A9crit :
>
>> Add gcc attribute unused for `l` variable, replace `path` variable
>> directly
>> with prom_scratch. Fix warnings treated as errors with W=3D1:
>>
>>   arch/powerpc/kernel/prom_init.c:607:6: error: variable =E2=80=98l=E2=
=80=99 set but not
>> used [-Werror=3Dunused-but-set-variable]
>>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable =E2=80=98path=
=E2=80=99 set but
>> not used [-Werror=3Dunused-but-set-variable]
>>
>> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v4: redo v3 since path variable can be avoided
>> v3: really move path within ifdef DEBUG_PROM
>> v2: move path within ifdef DEBUG_PROM
>>
>>  arch/powerpc/kernel/prom_init.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c
>> b/arch/powerpc/kernel/prom_init.c
>> index f8a9a50ff9b5..4b223a9470be 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -604,7 +604,7 @@ static void __init early_cmdline_parse(void)
>>         const char *opt;
>>
>>         char *p;
>> -       int l =3D 0;
>> +       int l __maybe_unused =3D 0;
>
>
> Instead of hiding the problem with __maybe_unused, I think we could repla=
ce
> the
> #ifdef CONFIG_CMDLINE
> by a
> if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
>
> This is recommanded by Linux codying style

Neat. I was not aware of this trick. Does not work in this case though:

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c
index 7925f64fefde..19634739b279 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -604,17 +604,16 @@ static void __init early_cmdline_parse(void)
        const char *opt;

        char *p;
-       int l __maybe_unused =3D 0;
+       int l =3D 0;

        prom_cmd_line[0] =3D 0;
        p =3D prom_cmd_line;
        if ((long)prom.chosen > 0)
                l =3D prom_getprop(prom.chosen, "bootargs", p,
COMMAND_LINE_SIZE-1);
-#ifdef CONFIG_CMDLINE
-       if (l <=3D 0 || p[0] =3D=3D '\0') /* dbl check */
-               strlcpy(prom_cmd_line,
-                       CONFIG_CMDLINE, sizeof(prom_cmd_line));
-#endif /* CONFIG_CMDLINE */
+       if (IS_ENABLED(CONFIG_CMDLINE_BOOL))
+               if (l <=3D 0 || p[0] =3D=3D '\0') /* dbl check */
+                       strlcpy(prom_cmd_line,
+                               CONFIG_CMDLINE, sizeof(prom_cmd_line));
        prom_printf("command line: %s\n", prom_cmd_line);

 #ifdef CONFIG_PPC64


leads to:

  CC      arch/powerpc/kernel/prom_init.o
../arch/powerpc/kernel/prom_init.c: In function =E2=80=98early_cmdline_pars=
e=E2=80=99:
../arch/powerpc/kernel/prom_init.c:616:5: error: =E2=80=98CONFIG_CMDLINE=E2=
=80=99
undeclared (first use in this function)
     CONFIG_CMDLINE, sizeof(prom_cmd_line));
     ^~~~~~~~~~~~~~
../arch/powerpc/kernel/prom_init.c:616:5: note: each undeclared
identifier is reported only once for each function it appears in
../scripts/Makefile.build:312: recipe for target
'arch/powerpc/kernel/prom_init.o' failed
make[6]: *** [arch/powerpc/kernel/prom_init.o] Error 1


> Christophe
>
>
>>
>>         prom_cmd_line[0] =3D 0;
>>         p =3D prom_cmd_line;
>> @@ -1386,7 +1386,7 @@ static void __init reserve_mem(u64 base, u64 size)
>>  static void __init prom_init_mem(void)
>>  {
>>         phandle node;
>> -       char *path, type[64];
>> +       char type[64];
>>         unsigned int plen;
>>         cell_t *p, *endp;
>>         __be32 val;
>> @@ -1407,7 +1407,6 @@ static void __init prom_init_mem(void)
>>         prom_debug("root_size_cells: %x\n", rsc);
>>
>>         prom_debug("scanning memory:\n");
>> -       path =3D prom_scratch;
>>
>>         for (node =3D 0; prom_next_node(&node); ) {
>>                 type[0] =3D 0;
>> @@ -1432,9 +1431,9 @@ static void __init prom_init_mem(void)
>>                 endp =3D p + (plen / sizeof(cell_t));
>>
>>  #ifdef DEBUG_PROM
>> -               memset(path, 0, PROM_SCRATCH_SIZE);
>> -               call_prom("package-to-path", 3, 1, node, path,
>> PROM_SCRATCH_SIZE-1);
>> -               prom_debug("  node %s :\n", path);
>> +               memset(prom_scratch, 0, PROM_SCRATCH_SIZE);
>> +               call_prom("package-to-path", 3, 1, node, prom_scratch,
>> PROM_SCRATCH_SIZE - 1);
>> +               prom_debug("  node %s :\n", prom_scratch);
>>  #endif /* DEBUG_PROM */
>>
>>                 while ((endp - p) >=3D (rac + rsc)) {
>> --
>> 2.11.0
>
>
>
