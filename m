Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm6zG6sFmzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 18:26:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Simon Guo <wei.guo.simon@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
In-Reply-To: <577E5BC4.2020105@linux.vnet.ibm.com>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
 <577E5BC4.2020105@linux.vnet.ibm.com>
Date: Fri, 08 Jul 2016 18:26:47 +1000
Message-ID: <8737nko7qw.fsf@@concordia.ellerman.id.au>
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

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> On 07/07/2016 15:21, Benjamin Herrenschmidt wrote:
>> On Thu, 2016-07-07 at 15:12 +0200, Laurent Dufour wrote:
>>> Most of the time this is fine, but in the case a thread which has really
>>> used those registers is catching a signal just after the restore and
>>> before it has touched to these registers again (and so set used_vsr/vr),
>>> these registers will not be pushed in the newly built signal frame since
>>> setup_sigcontext() check for used_vsr/vr before pushing the registers on
>>> the stack.
>>> This may be an issue in the case the thread wants to changed those
>>> registers (don't ask me why :)) in the stacked signal frame from the
>>> signal handler since they will not be there...
>>>
>>> Being able to get and set the used_vr and used_vsr thread's variables,
>>> fixes this issue.
>> 
>> I think the right fix is that if a restore_sigcontext() has the MSR bits set,
>> it should set the corresponding used_* flag.
>> 
>> Or is there a reason why that won't work ?
>
> I got your point and I agree that most of the time now, the Altivec/VSX
> registers are used by libc. In that case is there still a need for the
> lazy Altivec/VSX registers dump in the signal frame ?

Probably not for new programs. But it could conceivably break old
software.

> I'm fine with your proposal, except that every restarted process will
> have the used_vr/used_vsx turned on after the restart since we can't
> check if these registers were used or not at checkpoint time.
> But that may be a minor point...

Yeah I'd argue that's not worth worrying about, at least for now.

If it *is* a problem then we can fix it later.

cheers
