Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pth85fJKzF0WS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:25:44 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id n21-v6so26597063oig.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 04:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180322210528.22017-1-malat@debian.org>
 <41ptcv2xyYz9sC7@ozlabs.org>
In-Reply-To: <41ptcv2xyYz9sC7@ozlabs.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 13 Aug 2018 13:25:30 +0200
Message-ID: <CA+7wUsxG-Ys7snbY_=wgGRxcUYTN-tEMM9gqHOWidvEBmB5ogA@mail.gmail.com>
Subject: Re: cxl: remove a dead branch
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic,

Could you double check with Michael what is now best to do.

Thanks

On Mon, Aug 13, 2018 at 1:23 PM Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
>
> On Thu, 2018-03-22 at 21:05:28 UTC, Mathieu Malaterre wrote:
> > In commit 14baf4d9c739 ("cxl: Add guest-specific code") the following code
> > was added:
> >
> >       if (afu->crs_len < 0) {
> >               dev_err(&afu->dev, "Unexpected configuration record size value\n");
> >               return -EINVAL;
> >       }
> >
> > However the variable `crs_len` is of type u64 and cannot be compared < 0.
> > Remove the dead code section. Fix the following warning treated as error
> > with W=1:
> >
> > ../drivers/misc/cxl/guest.c:919:19: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> Applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/e4ecafb14fd9cd77d8f4320af1922e
>
> cheers
