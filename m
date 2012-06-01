Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 62130B700B
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2012 08:42:58 +1000 (EST)
Message-ID: <4FC9456B.8090400@freescale.com>
Date: Fri, 1 Jun 2012 17:42:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
References: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
 <4FC62018.3040404@mindchasers.com> <1338542089.16119.48.camel@pasglop>
 <4FC8EDC4.2050704@freescale.com> <1338589800.16119.58.camel@pasglop>
In-Reply-To: <1338589800.16119.58.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Bob Cochran <ppc@mindchasers.com>,
 support@abatron.ch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/01/2012 05:30 PM, Benjamin Herrenschmidt wrote:
> BTW. My point of view is that this whole business about MSR:DE is a HW
> design bug. There should be -no- (absolutely 0) interaction between the
> SW state and the HW debugger for normal operations unless the user of
> the debugger explicitly wants to change some state.

I agree entirely, and e500mc at least has less of this than e500v2 (not
sure if it still needs MSR[DE], but supposedly it doesn't have the
requirement for there to be a valid instruction at the debug vector,
which is lots of fun when booting).  But this isn't exactly something
Freescale is going to replace existing chips over.

Getting all the way to zero interaction would require a completely
separate debug facility so software can debug at the same time.  I'd be
all for that (and let's throw in a third, for the hypervisor), but I'm
not the one that needs to be convinced.

-Scott
