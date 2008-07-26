Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0FE5FDDF3E
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 20:52:58 +1000 (EST)
Message-ID: <488B0202.3010204@ru.mvista.com>
Date: Sat, 26 Jul 2008 14:52:50 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH] Memset the kernel copy of rtas args before using
References: <488A44DB.7090400@austin.ibm.com>
In-Reply-To: <488A44DB.7090400@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Nathan Fontenot wrote:
> Index: linux-2.6.git/arch/powerpc/kernel/rtas.c
> ===================================================================
> --- linux-2.6.git.orig/arch/powerpc/kernel/rtas.c    2008-07-22 
> 09:34:03.000000000 -0500
> +++ linux-2.6.git/arch/powerpc/kernel/rtas.c    2008-07-25 
> 16:06:00.000000000 -0500
> @@ -775,6 +775,8 @@
>     if (!capable(CAP_SYS_ADMIN))
>         return -EPERM;
>
> +    memset(&args, 0, sizeof(args));
> +

   You could use memzero() directly -- memset(x, 0, sizeof(x))l should 
boil down to it anyway...
>     if (copy_from_user(&args, uargs, 3 * sizeof(u32)) != 0)
>         return -EFAULT;

WBR, Sergei
