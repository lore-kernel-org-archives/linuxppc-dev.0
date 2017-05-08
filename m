Return-Path: <jmforbes@linuxtx.org>
Received: from mail-io0-x242.google.com (mail-io0-x242.google.com
 [IPv6:2607:f8b0:4001:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wMG5K520fzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 May 2017 07:35:49 +1000 (AEST)
Received: by mail-io0-x242.google.com with SMTP id 12so10215982iol.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 May 2017 14:35:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB259158901716F82DEFE1C42198EE0@VI1PR0401MB2591.eurprd04.prod.outlook.com>
References: <20170508085016.32601-1-horia.geanta@nxp.com>
 <8737cf8ssj.fsf@concordia.ellerman.id.au>
 <VI1PR0401MB259158901716F82DEFE1C42198EE0@VI1PR0401MB2591.eurprd04.prod.outlook.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 8 May 2017 16:35:45 -0500
Message-ID: <CAFxkdAqCdY6g2Gb7rC_A+tgqSZj1ey9rPV9UrXMBq92BR_eSYg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fix distclean with Makefile.postlink
To: =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 Mircea Pop <mircea.pop@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 8, 2017 at 8:50 AM, Horia Geant=C4=83 <horia.geanta@nxp.com> wr=
ote:
> On 5/8/2017 2:57 PM, Michael Ellerman wrote:
>> Horia Geant=C4=83 <horia.geanta@nxp.com> writes:
>>
>>> Makefile.postlink always includes include/config/auto.conf, however
>>> this file is not present in a clean kernel tree, causing make to fail:
>>>
>>> arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such fi=
le or directory
>>> make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.
>>> make: *** [vmlinuxclean] Error 2
>>>
>>> Change the inclusion such that file not being found does not trigger
>>> an error.
>>>
>>> Fixes: f188d0524d7e ("powerpc: Use the new post-link pass to check relo=
cations")
>>
>> I can't reproduce this. What exact steps are you doing? And what version
>> of Make?
>>
> Start with a clean kernel tree and then
> make distclean
> arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such
> file or directory
> make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.
> make: *** [vmlinuxclean] Error 2
>
> make --version
> GNU Make 3.82
> Built for x86_64-redhat-linux-gnu
> Copyright (C) 2010  Free Software Foundation, Inc.
> [...]
>
> The fix is basically the same as:
> 6e5b95cdbd0e MIPS: Fix distclean with Makefile.postlink
>

Noticed it on the Fedora builds as well today.  This patch fixes it.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
