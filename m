Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 778871A0250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 08:47:03 +1100 (AEDT)
Message-ID: <1447192023.25407.0.camel@ellerman.id.au>
Subject: Re: [PATCH] of: Print rather than WARN'ing when overlap check fails
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "frowand.list@gmail.com" <frowand.list@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "mitchelh@codeaurora.org" <mitchelh@codeaurora.org>
Date: Wed, 11 Nov 2015 08:47:03 +1100
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBCEE2E@AcuExch.aculab.com>
References: <1447132113-31434-1-git-send-email-mpe@ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6D1CBCEE2E@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-10 at 09:41 +0000, David Laight wrote:

> From: Michael Ellerman

> > Sent: 10 November 2015 05:09
> > __rmem_check_for_overlap() is called very early in boot, and on some
> > powerpc systems it's not safe to call WARN that early in boot.
> > 
> > If the overlap check fails the system will oops instead of printing a
> > warning. Furthermore because it's so early in boot the console is not up
> > and the user doesn't see the oops, they just get a dead system.
> 
> Wouldn't it be better to add the required checks to WARN()?

Yes obviously it would. But that's less simple than it sounds. I'm working on
it.

cheers
