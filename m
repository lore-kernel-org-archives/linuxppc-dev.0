Return-Path: <dan.j.williams@gmail.com>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C98D714009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 14:02:04 +1000 (EST)
Received: by mail-qc0-f178.google.com with SMTP id i8so3856334qcq.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Apr 2014 21:01:59 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1395303385-29461-1-git-send-email-xuelin.shi@freescale.com>
References: <1395303385-29461-1-git-send-email-xuelin.shi@freescale.com>
Date: Wed, 9 Apr 2014 21:01:59 -0700
Message-ID: <CAA9_cmcJ0Zb-X--d9_maTssWNYFd5j_hBHSx8cJiOJgkM_91FQ@mail.gmail.com>
Subject: Re: [PATCH v2] fix wrong usage of dmaengine_unmap_put in async_xxx
From: Dan Williams <dan.j.williams@intel.com>
To: xuelin.shi@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Koul, Vinod" <vinod.koul@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 1:16 AM,  <xuelin.shi@freescale.com> wrote:
> From: Xuelin Shi <xuelin.shi@freescale.com>
>
> dmaengine_unmap_put does below two things:
> a) unmap pages for srcs and dests
> b) free unmap struct
>
> The unmap struct data is generated but only initialized while
> other some dma contions are met, like dma alignment etc.
> If the unmap data is not initialized, call dmaengine_unmap_put
> will unmap some random data in unmap->addr[...]

Actually, this should be fixed by your other patch:

https://patchwork.kernel.org/patch/3863711/

Because the to_cnt, from_cnt, are properly initialized to zero.  The
only issue was that the unmap pool was not specified.

Can you verify that the problem still exists with that patch applied?
I'll mark it for -stable.

> Also call dmaengine_get_unmap_data immediatally after generating tx
> is not correct. Maybe the tx has not been finished by DMA hardware
> yet but the srcs and dests are dma unmapped.

I disagree.  It is correct because the unmap data is reference
counted.  If the DMA hardware is still using the buffers then it must
hold a reference on the unmap data.  The dmaengine_put_unmap_data()
instances your are removing are the ones that drop the initial
reference count set in dmaengine_get_unmap_data().
