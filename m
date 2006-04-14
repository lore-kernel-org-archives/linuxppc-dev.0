Return-Path: <ntl@pobox.com>
Received: from proof.pobox.com (proof.pobox.com [207.106.133.28])
	by ozlabs.org (Postfix) with ESMTP id 247A6679EB
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 10:26:01 +1000 (EST)
Date: Thu, 13 Apr 2006 19:25:39 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Carl Love <cel@us.ibm.com>
Subject: Re: patch for powerpc lparcfg.c
Message-ID: <20060414002539.GC25138@localdomain>
References: <1144969793.5286.10.camel@dyn9047021119.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1144969793.5286.10.camel@dyn9047021119.beaverton.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Carl Love wrote:
> 
> I created the attached patch to print the partition name along with the
> other partition information reported in /proc/ppc64/lparcfg for the
> powerpc systems.

> diff -rauN -X /home/carll/dontdiff linux-2.6.17-rc1-git8/arch/powerpc/kernel/lparcfg.c linux-2.6.17-rc1-git8-new/arch/powerpc/kernel/lparcfg.c
> --- linux-2.6.17-rc1-git8/arch/powerpc/kernel/lparcfg.c	2006-04-13 12:25:11.000000000 -0700
> +++ linux-2.6.17-rc1-git8-new/arch/powerpc/kernel/lparcfg.c	2006-04-13 15:29:02.000000000 -0700
> @@ -360,6 +360,9 @@
>  
>  	seq_printf(m, "system_type=%s\n", model);
>  
> +	seq_printf(m, "partition_name=%s\n",
> +		   get_property(rootdn, "ibm,partition-name", NULL));
> +

Who or what is the intended consumer of this information?

You should probably check get_property's return value and print the
partition_name line only if it is non-NULL.
