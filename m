Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5xVN2d5nzDqpT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 22:23:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
In-Reply-To: <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
Date: Tue, 03 Oct 2017 22:23:22 +1100
Message-ID: <87poa4cw5x.fsf@concordia.ellerman.id.au>
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> On 09/23/2017 10:26 AM, C=C3=A9dric Le Goater wrote:
>> Hi,
>>=20
>> Here are a couple of small fixes to support CPU hot unplug. There are
>> still some issues to be investigated as, in some occasions, after a
>> couple of plug and unplug, the cpu which was removed receives a 'lost'
>> interrupt. This showed to be the decrementer under QEMU.
>
> So this seems to be a QEMU issue only which can be solved by=20
> removing the DEE bit from the LPCR on P9 processor when the CPU=20
> is stopped in rtas. PECE3 bit on P8 processors.=20
>
> I think these patches are valuable fixes for 4.14. The first=20
> is trivial and the second touches the common xive part but it
> is only called on the pseries platform.=20=20
>
> Could you please take a look ?=20

I can.

You didn't give me much indication in the change logs of what the
failure mode is if I _don't_ have the fixes, which makes it hard for me
to assess the severity. Can you flesh out the ".. or else" case in the
change logs?

And should both be tagged?

  Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interr=
upt controller")

cheers
