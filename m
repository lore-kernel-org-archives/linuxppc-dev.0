Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlZmP4rXVzDqpJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 21:15:33 +1000 (AEST)
In-Reply-To: <1467877776-5618-1-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Simon Guo <wei.guo.simon@gmail.com>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v4] powerpc: Export thread_struct.used_vr/used_vsr to user space
Message-Id: <3rlZmP39HNz9sXR@ozlabs.org>
Date: Thu,  7 Jul 2016 21:15:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-07-07 at 07:49:36 UTC, Simon Guo wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> These 2 fields track whether user process has used Altivec/VSX
> registers or not. They are used by kernel to setup signal frame
> on user stack correctly regarding vector part.

I still dislike this. It's just exporting internal kernel state, which I know is
the point.

And I'd still like to know why we're the only arch that needs to do this.

I'm not saying I won't merge it, but I'd like to understand it better first.

> CRIU(Checkpoint and Restore In User space) builds signal frame
> for restored process. It will need this export information to
> setup signal frame correctly. And CRIU will need to restore these
> 2 fields for the restored process.

I don't really know how CRIU works, but ..

Does the kernel write a sigframe for the process that's being checkpointed? If
so can't you infer the state of the bits based on what was written?

Alternately, when restoring, can you setup the sigframe with the Altivec/VSX
fields populated, and the kernel will then load them, regardless of whether
they were actually used or not prior to the checkpoint?

cheers
