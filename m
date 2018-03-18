Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4046rg2lWxzF0g8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 05:18:27 +1100 (AEDT)
Date: Sun, 18 Mar 2018 17:40:14 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 arnd@arndb.de, linux-arch@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>,
 linux-mips@linux-mips.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Jiri Slaby <jslaby@suse.com>, x86@kernel.org
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Message-ID: <20180318174014.GR30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180318161056.5377-5-linux@dominikbrodowski.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 18, 2018 at 05:10:54PM +0100, Dominik Brodowski wrote:

> +#ifdef __ARCH_WANT_COMPAT_SYS_READAHEAD
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
> +		       unsigned int, off_lo, unsigned int, off_hi,
> +		       size_t, count)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
> +		       unsigned int, off_hi, unsigned int, off_lo,
> +		       size_t, count)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
> +		       unsigned int, off_lo, unsigned int, off_hi,
> +		       size_t, count)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
> +		       unsigned int, off_hi, unsigned int, off_lo,
> +		       size_t, count)
> +#endif
> +{
> +	return do_readahead(fd, ((u64) off_hi << 32) | off_lo, count);
>  }

*UGH*

static inline compat_to_u64(u32 w0, u32 w1)
{
#ifdef __BIG_ENDIAN
	return ((u64)w0 << 32) | w1;
#else
	return ((u64)w1 << 32) | w0;
#endif
}

in compat.h, then this turns into

#ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
		       u32, off0, u32 off1,
		       compat_size_t, count)
#else
COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
		       u32, off0, u32 off1,
		       compat_size_t, count)
#endif
{
	return do_readahead(fd, compat_to_u64(off0, off1), count);
}
