Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 41B46B709C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 01:05:27 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/cell: strncpy does not null terminate string
Date: Fri, 17 Jul 2009 17:05:18 +0200
References: <4A607185.6020302@gmail.com>
In-Reply-To: <4A607185.6020302@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907171705.18578.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Roel Kluin <roel.kluin@gmail.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 17 July 2009, Roel Kluin wrote:
> With `sizeof(string) - 1` strncpy() will null terminate the string.

No, it won't. See the 'Warning' part of the strncpy man page.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> To test this:
> 
> #include <stdio.h>
> #include <string.h>
> 
> char a[10];
> char b[10];
> 
> int main()
> {
>         const char* str = "0123456789012";
>         strncpy(a, str, sizeof(a));
>         strncpy(b, str, sizeof(b) - 1);
>         printf("String a was %s, b was %s\n", a, b);
> 
>         return 0;
> }
> 
> Output:
> String a was 0123456789012345678, b was 012345678

This is an invalid test case, it relies on b being zero-filled by the
compiler, which is not true for programs in general.

> diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
> index 07c234f..cfdbadb 100644
> --- a/arch/powerpc/platforms/cell/celleb_setup.c
> +++ b/arch/powerpc/platforms/cell/celleb_setup.c
> @@ -80,7 +80,7 @@ static void celleb_show_cpuinfo(struct seq_file *m)
>  
>  static int __init celleb_machine_type_hack(char *ptr)
>  {
> -	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> +	strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type) - 1);
>  	celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
>  	return 0;
>  }

See the line after the strncpy. This is still required for proper zero-termination.

Your patch tries to address a problem that doesn't exist, and does not have any
effect at all after celleb_machine_type_hack has completed.

	Arnd <><
