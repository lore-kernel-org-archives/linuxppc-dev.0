Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JZt23XYRzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 17:03:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, maddy@linux.ibm.com, paulus@samba.org
Subject: Re: [PATCH] powerpc/perf: Add missing break in
 power7_marked_instr_event()
In-Reply-To: <20180920144715.GA23155@gate.crashing.org>
References: <20180920094111.4125-1-mpe@ellerman.id.au>
 <e1868207-7dd4-e6cc-0fce-04e0fd1e5edc@linux.vnet.ibm.com>
 <20180920144715.GA23155@gate.crashing.org>
Date: Mon, 24 Sep 2018 17:03:21 +1000
Message-ID: <87sh1z5qdi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Thu, Sep 20, 2018 at 03:29:22PM +0530, Madhavan Srinivasan wrote:
>> On Thursday 20 September 2018 03:11 PM, Michael Ellerman wrote:
>> >In power7_marked_instr_event() there is a switch case that is missing
>> >a break or an explicit fallthrough, it's not immediately clear which
>> >it should be.
>
>> Just curious to know, how did you find this. Static code checker compiled
>> or any specific compiler warnings or just by code read?
>
> Newer GCC warns about suspicious fallthroughs (-Wimplicit-fallthrough,
> which is in -Wextra).

Yeah I actually turned -Wimplicit-fallthrough on manually.

I'm hoping to add that to our CFLAGS once I've merged this fix and
worked out the Kbuild magic to add it to CFLAGS just for arch/powerpc.

cheers
