Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DBEEB6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2012 06:20:37 +1000 (EST)
Message-ID: <4FC68109.3030607@freescale.com>
Date: Wed, 30 May 2012 15:20:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anthony Foiani <tkil@scrye.com>
Subject: Re: ppc/sata-fsl: orphan config value: CONFIG_MPC8315_DS
References: <ghave7n25.fsf@dworkin.scrye.com>
 <94F013E7935FF44C83EBE7784D62AD3F0930B855@039-SN2MPN1-022.039d.mgd.msft.net>
 <g7gvzbfhb.fsf@dworkin.scrye.com> <4FC50F22.2040404@freescale.com>
 <gvcjetze3.fsf@dworkin.scrye.com> <4FC5546A.4090506@freescale.com>
 <gd35lbf55.fsf@dworkin.scrye.com>
In-Reply-To: <gd35lbf55.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "Robert P.J.Day" <rpjday@crashcourse.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>, Jeff Garzik <jeff@garzik.org>,
 Adrian Bunk <bunk@stusta.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2012 03:14 PM, Anthony Foiani wrote:
> Scott Wood <scottwood@freescale.com> writes:
> 
>> Board information is available from the device tree, and from
>> platform code that was selected based on the device tree.
> 
> You're right, of course; I was focusing on discovery/probing, and
> completely forgot about "provided information".
> 
> However, as I just mentioned in my reply to Yang, I'm pretty happy
> with the kconfig solution (Adrian's patch, basically).
> 
> If we find that this is a more widespread problem, we can revisit this
> discussion; but if only a handful of us have encountered this in a
> 5-year-old design, then I don't think it's worth the extra effort of
> making it dynamic.

We currently support building one kernel that supports a bunch of
different boards.  The hardcoding of this workaround was harmless so far
because it was conditional on a symbol that was never defined, but now
you'll be enabling this workaround on any kernel that simply has support
for mpc8315erdb.  That is not acceptable unless you show it's harmless
on all those other boards.

-Scott
