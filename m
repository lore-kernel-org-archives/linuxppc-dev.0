Return-Path: <srs0=ublm=7e=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xN7155Fj1zDrHV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 08:20:25 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xN71546Sbz8vl5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 08:20:25 +1000 (AEST)
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xN71254xtz9sCZ
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2017 08:20:22 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id d136so5957351qkg.3
 for <linuxppc-dev@ozlabs.org>; Wed, 02 Aug 2017 15:20:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
References: <1501583364-14909-1-git-send-email-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 3 Aug 2017 08:20:19 +1000
Message-ID: <CAKTCnzmyPz0yEA5R2DA4qSs5t-QdJfAcn9R1codUV9fKmWiBMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc/mm/book3s64: Make KERN_IO_START a variable
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 1, 2017 at 8:29 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Currently KERN_IO_START is defined as:
>
>  #define KERN_IO_START  (KERN_VIRT_START + (KERN_VIRT_SIZE >> 1))
>
> Although it looks like a constant, both the components are actually
> variables, to allow us to have a different value between Radix and
> Hash with a single kernel.
>
> However that still requires both Radix and Hash to place the kernel IO
> region at the same location relative to the start and end of the
> kernel virtual region (namely 1/2 way through it), and we'd like to
> change that.
>
> So split KERN_IO_START out into its own variable, and initialise it
> for Radix and Hash. In the medium term we should be able to
> reconsolidate this, by doing a more involved rearrangement of the
> location of the regions.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
