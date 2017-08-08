Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRJ1R1zgSzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 12:16:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Michael Ellerman <patch-notifications@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [01/24] powerpc/mm: Move exception_enter/exit to a do_page_fault
 wrapper
In-Reply-To: <dca04b16-c97a-3d8c-a748-7945d0fb80dd@c-s.fr>
References: <3xQvGm0kQ5z9sR9@ozlabs.org>
 <dca04b16-c97a-3d8c-a748-7945d0fb80dd@c-s.fr>
Date: Tue, 08 Aug 2017 12:16:42 +1000
Message-ID: <87poc6olbp.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 07/08/2017 =C3=A0 12:41, Michael Ellerman a =C3=A9crit :
>> On Wed, 2017-07-19 at 04:49:23 UTC, Benjamin Herrenschmidt wrote:
>>> This will allow simplifying the returns from do_page_fault
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>=20
>> Series applied to powerpc next, thanks.
>>=20
>> https://git.kernel.org/powerpc/c/7afad422ac61067473d5f3d20bbd54
>
> Boot failure on the 8xx:
>
> [    6.029556] Failed to execute /init (error -14)
> [    6.034623] Starting init: /bin/sh exists but couldn't execute it=20
> (error -14)
> [    6.041489] Kernel panic - not syncing: No working init found.  Try=20
> passing init=3D option to kernel. See Linux=20
> Documentation/admin-guide/init.rst for guidance.
> [    6.055518] CPU: 0 PID: 1 Comm: init Not tainted=20
> 4.13.0-rc3-s3k-dev-00143-g7aa62e972a56 #56
> [    6.063745] Call Trace:
> [    6.066224] [c60f1ed0] [c001a624] panic+0x108/0x250 (unreliable)
> [    6.072140] [c60f1f30] [c0002640] rootfs_mount+0x0/0x58
> [    6.077311] [c60f1f40] [c000cb80] ret_from_kernel_thread+0x5c/0x64
> [    6.083405] Rebooting in 180 seconds..
>
>
> Bisected to c433ec0455f921eaf8dd0262a718ce6f8ad62ea2 ("powerpc/mm:=20
> Pre-filter SRR1 bits before do_page_fault()")

Sorry about that. I don't have a way to test 8xx.

> Will see tomorrow what's wrong with that.

Thanks.

cheers
