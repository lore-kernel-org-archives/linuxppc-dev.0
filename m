Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40b0ww3fcCzF2QP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 May 2018 22:25:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] powerpc/64s: Add support for ori barrier_nospec
 patching
In-Reply-To: <20180426181042.38971664@kitsune.suse.cz>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
 <20180424041559.32410-2-mpe@ellerman.id.au>
 <20180426181042.38971664@kitsune.suse.cz>
Date: Tue, 01 May 2018 22:25:14 +1000
Message-ID: <87sh7br2ad.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Tue, 24 Apr 2018 14:15:55 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> From: Michal Suchanek <msuchanek@suse.de>
>>=20
>> Based on the RFI patching. This is required to be able to disable the
>> speculation barrier.
>
> why do you not patch the nospec barrier which is included as part of
> the RFI flush code?

We didn't want to put it in the asm like you had, because not all RFI
flush types need the spec barrier.

So it's more complicated than just patching in the spec barrier, we'd
need to only patch it in if the configured RFI flush also needed it.

> I think when debugging the code it would make more sense if RFI is
> patched by RFI patcher and nospec by nospec patcher.

True. I think what I'm saying is that the spec barrier in the RFI
flush is not a nospec barrier, it's part of that RFI flush type.

> A separate question is if the RFI flush would break without the nospec
> barrier.

The ORI flush requires it, but the others don't.

cheers
