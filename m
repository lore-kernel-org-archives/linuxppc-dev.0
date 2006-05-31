Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 692B667A65
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jun 2006 07:25:46 +1000 (EST)
Message-ID: <447E09D6.2090402@am.sony.com>
Date: Wed, 31 May 2006 14:25:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: Collecting hypervisor call stats
References: <20060531204144.GA7909@w-mikek2.ibm.com>
In-Reply-To: <20060531204144.GA7909@w-mikek2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Kravetz wrote:
> We would like to add code that gathers statistics about hypervisor calls.
> It would keep track of things like # of calls made for each opcode as well
> as time spent processing the calls.
> 
> The 'obvious' place to gather such statistics would be from within the
> routines making hcalls in hvCall.S.  Once thing that I have noticed is
> the following comment at the beginning hvCall.S:
> 
>  * NOTE: this file will go away when we move to inline this work.
> 
> So, it appears someone thought/thinks these routines should be inlined.  
> I assume this is for performance reasons?  If this is the case, then I
> suspect gathering of statistics (which would introduce overhead) would
> meet resistance?
> 
> Comments about the feasibility of adding such statistic gathering code
> would be appreciated.


FYI, there exists an add-on feature KFT (kernel function trace)
which you may be able to extend to do much of what you want.  It
uses gcc's -finstrument-functions option to hook into the
entry and exit of C functions.  You may able to add the hooks
by hand to the asm routines in hvCall.S and then take advantage
of the existing KFT functionality to start and stop traces, post
process the data, etc.

http://tree.celinuxforum.org/CelfPubWiki/KernelFunctionTrace

-Geoff
