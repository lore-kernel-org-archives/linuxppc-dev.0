Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 0969D67BE5
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 03:43:38 +1100 (EST)
Date: Tue, 21 Nov 2006 10:43:26 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Reorganise and then fixup the pseries cpu hotplug code
Message-ID: <20061121164326.GG22435@localdomain>
References: <20061116154051.GB2008@localdomain>
	<20061117033638.0E24B67BCE@ozlabs.org>
	<20061117180456.GG23600@austin.ibm.com>
	<1163984914.7832.16.camel@localhost.localdomain>
	<45612D68.8080404@austin.ibm.com>
	<1164002356.13318.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1164002356.13318.4.camel@localhost.localdomain>
Cc: ego@in.ibm.com, linuxppc-dev@ozlabs.org, srinivasa@in.ibm.com,
	Anton Blanchard <anton@samba.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> 
> OK, it didn't occur to me that it was referring to userspace. I'll
> change it to:
> 
> /*
>  * Isolation and deallocation occur in userspace, so just stop the cpu.
>  * If isolation and deallocation ever move from userpace to kernel space
>  * we would do them here.
>  */
> 
> Sound OK?

I favor just dropping the comment.  Offline and isolate are distinct
-- offline is a per-thread operation while isolate is per-processor.
Offlining a thread does not imply that its processor will be returned
to the hypervisor (e.g. going to single thread mode from SMT).
