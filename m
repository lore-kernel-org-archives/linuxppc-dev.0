Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKRrz2BwJzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 18:48:35 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: Blacklist GCC 5.4 6.1 and 6.2
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170210053115.20565-1-cyrilbur@gmail.com>
Cc: akshay.adiga@linux.vnet.ibm.com
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6f4d7111-6747-db55-c2c0-10aefa009f6d@c-s.fr>
Date: Fri, 10 Feb 2017 08:48:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170210053115.20565-1-cyrilbur@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/02/2017 à 06:31, Cyril Bur a écrit :
> A bug in the -02 optimisation of GCC 5.4 6.1 and 6.2 causes
> setup_command_line() to not pass the correct first argument to strcpy
> and therefore not actually copy the command_line.
>
> A workaround patch was proposed: http://patchwork.ozlabs.org/patch/673130/
> some discussion ensued.
>
> A GCC bug was raised: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71709
> The bug has been fixed in 7.0 and backported to GCC 5 and GCC 6.
>
> At the time of writing GCC 5.4 is the most recent and is affected. GCC
> 6.3 contains the backported fix, has been tested and appears safe to
> use.
>
> Heavy-lifting-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/Makefile | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 31286fa7873c..a4b886694391 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -414,6 +414,15 @@ checkbin:
>  		echo -n '*** Please use a different binutils version.' ; \
>  		false ; \
>  	fi
> +	@if test "$(cc-version)" = "0504" \
> +		|| test "$(cc-version)" = "0601" \
> +		|| test "$(cc-version)" = "0602" ; then \
> +		echo -n '*** GCC-5.4 6.1 6.2 have a bad -O2 optimisation ' ; \
> +		echo 'which will cause lost commandline options (at least).' ; \
> +		echo '*** Please use a different GCC version.' ; \
> +		false ; \
> +	fi
> +

According to the GCC bug report, this bug applies to powerpc64le
Why force all targets to not use those versions of GCC ?

Christophe
