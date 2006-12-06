Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 3352F67C0C
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 05:37:34 +1100 (EST)
Message-ID: <45770E44.30000@ru.mvista.com>
Date: Wed, 06 Dec 2006 21:39:00 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
References: <20061206182922.GA17931@austin.ibm.com>
In-Reply-To: <20061206182922.GA17931@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Linas Vepstas wrote:

> Paul,
> Please apply. This atch resulted from an email discussion
> back in Sept.

> --linas

> Clarify why twi appears in the i/o macros.

> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
> 
> ----
>  include/asm-powerpc/io.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: linux-2.6.19-git7/include/asm-powerpc/io.h
> ===================================================================
> --- linux-2.6.19-git7.orig/include/asm-powerpc/io.h	2006-12-05 17:11:02.000000000 -0600
> +++ linux-2.6.19-git7/include/asm-powerpc/io.h	2006-12-06 11:48:43.000000000 -0600
> @@ -78,6 +78,17 @@ extern unsigned long pci_dram_offset;
>   * Note: I might drop the _ns suffix on the stream operations soon as it is
>   * simply normal for stream operations to not swap in the first place.
>   *
> + * Read operations have additional twi & isync to make sure the read
> + * is actually performed (i.e. the data has come back) before we start
> + * executing any following instructions.
> + *
> + * A data-dependent branch followed by an isync ensures that no
> + * instructions after the isync in program order will be
> + * (speculatively) executed before the isync has completed, and
> + * the isync won't complete until the branch is resolved. The
> + * the load that the twi depends on has to complete before

    A minor type here -- double "the".

> + * anything else is executed; in particular, it's a barrier to
> + * keep MMIO reads ordered before main-storage accesses.
>   */
>  
>  #ifdef CONFIG_PPC64

WBR, Sergei
