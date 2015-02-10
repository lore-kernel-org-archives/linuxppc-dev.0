Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 641CB1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 19:14:12 +1100 (AEDT)
Message-ID: <1423556040.4924.90.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/1] powerpc: fix missing L2 cache size in
 /sys/devices/system/cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Olson <olson@cumulusnetworks.com>
Date: Tue, 10 Feb 2015 19:14:00 +1100
In-Reply-To: <20150210080002.GA23291@cumulusnetworks.com>
References: <20150209221421.GA22286@cumulusnetworks.com>
 <1423524827.19657.1.camel@ellerman.id.au>
 <20150209234351.GC22286@cumulusnetworks.com>
 <1423527151.4924.64.camel@kernel.crashing.org>
 <20150210080002.GA23291@cumulusnetworks.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-10 at 00:00 -0800, Dave Olson wrote:
> 
> OK, now that I understand that's the case, I'll have to go back and
> re-do the patch to handle both cache-size and d-cache-size for the
> L2 cache (using whichever is present).

I notice that you also didn't modify all the other properties, I would
assume you need to also updates in that area ? Maybe you should
duplicate the whole structure and have the code look for both.

> I don't have any power Macs to use for testing, would one of you be
> willing and able to verify the patch on a power Mac?
> 
> The patch below fixes my problem, and I don't think it will break
> platforms like the PowerPC Mac that use d-cache-size
