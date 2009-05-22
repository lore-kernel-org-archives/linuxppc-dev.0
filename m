Return-Path: <pku.leo@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 53902DE17A
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 20:30:04 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so830790ywt.39
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 03:30:02 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090515165946.GA858@ovro.caltech.edu>
References: <20090515165946.GA858@ovro.caltech.edu>
Date: Fri, 22 May 2009 18:30:02 +0800
Message-ID: <2a27d3730905220330u1d7007d8u3d519b97a51d3bbc@mail.gmail.com>
Subject: Re: [PATCH] fsldma: fix memory leak on error path in
	fsl_dma_prep_memcpy()
From: Li Yang <leoli@freescale.com>
To: Ira Snyder <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 16, 2009 at 12:59 AM, Ira Snyder <iws@ovro.caltech.edu> wrote:
> When preparing a memcpy operation, if the kernel fails to allocate memory
> for a link descriptor after the first link descriptor has already been
> allocated, then some memory will never be released. Fix the problem by
> walking the list of allocated descriptors backwards, and freeing the
> allocated descriptors back into the DMA pool.
>
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Applied the following patches:

      fsldma: fix "DMA halt timeout!" errors
      fsldma: fix infinite loop on multi-descriptor DMA chain completion
      fsldma: snooping is not enabled for last entry in descriptor chain
      fsldma: fix memory leak on error path in fsl_dma_prep_memcpy()

Thanks
- Leo
