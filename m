Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 13C96DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:36:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Consolidate mm_context_t definition in mmu.h
Date: Tue, 10 Jul 2007 18:36:25 +0200
References: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1184079709.32199.6.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707101836.26413.arnd@arndb.de>
Cc: paulus@samba.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 10 July 2007, Josh Boyer wrote:
> +#ifdef CONFIG_PPC64
> +typedef unsigned long mm_context_id_t;
> +
> +typedef struct {
> +=A0=A0=A0=A0=A0=A0=A0mm_context_id_t id;
> +=A0=A0=A0=A0=A0=A0=A0u16 user_psize;=A0=A0=A0=A0=A0=A0=A0=A0=A0/* page s=
ize index */
> +
> +#ifdef CONFIG_PPC_MM_SLICES
> +=A0=A0=A0=A0=A0=A0=A0u64 low_slices_psize;=A0=A0=A0/* SLB page size enco=
dings */
> +=A0=A0=A0=A0=A0=A0=A0u64 high_slices_psize; =A0/* 4 bits per slice for n=
ow */
> +#else
> +=A0=A0=A0=A0=A0=A0=A0u16 sllp;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0/* SLB page size encoding */
> +#endif
> +=A0=A0=A0=A0=A0=A0=A0unsigned long vdso_base;
> +} mm_context_t;
> +
> +#else /* !CONFIG_PPC64 */
> +
> +typedef struct {
> +=A0=A0=A0=A0=A0=A0=A0unsigned long id;
> +=A0=A0=A0=A0=A0=A0=A0unsigned long vdso_base;
> +} mm_context_t;
> +
> +#endif /* CONFIG_PPC64 */


It seems to me that you can easily consolidate this further, if you
allow the mm_context_id_t on 32 bit, or remove it on 64 bit:

+typedef unsigned long mm_context_id_t;
+
+typedef struct {
+       mm_context_id_t id;
+       u16 user_psize;         /* page size index */
+
+#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_MM_SLICES
+       u64 low_slices_psize;   /* SLB page size encodings */
+       u64 high_slices_psize;  /* 4 bits per slice for now */
+#else
+       u16 sllp;               /* SLB page size encoding */
+#endif
+#endif
+       unsigned long vdso_base;
+} mm_context_t;
