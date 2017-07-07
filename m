Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x45BD4jRbzDr5d
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 06:02:44 +1000 (AEST)
Date: Fri, 7 Jul 2017 19:59:55 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [git pull] vfs.git part 1
Message-ID: <20170707185955.GH10672@ZenIV.linux.org.uk>
References: <20170705071423.GY10672@ZenIV.linux.org.uk>
 <87eftsv2hj.fsf@concordia.ellerman.id.au>
 <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
 <CA+55aFzHBR9M+UN2CMAQ0np275iyWyAY0uKK8LFo33g0e7Z-VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFzHBR9M+UN2CMAQ0np275iyWyAY0uKK8LFo33g0e7Z-VQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 07, 2017 at 10:35:41AM -0700, Linus Torvalds wrote:

> Comments? Michael, does this work for your case?

Looks sane...

> +++ b/fs/fcntl.c
> @@ -520,50 +520,50 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
>  
>  #ifdef CONFIG_COMPAT
>  /* careful - don't use anywhere else */
> -#define copy_flock_fields(from, to)		\
> -	(to).l_type = (from).l_type;		\
> -	(to).l_whence = (from).l_whence;	\
> -	(to).l_start = (from).l_start;		\
> -	(to).l_len = (from).l_len;		\
> -	(to).l_pid = (from).l_pid;
> -
> -static int get_compat_flock(struct flock *kfl, struct compat_flock __user *ufl)
> +#define copy_flock_fields(dst, src)		\
> +	(dst)->l_type = (src)->l_type;		\
> +	(dst)->l_whence = (src)->l_whence;	\
> +	(dst)->l_start = (src)->l_start;	\
> +	(dst)->l_len = (src)->l_len;		\
> +	(dst)->l_pid = (src)->l_pid;
> +
> +static int get_compat_flock(struct flock *kfl, const struct compat_flock __user *ufl)
>  {
>  	struct compat_flock fl;
>  
>  	if (copy_from_user(&fl, ufl, sizeof(struct compat_flock)))
>  		return -EFAULT;
> -	copy_flock_fields(*kfl, fl);
> +	copy_flock_fields(kfl, &fl);
>  	return 0;
>  }
>  
> -static int get_compat_flock64(struct flock *kfl, struct compat_flock64 __user *ufl)
> +static int get_compat_flock64(struct flock *kfl, const struct compat_flock64 __user *ufl)
>  {
>  	struct compat_flock64 fl;
>  
>  	if (copy_from_user(&fl, ufl, sizeof(struct compat_flock64)))
>  		return -EFAULT;
> -	copy_flock_fields(*kfl, fl);
> +	copy_flock_fields(kfl, &fl);
>  	return 0;
>  }
>  
> -static int put_compat_flock(struct flock *kfl, struct compat_flock __user *ufl)
> +static int put_compat_flock(const struct flock *kfl, struct compat_flock __user *ufl)
>  {
>  	struct compat_flock fl;
>  
>  	memset(&fl, 0, sizeof(struct compat_flock));
> -	copy_flock_fields(fl, *kfl);
> +	copy_flock_fields(&fl, kfl);
>  	if (copy_to_user(ufl, &fl, sizeof(struct compat_flock)))
>  		return -EFAULT;
>  	return 0;
>  }
>  
> -static int put_compat_flock64(struct flock *kfl, struct compat_flock64 __user *ufl)
> +static int put_compat_flock64(const struct flock *kfl, struct compat_flock64 __user *ufl)
>  {
>  	struct compat_flock64 fl;
>  
>  	memset(&fl, 0, sizeof(struct compat_flock64));
> -	copy_flock_fields(fl, *kfl);
> +	copy_flock_fields(&fl, kfl);
>  	if (copy_to_user(ufl, &fl, sizeof(struct compat_flock64)))
>  		return -EFAULT;
>  	return 0;
