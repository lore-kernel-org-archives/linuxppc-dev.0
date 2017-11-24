Return-Path: <srs0=luew=cw=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjjVg1QL1zDrbn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 15:13:47 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yjjVg0rWPz8shR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 15:13:47 +1100 (AEDT)
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yjjVf4RgXz9sDB
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Nov 2017 15:13:46 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id w47so13949220uah.3
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 20:13:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171124035102.28051-1-mpe@ellerman.id.au>
References: <20171124035102.28051-1-mpe@ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 24 Nov 2017 15:13:43 +1100
Message-ID: <CAKTCnzkhNmRstER-+HK_pXzd7mUxdSE+KyqatuRpReFyjDmGUQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kexec: Fix kexec/kdump in P9 guest kernels
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>, yilzhang@redhat.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 24, 2017 at 2:51 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> The code that cleans up the IAMR/AMOR before kexec'ing failed to
> remember that when we're running as a guest AMOR is not writable, it's
> hypervisor privileged.
>
> They symptom is that the kexec stops before entering purgatory and
> nothing else is seen on the console. If you examine the state of the
> system all threads will be in the 0x700 program check handler.
>
> Fix it by making the write to AMOR dependent on HV mode.
>
> Fixes: 1e2a516e89fc ("powerpc/kexec: Fix radix to hash kexec due to IAMR/AMOR")
> Cc: stable@vger.kernel.org # v4.10+
> Reported-by: Yilin Zhang <yilzhang@redhat.com>
> Debugged-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
