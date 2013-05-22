Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 41F472C0077
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 00:01:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 07/10] powerpc: uaccess s/might_sleep/might_fault/
Date: Wed, 22 May 2013 15:59:01 +0200
References: <cover.1368702323.git.mst@redhat.com>
 <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
In-Reply-To: <2aa6c3da21a28120126732b5e0b4ecd6cba8ca3b.1368702323.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201305221559.01806.arnd@arndb.de>
Cc: linux-m32r-ja@ml.linux-m32r.org, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-arch@vger.kernel.org, linux-am33-list@redhat.com,
 Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, microblaze-uclinux@itee.uq.edu.au,
 Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-m32r@ml.linux-m32r.org, linux-kernel@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 16 May 2013, Michael S. Tsirkin wrote:
> @@ -178,7 +178,7 @@ do {                                                                \
>         long __pu_err;                                          \
>         __typeof__(*(ptr)) __user *__pu_addr = (ptr);           \
>         if (!is_kernel_addr((unsigned long)__pu_addr))          \
> -               might_sleep();                                  \
> +               might_fault();                                  \
>         __chk_user_ptr(ptr);                                    \
>         __put_user_size((x), __pu_addr, (size), __pu_err);      \
>         __pu_err;                                               \
> 

Another observation:

	if (!is_kernel_addr((unsigned long)__pu_addr))
		might_sleep();

is almost the same as

	might_fault();

except that it does not call might_lock_read().

The version above may have been put there intentionally and correctly, but
if you want to replace it with might_fault(), you should remove the
"if ()" condition.

	Arnd
