Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rS8m0yWgzF0sk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 19:37:11 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id c41-v6so12675723plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 02:37:11 -0700 (PDT)
Date: Wed, 23 May 2018 19:36:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180523193659.03857d14@roar.ozlabs.ibm.com>
In-Reply-To: <3f8c7feadca2d52fa97c8feb5170c2ab67b6f992.1527065339.git.christophe.leroy@c-s.fr>
References: <3f8c7feadca2d52fa97c8feb5170c2ab67b6f992.1527065339.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 23 May 2018 10:53:22 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

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

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
