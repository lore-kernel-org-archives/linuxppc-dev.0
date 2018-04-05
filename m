Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GsZ10nBLzF1pC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 15:58:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Paul
 Mackerras" <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 03/19] powerpc: Mark variables as unused
In-Reply-To: <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
References: <20180322202007.23088-4-malat@debian.org>
 <20180328193307.978-1-malat@debian.org>
 <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
Date: Thu, 05 Apr 2018 15:57:59 +1000
Message-ID: <87fu4atct4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:
>
>> Add gcc attribute unused for two variables. Fix warnings treated as erro=
rs
>> with W=3D1:
>>
>>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable =E2=80=98path=
=E2=80=99 set=20=20
>> but not used [-Werror=3Dunused-but-set-variable]
>>
>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>> v2: move path within ifdef DEBUG_PROM
>>
>>  arch/powerpc/kernel/prom_init.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c=20=20
>> b/arch/powerpc/kernel/prom_init.c
>> index acf4b2e0530c..4163b11abb6c 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>>  	const char *opt;
>>
>>  	char *p;
>> -	int l =3D 0;
>> +	int l __maybe_unused =3D 0;
>>
>>  	prom_cmd_line[0] =3D 0;
>>  	p =3D prom_cmd_line;
>> @@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size)
>>  static void __init prom_init_mem(void)
>>  {
>>  	phandle node;
>> -	char *path, type[64];
>> +	char *path __maybe_unused, type[64];
>
> You should enclose that in an ifdef DEBUG_PROM instead of hiding the warn=
ing

I disagree, the result is horrible:

 static void __init prom_init_mem(void)
 {
	phandle node;
-	char *path, type[64];
+#ifdef DEBUG_PROM
+	char *path;
+#endif
+	char type[64];
	unsigned int plen;
	cell_t *p, *endp;
	__be32 val;


The right fix is to move the debug logic into a helper, and put the path
in there, eg. something like (not tested):

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_ini=
t.c
index f9d6befb55a6..b02fa2ccc70b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1389,6 +1389,18 @@ static void __init reserve_mem(u64 base, u64 size)
 	mem_reserve_cnt =3D cnt + 1;
 }
=20
+#ifdef DEBUG_PROM
+static void prom_debug_path(phandle node)
+{
+	char *path;
+	path =3D prom_scratch;
+	memset(path, 0, PROM_SCRATCH_SIZE);
+	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
+	prom_debug("  node %s :\n", path);
+}
+#else
+static void prom_debug_path(phandle node) { }
+#endif /* DEBUG_PROM */
 /*
  * Initialize memory allocation mechanism, parse "memory" nodes and
  * obtain that way the top of memory and RMO to setup out local allocator
@@ -1441,11 +1453,7 @@ static void __init prom_init_mem(void)
 		p =3D regbuf;
 		endp =3D p + (plen / sizeof(cell_t));
=20
-#ifdef DEBUG_PROM
-		memset(path, 0, PROM_SCRATCH_SIZE);
-		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
-		prom_debug("  node %s :\n", path);
-#endif /* DEBUG_PROM */
+		prom_debug_path(node);
=20
 		while ((endp - p) >=3D (rac + rsc)) {
 			unsigned long base, size;


Although that also begs the question of why the hell do we need path at
all, and not just use prom_scratch directly?

cheers
