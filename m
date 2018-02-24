Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x236.google.com (mail-pl0-x236.google.com
 [IPv6:2607:f8b0:400e:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zpKvL41pzzF1c9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 18:47:58 +1100 (AEDT)
Received: by mail-pl0-x236.google.com with SMTP id w21so6258822plp.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:47:57 -0800 (PST)
Date: Sat, 24 Feb 2018 17:47:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 3/6] powerpc/mm/slice: Enhance for supporting PPC32
Message-ID: <20180224174744.0bfec326@roar.ozlabs.ibm.com>
In-Reply-To: <3e9cfc87e78d61310d1b628960a465327c20d895.1519305411.git.christophe.leroy@c-s.fr>
References: <455276187b369bf019e91715b7488e86cd932d49.1519305410.git.christophe.leroy@c-s.fr>
 <3e9cfc87e78d61310d1b628960a465327c20d895.1519305411.git.christophe.leroy@c-s.fr>
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

On Thu, 22 Feb 2018 15:27:24 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> In preparation for the following patch which will fix an issue on
> the 8xx by re-using the 'slices', this patch enhances the
> 'slices' implementation to support 32 bits CPUs.
> 
> On PPC32, the address space is limited to 4Gbytes, hence only the low
> slices will be used.
> 
> The high slices use bitmaps. As bitmap functions are not prepared to
> handle bitmaps of size 0, this patch ensures that bitmap functions
> are called only when SLICE_NUM_HIGH is not nul.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

This looks good to me, thank you for taking my feedback into account.

Is the patch split and naming good? Yes I guess so, this adds support
for ppc32 archs that select PPC_MM_SLICES, and the next one implements
it for 8xx. There looks to be some generic arch/powerpc/mm bits in the
next patch. I wonder if you would move them over? Then the next patch
could be called powerpc/8xx: ?

Anyway it's not a big deal.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
