Return-Path: <horia.geanta@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0078.outbound.protection.outlook.com [104.47.1.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wM3mn5bfYzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 May 2017 23:50:49 +1000 (AEST)
From: =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
CC: Nicholas Piggin <npiggin@gmail.com>, Mircea Pop <mircea.pop@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: fix distclean with Makefile.postlink
Date: Mon, 8 May 2017 13:50:42 +0000
Message-ID: <VI1PR0401MB259158901716F82DEFE1C42198EE0@VI1PR0401MB2591.eurprd04.prod.outlook.com>
References: <20170508085016.32601-1-horia.geanta@nxp.com>
 <8737cf8ssj.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/8/2017 2:57 PM, Michael Ellerman wrote:=0A=
> Horia Geant=E3 <horia.geanta@nxp.com> writes:=0A=
> =0A=
>> Makefile.postlink always includes include/config/auto.conf, however=0A=
>> this file is not present in a clean kernel tree, causing make to fail:=
=0A=
>>=0A=
>> arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such fil=
e or directory=0A=
>> make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.=
=0A=
>> make: *** [vmlinuxclean] Error 2=0A=
>>=0A=
>> Change the inclusion such that file not being found does not trigger=0A=
>> an error.=0A=
>>=0A=
>> Fixes: f188d0524d7e ("powerpc: Use the new post-link pass to check reloc=
ations")=0A=
> =0A=
> I can't reproduce this. What exact steps are you doing? And what version=
=0A=
> of Make?=0A=
> =0A=
Start with a clean kernel tree and then=0A=
make distclean=0A=
arch/powerpc/Makefile.postlink:10: include/config/auto.conf: No such=0A=
file or directory=0A=
make[1]: *** No rule to make target `include/config/auto.conf'.  Stop.=0A=
make: *** [vmlinuxclean] Error 2=0A=
=0A=
make --version=0A=
GNU Make 3.82=0A=
Built for x86_64-redhat-linux-gnu=0A=
Copyright (C) 2010  Free Software Foundation, Inc.=0A=
[...]=0A=
=0A=
The fix is basically the same as:=0A=
6e5b95cdbd0e MIPS: Fix distclean with Makefile.postlink=0A=
=0A=
Regards,=0A=
Horia=0A=
=0A=
