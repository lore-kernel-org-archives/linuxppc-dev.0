Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rldzc3QXQzDqy7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 23:40:27 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67DXYPS126676
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:40:25 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xmkyfm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 09:40:25 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 14:40:23 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D66E01B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:41:40 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u67DeMut16581044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 13:40:22 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u67DeLZX025690
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 07:40:22 -0600
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Simon Guo <wei.guo.simon@gmail.com>
References: <3rlZmP39HNz9sXR@ozlabs.org> <577E5534.70300@linux.vnet.ibm.com>
 <1467897678.27157.45.camel@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Rashmica Gupta <rashmicy@gmail.com>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 7 Jul 2016 15:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <1467897678.27157.45.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <577E5BC4.2020105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 15:21, Benjamin Herrenschmidt wrote:
> On Thu, 2016-07-07 at 15:12 +0200, Laurent Dufour wrote:
>>
>> Basically, CRIU checkpoints the process register's state through the
>> ptrace API, and it restores it through a signal frame at restart time.
>> This is quite odd but that the way it works on all the CRIU's supported
>> architectures.
>>
>> Obviously everything is done from/in user space, so the sigframe
>> building too.
>> Since we can't know from user space if the thread has used or not the
>> Altivec/VSX registers, since we can't rely on the MSR bits, we always
>> dump these registers.
> 
> Right, however is that an issue ? These days with glibc using V{M,S}X
> for things like memcpy I would think there is little to gain in trying
> to avoid dumping them.
> 
>>> Alternately, when restoring, can you setup the sigframe with the Altivec/VSX
>>> fields populated, and the kernel will then load them, regardless of whether
>>> they were actually used or not prior to the checkpoint?
>>
>> In the case of Altivec/VSX fields, we currently force the kernel to
>> retrieve them from the signal frame by setting MSR_VEC/MSR_VSX so
>> restore_sigcontext() will copy them to the kernel thread's state.
> 
> Yup, that's the way to go.
> 
>> However this doesn't touch to used_vsr and used_vr which may remain at 0.
> 
> That would be a kernel bug.
> 
>> Most of the time this is fine, but in the case a thread which has really
>> used those registers is catching a signal just after the restore and
>> before it has touched to these registers again (and so set used_vsr/vr),
>> these registers will not be pushed in the newly built signal frame since
>> setup_sigcontext() check for used_vsr/vr before pushing the registers on
>> the stack.
>> This may be an issue in the case the thread wants to changed those
>> registers (don't ask me why :)) in the stacked signal frame from the
>> signal handler since they will not be there...
>>
>> Being able to get and set the used_vr and used_vsr thread's variables,
>> fixes this issue.
> 
> I think the right fix is that if a restore_sigcontext() has the MSR bits set,
> it should set the corresponding used_* flag.
> 
> Or is there a reason why that won't work ?

I got your point and I agree that most of the time now, the Altivec/VSX
registers are used by libc. In that case is there still a need for the
lazy Altivec/VSX registers dump in the signal frame ?

I'm fine with your proposal, except that every restarted process will
have the used_vr/used_vsx turned on after the restart since we can't
check if these registers were used or not at checkpoint time.
But that may be a minor point...

Cheers,
Laurent.
