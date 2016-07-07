Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rldMK5CGqzDqvp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 23:12:29 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u67D8nsY001321
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:12:27 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xmb1yq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 09:12:27 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 7 Jul 2016 14:12:24 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3F2D817D805D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:13:46 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u67DCMDn17367418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 13:12:22 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u67DCLcK000913
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jul 2016 09:12:22 -0400
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
To: Michael Ellerman <mpe@ellerman.id.au>, Simon Guo <wei.guo.simon@gmail.com>
References: <3rlZmP39HNz9sXR@ozlabs.org>
Cc: Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 7 Jul 2016 15:12:20 +0200
MIME-Version: 1.0
In-Reply-To: <3rlZmP39HNz9sXR@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <577E5534.70300@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/07/2016 13:15, Michael Ellerman wrote:
> On Thu, 2016-07-07 at 07:49:36 UTC, Simon Guo wrote:
>> From: Simon Guo <wei.guo.simon@gmail.com>
>>
>> These 2 fields track whether user process has used Altivec/VSX
>> registers or not. They are used by kernel to setup signal frame
>> on user stack correctly regarding vector part.
> 
> I still dislike this. It's just exporting internal kernel state, which I know is
> the point.
> 
> And I'd still like to know why we're the only arch that needs to do this.
> 
> I'm not saying I won't merge it, but I'd like to understand it better first.
> 
>> CRIU(Checkpoint and Restore In User space) builds signal frame
>> for restored process. It will need this export information to
>> setup signal frame correctly. And CRIU will need to restore these
>> 2 fields for the restored process.
> 
> I don't really know how CRIU works, but ..
> 
> Does the kernel write a sigframe for the process that's being checkpointed? If
> so can't you infer the state of the bits based on what was written?

Hi Michael,

Basically, CRIU checkpoints the process register's state through the
ptrace API, and it restores it through a signal frame at restart time.
This is quite odd but that the way it works on all the CRIU's supported
architectures.

Obviously everything is done from/in user space, so the sigframe
building too.
Since we can't know from user space if the thread has used or not the
Altivec/VSX registers, since we can't rely on the MSR bits, we always
dump these registers.

> Alternately, when restoring, can you setup the sigframe with the Altivec/VSX
> fields populated, and the kernel will then load them, regardless of whether
> they were actually used or not prior to the checkpoint?

In the case of Altivec/VSX fields, we currently force the kernel to
retrieve them from the signal frame by setting MSR_VEC/MSR_VSX so
restore_sigcontext() will copy them to the kernel thread's state.
However this doesn't touch to used_vsr and used_vr which may remain at 0.

Most of the time this is fine, but in the case a thread which has really
used those registers is catching a signal just after the restore and
before it has touched to these registers again (and so set used_vsr/vr),
these registers will not be pushed in the newly built signal frame since
setup_sigcontext() check for used_vsr/vr before pushing the registers on
the stack.
This may be an issue in the case the thread wants to changed those
registers (don't ask me why :)) in the stacked signal frame from the
signal handler since they will not be there...

Being able to get and set the used_vr and used_vsr thread's variables,
fixes this issue.

Cheers,
Laurent.
