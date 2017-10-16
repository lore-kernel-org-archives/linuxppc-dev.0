Return-Path: <srs0=gx01=bp=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFjTT201tzDrF8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 13:49:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yFjTT1G4jz8tMZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 13:49:33 +1100 (AEDT)
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yFjTR4Wwxz9sPt
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Oct 2017 13:49:31 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id v78so5647098pgb.5
 for <linuxppc-dev@ozlabs.org>; Sun, 15 Oct 2017 19:49:31 -0700 (PDT)
Date: Mon, 16 Oct 2017 13:49:20 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3] powerpc/xmon: Support dumping software pagetables
Message-ID: <20171016134920.02a9171a@firefly.ozlabs.ibm.com>
In-Reply-To: <201710121832.OsecvU0R%fengguang.wu@intel.com>
References: <1507546335-27120-1-git-send-email-mpe@ellerman.id.au>
 <201710121832.OsecvU0R%fengguang.wu@intel.com>
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

On Thu, 12 Oct 2017 18:20:39 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Balbir,
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.14-rc4 next-20171009]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Michael-Ellerman/powerpc-xmon-Support-dumping-software-pagetables/20171012-124024
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-ppc6xx_defconfig (attached as .config)
> compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/powerpc/include/asm/book3s/pgtable.h:7:0,
>                     from arch/powerpc/include/asm/pgtable.h:16,
>                     from include/linux/memremap.h:7,
>                     from include/linux/mm.h:26,
>                     from arch/powerpc/xmon/xmon.c:18:
>    arch/powerpc/xmon/xmon.c: In function 'show_pte':
> >> arch/powerpc/include/asm/book3s/32/pgtable.h:282:13: error: implicit declaration of function 'kmap_atomic' [-Werror=implicit-function-declaration]  
>      ((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))
>                 ^
> >> arch/powerpc/xmon/xmon.c:3042:9: note: in expansion of macro 'pte_offset_map'  
>      ptep = pte_offset_map(pmdp, addr);
>             ^~~~~~~~~~~~~~

for pte_offset_map() to work, we need linux/highmem.h to be included
in xmon.c.

Balbir Singh.
