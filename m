Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CB86B7D39
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 03:36:24 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAAGa5qN001898
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 09:36:16 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAAGdpXM002855
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 10:39:51 -0600 (CST)
Message-ID: <4AF99695.800@freescale.com>
Date: Tue, 10 Nov 2009 10:36:37 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091106003305.GA15814@loki.buserror.net>
	<OF2C4359C9.0EB89938-ONC1257666.00299975-C1257666.002C206F@transmode.se>
	<OFBF62CE94.BC53D847-ONC1257666.0033CF65-C1257666.0034293A@transmode.se>
	<20091109215321.GA4351@loki.buserror.net>
	<20091109230004.GA24671@loki.buserror.net>
	<OF0C254AE9.CCCFDCCC-ONC125766A.002D331C-C125766A.002E7C69@transmode.se>
In-Reply-To: <OF0C254AE9.CCCFDCCC-ONC125766A.002D331C-C125766A.002E7C69@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 10/11/2009 00:00:04:
>> syscall_exit_cont, SRR0/SRR1 were being loaded immediately prior to a page
>> boundary, with the rfi after the page boundary.  On crossing the boundary,
>> we take an ITLB miss (which goes from possibility to certainty with the
>> CPU15 workaround), and SRR0/SRR1 get clobbered.
> 
> I am not familiar with CPU15 since we never had that problem.
> The patch series is OK then, but one need to add some CPU15 love?

It's not CPU15 itself that is causing the problem, but rather the 
workaround for CPU15 takes something that has a possibility of happening 
and makes it certain to happen.

>> Either that, or require that the kernel text be pinned, though that does not
>> interact well with CPU15.
> 
> Why does not pinning interact well with CPU15? If pinned, you never get
> a TLB miss for kernel text so that should mitigate the CPU15 problem.

The nature of the workaround for CPU15 is that we can't keep it pinned 
-- we have to take an ITLB miss on every page boundary crossing.  If you 
try to pin, it'll just be invalidated by the workaround.

There is an alternate workaround, but it requires compiler changes.

-Scott
