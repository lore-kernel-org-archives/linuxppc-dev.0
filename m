Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22e.google.com (mail-qk0-x22e.google.com
 [IPv6:2607:f8b0:400d:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdKNf2CQjzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 16:51:46 +1000 (AEST)
Received: by mail-qk0-x22e.google.com with SMTP id p10so196956447qke.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jun 2016 23:51:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87shvzcklm.fsf@linux.vnet.ibm.com>
References: <1466754085-8230-1-git-send-email-oohall@gmail.com>
 <1466772481-11424-1-git-send-email-oohall@gmail.com>
 <87shvzcklm.fsf@linux.vnet.ibm.com>
From: oliver <oohall@gmail.com>
Date: Mon, 27 Jun 2016 16:51:43 +1000
Message-ID: <CAOSf1CHP-PFf2nthzuPkUGZ5hcrSr2idGHDSc5XfZct7F4f7Jw@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/boot: Add OPAL console to epapr wrappers
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2016 at 2:38 PM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> Oliver O'Halloran <oohall@gmail.com> writes:
> One thing to think of is if we really need anything printed except the
> error message. Out of these three lines of output (for a corrupted
> zImage.epapr), only the last line gives any real information.
>
> 5343492: (5343490): zImage starting: loaded at 0x0000000020010000 (sp: 0x0000000020ee2ed8)
> 5507562: (5507560): Allocating 0x159efd4 bytes for kernel ...
> 5557104: (5557102): gunzipping (0x0000000000000000 <- 0x000000002001e000:0x0000000020ee05c0)...inflate returned -3 msg: invalid block type
>
> Although this should likely be addressed in another patch.

None of this is useful to us since we get most of this information
from skiboot, but I'm not sure that's true for other platforms. The
kernel boot log is fairly noisy as-is so we don't gain much from
trimming. At the very least the other messages provide sanity checks
that we've exited firmware and/or the bootloader without issues. I'll
look at changing the returned error messages though, "invalid block
type" is a pretty error useless you already know what you're looking
for.

> Needs (C) header.

There's always something missing ;)
