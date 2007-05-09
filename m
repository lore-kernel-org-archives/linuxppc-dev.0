Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 0E734DDEFB
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:22:25 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] Declare {compat_}sys_utimensat
Date: Wed, 9 May 2007 18:21:58 +0200
References: <20070509162357.65ab8868.sfr@canb.auug.org.au>
In-Reply-To: <20070509162357.65ab8868.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705091821.59412.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 May 2007, Stephen Rothwell wrote:
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index ccd863d..70a157a 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -253,5 +253,8 @@ asmlinkage long compat_sys_epoll_pwait(int epfd,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
onst compat_sigset_t __user *sigmask,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0c=
ompat_size_t sigsetsize);
> =A0
> +asmlinkage long compat_sys_utimensat(unsigned int dfd, char __user *file=
name,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0struct compat_timespec __user *t, int flags);
> +
> =A0#endif /* CONFIG_COMPAT */
> =A0#endif /* _LINUX_COMPAT_H */
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1912c6c..3139f44 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -576,6 +576,8 @@ asmlinkage long sys_fstatat64(int dfd, char __user *f=
ilename,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0 struct stat64 __user *statbuf, int flag);
> =A0asmlinkage long sys_readlinkat(int dfd, const char __user *path, char =
__user *buf,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0 int bufsiz);
> +asmlinkage long sys_utimensat(int dfd, char __user *filename,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0struct timespec __user *utimes, int flags);
> =A0asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *fi=
lename,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 struct compat_timeval __user *t);
> =A0asmlinkage long compat_sys_newfstatat(unsigned int dfd, char __user * =
filename,

It seems bogus to declare compat_sys_futimesat in syscalls.h and compat_sys=
_utimensat
in compat.h. Your patch is fine, since there are precedents for both, but m=
aybe
we should agree on one place and then move all of the compat_sys_ declarati=
ons there.

	Arnd <><
