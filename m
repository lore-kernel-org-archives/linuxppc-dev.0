Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BBCA1A0C24
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jan 2015 15:31:01 +1100 (AEDT)
Message-ID: <1421209860.10748.10.camel@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc/nvram: move generic code for nvram and
 pstore
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 14 Jan 2015 15:31:00 +1100
In-Reply-To: <20141224115825.25731.65673.stgit@localhost.localdomain>
References: <20141224115729.25731.20371.stgit@localhost.localdomain>
 <20141224115825.25731.65673.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-12-24 at 17:28 +0530, Hari Bathini wrote:
> With minor checks, we can move most of the code for nvram
> under pseries to a common place to be re-used by other
> powerpc platforms like powernv. This patch moves such
> common code to arch/powerpc/kernel/nvram_64.c file.

As I said in my reply to the previous version:

    ... you need to keep in mind that it is very common for us to build kernels
    with both POWERNV=y and PSERIES=y.
    
    So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
    that are optional on pseries. Not things that we *shouldn't* be doing on
    powernv.

Please explain in your commit message how you have dealt with that.


Also, you broke the build for every config that doesn't have
CONFIG_PPC_PSERIES, all 95 of them. This is pasemi_defconfig for example:

      LD      arch/powerpc/mm/built-in.o
    arch/powerpc/mm/init_64.o: In function `clobbering_unread_rtas_event':
    init_64.c:(.opd+0x48): multiple definition of `clobbering_unread_rtas_event'
    arch/powerpc/mm/mem.o:mem.c:(.opd+0x90): first defined here
    arch/powerpc/mm/init_64.o: In function `.clobbering_unread_rtas_event':
    init_64.c:(.text+0x80): multiple definition of `.clobbering_unread_rtas_event'
    arch/powerpc/mm/mem.o:mem.c:(.text+0x2c0): first defined here
      CC      arch/powerpc/kernel/udbg.o
    /home/kisskb/slave/src/scripts/Makefile.build:336: recipe for target 'arch/powerpc/mm/built-in.o' failed
    make[2]: *** [arch/powerpc/mm/built-in.o] Error 1
    /home/kisskb/slave/src/Makefile:938: recipe for target 'arch/powerpc/mm' failed
    make[1]: *** [arch/powerpc/mm] Error 2
    make[1]: *** Waiting for unfinished jobs....


cheers
