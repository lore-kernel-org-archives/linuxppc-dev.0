Return-Path: <hartb@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 27FDB140101
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 01:38:18 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hartb@linux.vnet.ibm.com>;
 Tue, 29 Apr 2014 09:38:16 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B5B8FC40008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 09:38:12 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3TFbPJB5702058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 17:37:26 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s3TFfws3027272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 09:41:58 -0600
Received: from oc3347516403.ibm.com (dhcp-9-41-222-173.austin.ibm.com
 [9.41.222.173])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 s3TFfrsI026922
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Apr 2014 09:41:58 -0600
Date: Tue, 29 Apr 2014 10:38:06 -0500
From: Brian W Hart <hartb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] powerpc: crtsaveres.o needed only when -Os flag is
 enabled
Message-ID: <20140429153806.GA25743@oc3347516403.ibm.com>
References: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398729908-15787-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2014 at 05:05:08PM -0700, Ram Pai wrote:
>     powerpc: crtsaveres.o needed only when -Os flag is enabled
>     
>     Currently on powerpc arch, out-of-tree module fails to build without
>     crtsaveres.o, even when the module has no dependency on the symbols
>     provided by the file; when built without the -Os flag.
>     
>     BTW: '-Os' flag is enabled when CONFIG_CC_OPTIMIZE_FOR_SIZE is
>     configured.
>     
>     This patch fixes that problem.
>     
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 4c0cedf..cf12f38 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -157,7 +157,10 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
>  
>  CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
>  
> +ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>  KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> +endif
> +
>  
>  # No AltiVec or VSX instructions when building kernel
>  KBUILD_CFLAGS += $(call cc-option,-mno-altivec)

I didn't try building a kernel or in-tree modules, but I confirmed
that it allows building of out-of-tree modules when crtsavres.o is
not present (e.g. as for a distro install where the kernel headers
are provided by package, rather than being manually prepared from
the sources).

Tested-by: Brian W Hart <hartb@linux.vnet.ibm.com>
