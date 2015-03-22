Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 329E21A09B9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 09:03:08 +1100 (AEDT)
Message-ID: <1427061770.4770.203.camel@kernel.crashing.org>
Subject: Re: Generic IOMMU pooled allocator
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 23 Mar 2015 09:02:50 +1100
In-Reply-To: <201503222036.02669.arnd@arndb.de>
References: <20150318.222517.1444725543017433108.davem@davemloft.net>
 <201503222036.02669.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, sowmini.varadhan@oracle.com,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-03-22 at 20:36 +0100, Arnd Bergmann wrote:

> How does this relate to the ARM implementation? There is currently
> an effort going on to make that one shared with ARM64 and possibly
> x86. Has anyone looked at both the PowerPC and ARM ways of doing the
> allocation to see if we could pick one of the two to work on
> all architectures?

What I see in ARM is horribly complex, I can't quite make sense of it
in a couple of minutes of looking at it, and doesn't seem to address the
basic issue we are addressing here which is the splitting of the iommu
table lock.

I think we are looking at two very different approaches here. One is
to deal with horrendously broken HW which is an ARM SoC vendors
signature :) The other one is about performances and scalability on sane
HW.

Cheers,
Ben.
