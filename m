Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF6F71A0562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 16:29:24 +1100 (AEDT)
Message-ID: <1453440564.21683.8.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Allow user space to map rtas_rmo_buf
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Dan Williams <dan.j.williams@intel.com>, Nathan Fontenot
 <nfont@linux.vnet.ibm.com>
Date: Fri, 22 Jan 2016 16:29:24 +1100
In-Reply-To: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
References: <1453392931-20707-1-git-send-email-hegdevasant@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-21 at 21:45 +0530, Vasant Hegde wrote:

> With commit 90a545e9 (restrict /dev/mem to idle io memory ranges) mapping
> rtas_rmo_buf from user space is failing. Hence we are not able to make
> RTAS syscall.
> 
> This patch calls page_is_rtas_user_buf before calling iomem_is_exclusive
> in  devmem_is_allowed(). This will allow user space to map rtas_rmo_buf
> and we are able to make RTAS syscall.

Thanks for the patch.

I'll put it in my fixes branch for next week.


Having said that, why the <expletive deleted> is librtas mapping /dev/mem in
the first place? Unless there is a very good reason, and probably even if there
is, we should fix that to use a sane API.

cheers
