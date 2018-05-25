Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skqg5bhQzF1kw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:41:51 +1000 (AEST)
In-Reply-To: <3f8c7feadca2d52fa97c8feb5170c2ab67b6f992.1527065339.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v9] powerpc/mm: Only read faulting instruction when necessary in
 do_page_fault()
Message-Id: <40skqg0byNz9s3B@ozlabs.org>
Date: Fri, 25 May 2018 21:41:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-23 at 08:53:22 UTC, Christophe Leroy wrote:
> Commit a7a9dcd882a67 ("powerpc: Avoid taking a data miss on every
> userspace instruction miss") has shown that limiting the read of
> faulting instruction to likely cases improves performance.
> 
> This patch goes further into this direction by limiting the read
> of the faulting instruction to the only cases where it is likely
> needed.
> 
> On an MPC885, with the same benchmark app as in the commit referred
> above, we see a reduction of about 3900 dTLB misses (approx 3%):
> 
> Before the patch:
>  Performance counter stats for './fault 500' (10 runs):
> 
>          683033312      cpu-cycles                                                    ( +-  0.03% )
>             134538      dTLB-load-misses                                              ( +-  0.03% )
>              46099      iTLB-load-misses                                              ( +-  0.02% )
>              19681      faults                                                        ( +-  0.02% )
> 
>        5.389747878 seconds time elapsed                                          ( +-  0.06% )
> 
> With the patch:
> 
>  Performance counter stats for './fault 500' (10 runs):
> 
>          682112862      cpu-cycles                                                    ( +-  0.03% )
>             130619      dTLB-load-misses                                              ( +-  0.03% )
>              46073      iTLB-load-misses                                              ( +-  0.05% )
>              19681      faults                                                        ( +-  0.01% )
> 
>        5.381342641 seconds time elapsed                                          ( +-  0.07% )
> 
> The proper work of the huge stack expansion was tested with the
> following app:
> 
> int main(int argc, char **argv)
> {
> 	char buf[1024 * 1025];
> 
> 	sprintf(buf, "Hello world !\n");
> 	printf(buf);
> 
> 	exit(0);
> }
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e36b0d12501e278686634712975b7

cheers
