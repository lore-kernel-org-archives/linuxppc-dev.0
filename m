Return-Path: <mattst88@gmail.com>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 541671007DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 04:13:53 +1000 (EST)
Received: by qyk7 with SMTP id 7so1197461qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 04 May 2011 11:13:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 4 May 2011 14:13:29 -0400
Message-ID: <BANLkTinWa9E1_iLWyqAF+G8Qag=YK2T98A@mail.gmail.com>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
To: Sven Eckelmann <sven@narfation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>,
	linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 3, 2011 at 5:30 PM, Sven Eckelmann <sven@narfation.org> wrote:
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/ato=
mic.h
> index e756d04..7e9434e 100644
> --- a/arch/alpha/include/asm/atomic.h
> +++ b/arch/alpha/include/asm/atomic.h
> @@ -200,6 +200,7 @@ static __inline__ int atomic_add_unless(atomic_t *v, =
int a, int u)
> =A0}
>
> =A0#define atomic_inc_not_zero(v) atomic_add_unless((v), 1, 0)
> +#define atomic_dec_not_zero(v) atomic_add_unless((v), -1, 0)
>
> =A0/**
> =A0* atomic64_add_unless - add unless the number is a given value
> @@ -226,6 +227,7 @@ static __inline__ int atomic64_add_unless(atomic64_t =
*v, long a, long u)
> =A0}
>
> =A0#define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
> +#define atomic64_dec_not_zero(v) atomic64_add_unless((v), -1, 0)
>
> =A0#define atomic_add_negative(a, v) (atomic_add_return((a), (v)) < 0)
> =A0#define atomic64_add_negative(a, v) (atomic64_add_return((a), (v)) < 0=
)
> diff --git a/arch/alpha/include/asm/local.h b/arch/alpha/include/asm/loca=
l.h
> index b9e3e33..09fb327 100644
> --- a/arch/alpha/include/asm/local.h
> +++ b/arch/alpha/include/asm/local.h
> @@ -79,6 +79,7 @@ static __inline__ long local_sub_return(long i, local_t=
 * l)
> =A0 =A0 =A0 =A0c !=3D (u); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0})
> =A0#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
> +#define local_dec_not_zero(l) local_add_unless((l), -1, 0)
>
> =A0#define local_add_negative(a, l) (local_add_return((a), (l)) < 0)
>

Acked-by: Matt Turner <mattst88@gmail.com> [alpha]
