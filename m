Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03E9D1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 20:31:16 +1000 (AEST)
In-Reply-To: <1430839821-9259-1-git-send-email-ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Enabling sys_kcmp for CRIU
Message-Id: <20150511103115.DFE85140187@ozlabs.org>
Date: Mon, 11 May 2015 20:31:15 +1000 (AEST)
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 15:30:21 UTC, Laurent Dufour wrote:
> The commit 8170a83f15ee ("powerpc: Wireup the kcmp syscall to sys_ni") has
> disabled the kcmp syscall for powerpc.  This has been done due to the use
> of unsigned long parameters which may require a dedicated wrapper to handle
> 32bit process on top of 64bit kernel.  However in the kcmp() case, the 2
> unsigned long parameters are currently only used to carry file descriptors
> from user space to the kernel.  Since such a parameter is passed through
> register, and file descriptor doesn't need to get extended, there is,
> today, no need for a wrapper.
> 
> In the case there will be a need to pass address in or out of this system
> call, then a wrapper could be required, it will then be to care of it.
> 
> As today this is not the case, it is safe to enable kcmp() on powerpc.

That's mostly convincing. Though I see that s390 does have a compat wrapper,
i386 doesn't. So who knows what that means.

But, there's a selftest in tools/testing/selftests/kcmp. So can you run that as
32-bit and confirm it works? Then I'd be 100% convinced :)

cheers
