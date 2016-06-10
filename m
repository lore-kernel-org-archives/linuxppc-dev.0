Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQrsG3ydFzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 15:51:46 +1000 (AEST)
Message-ID: <1465537595.2948.52.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Use jump label to speed up radix_enabled check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 10 Jun 2016 15:46:35 +1000
In-Reply-To: <1465532189.26682.9.camel@ellerman.id.au>
References: <1461687855-23017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461704701.3135.68.camel@kernel.crashing.org> <571FE8C1.4030903@gmail.com>
 <1461711943.3135.72.camel@kernel.crashing.org> <57200F4A.4070104@gmail.com>
 <1461721589.3586.0.camel@kernel.crashing.org>
 <87mvofedtd.fsf@skywalker.in.ibm.com>
 <1465445571.2948.29.camel@kernel.crashing.org>
 <87oa7a8ica.fsf@skywalker.in.ibm.com>
 <1465532189.26682.9.camel@ellerman.id.au>
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

On Fri, 2016-06-10 at 14:16 +1000, Michael Ellerman wrote:
> 
> It depends what that function does. It might work now, but it could break later
> when someone changes the jump label code, and it might work on some platforms
> but not others.
> 
> That is *really* early. We haven't looked at the device tree yet, we haven't
> even enabled early debug.
> 
> So I'd rather we did it later, but that has other issues I guess.

Yes it's too early. We may still change some of the CPU/MMU feature
values at that point.

Cheers,
Ben.
