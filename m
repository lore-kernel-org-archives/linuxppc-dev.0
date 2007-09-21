Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 98537DDE26
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 04:46:52 +1000 (EST)
Date: Fri, 21 Sep 2007 13:46:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Matt Tyrlik <tyrlik@us.ibm.com>
Subject: Re: DTC Patch for Cygwin
Message-ID: <20070921184639.GA23906@ld0162-tx32.am.freescale.net>
References: <OF485FF693.8CDC7B13-ON8525735D.00541A51-8525735D.0054C8B8@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF485FF693.8CDC7B13-ON8525735D.00541A51-8525735D.0054C8B8@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 11:26:04AM -0400, Matt Tyrlik wrote:
> 
> Changes required to compile DTC under Cygwin
> 
> ===================================================================
> --- dtc-org.orig/tests/supernode_atdepth_offset.c
> +++ dtc-org/tests/supernode_atdepth_offset.c
> @@ -63,8 +63,11 @@ int path_prefix(const char *path, int de
>                 return 1;
> 
>         p = path;
> -       for (i = 0; i < depth; i++)
> -               p = strchrnul(p+1, '/');
> +       for (i = 0; i < depth; i++) {
> +               p = strchr(p+1, '/');
> +               if (!p)
> +                       p = path + strlen(path);
> +       }
> 
>         return p - path;
>  }

Maybe we should define strchrnul under #ifndef GLIBC, similar to
strndupa?

> Index: dtc-org/tests/testutils.c
> ===================================================================
> --- dtc-org.orig/tests/testutils.c
> +++ dtc-org/tests/testutils.c
> @@ -52,10 +52,9 @@ static void sigint_handler(int signum, s
>  void test_init(int argc, char *argv[])
>  {
>         int err;
> -       struct sigaction sa_int = {
> -               .sa_sigaction = sigint_handler,
> -       };
> +       struct sigaction sa_int;
> 
> +       sa_int.sa_sigaction = sigint_handler,
>         test_name = argv[0];

What version of GCC does cygwin use?  That doesn't seem like something
that should break due to OS differences.

-Scott
