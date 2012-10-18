Return-Path: <robert.karl.berger@gmail.com>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA8D32C007E
 for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2012 03:33:40 +1100 (EST)
Received: by mail-bk0-f42.google.com with SMTP id j5so3660340bkw.15
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 09:33:37 -0700 (PDT)
Message-ID: <50802F4C.3000309@gmail.com>
Date: Thu, 18 Oct 2012 19:33:16 +0300
From: Robert Berger <robert.karl.berger@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: ELDK 4.2/kilauea/3.5+ kernel broken
References: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
In-Reply-To: <507EF5AD.5070203__24977.4320669987$1350497770$gmane$org@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mla@apm.com, Robert Berger <robert.karl.berger@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

git bisect tells us this:

247540b03bfcbbe26b86692c9424195d76eb67f0 is the first bad commit
commit 247540b03bfcbbe26b86692c9424195d76eb67f0
Author: Mai La <mla@apm.com>
Date:   Sun Mar 18 17:59:08 2012 +0000

    powerpc/44x: Fix PCI MSI support for Maui APM821xx SoC and Bluestone
board

    This patch consists of:
    - Enable PCI MSI as default for Bluestone board
    - Change definition of number of MSI interrupts as it depends on SoC
    - Fix returning ENODEV as finding MSI node
    - Fix MSI physical high and low address
    - Keep MSI data logically

    Signed-off-by: Mai La <mla@apm.com>
    Signed-off-by: Josh Boyer <jwboyer@gmail.com>

:040000 040000 607afba6ee61212756f2bcf5acd687d6266c39a8
2868a82b0ede19c9e38ec8a571a1004e555e1098 M      arch

Which I can confirm:

this works:
git checkout 47da421981571c69ef29740cc55fa7248682e167
save this version of arch/powerpc/sysdev/ppc4xx_msi.c

this reboots:
git checkout 247540b03bfcbbe26b86692c9424195d76eb67f0

fix .config
CONFIG_PPC_DISABLE_WERROR=y
#CONDIF_PPC_WERROR is not used

cp ../ppc4xx_msi.c from 47da421981571c69ef29740cc55fa7248682e167 to
arch/powerpc/sysdev/ppc4xx_msi.c and voila this works.

Regards,

Robert

..."I don't understand why people are frightened of new ideas. It's the
old ideas that frighten me." -- John Cage

My public pgp key is available,at:
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x90320BF1
