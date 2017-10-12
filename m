Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCV0x0GrJzDr4T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 23:05:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Add kernel cmdline parameter to disable
 imc
In-Reply-To: <06fe39eb-d5fe-4472-56b4-f66390d7fad9@linux.vnet.ibm.com>
References: <1507531597-25947-1-git-send-email-anju@linux.vnet.ibm.com>
 <87wp43wf2v.fsf@concordia.ellerman.id.au> <87infmeonf.fsf@linux.vnet.ibm.com>
 <06fe39eb-d5fe-4472-56b4-f66390d7fad9@linux.vnet.ibm.com>
Date: Thu, 12 Oct 2017 23:05:36 +1100
Message-ID: <87r2u8tvu7.fsf@concordia.ellerman.id.au>
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

Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:

> Hi mpe, stewart,
>
>
> On Wednesday 11 October 2017 01:55 AM, Stewart Smith wrote:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Anju T Sudhakar <anju@linux.vnet.ibm.com> writes:
>>>
>>>> Add a kernel command line parameter option to disable In-Memory Collec=
tion
>>>> (IMC) counters and add documentation. This helps in debug.
>>> I'd really rather we didn't. Do we *really* need this?
>>>
>>> We don't have command line parameters to disable any of the other ~20
>>> PMUs, why is this one special?
>
> This one is really helpful in debugging, incase if we want to proceed=20
> without nest counters=C2=A0 OR
> core counters . But if we have the facility to do the same from=20
> petitboot, its fine.

I understand it's helpful for debugging.

But we can't afford to have a command line option to disable every
~1K SLOC of code.

If there's a compelling reason why we need to disable IMC *on production
systems* - then a command line option is a possibility. Though really if
there is a compelling reason for that maybe we have bigger problems :)

This is also a very new driver, so we're still finding some bugs, in a
few months it should be more stable and then the command line option
will just be cruft.

cheers
