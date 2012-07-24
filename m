Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C2322C0095
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 14:46:09 +1000 (EST)
Message-ID: <1343105157.3715.6.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tabi Timur-B04825 <B04825@freescale.com>
Date: Tue, 24 Jul 2012 14:45:57 +1000
In-Reply-To: <500E1EB3.6060203@freescale.com>
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>	<500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
 <CAOZdJXXd6GuLAed_Z4zNMjDN+DBBXHdd0yVRHof+BJ_eiUMbqQ@mail.gmail.com>
 <1343085145.2957.44.camel@pasglop> <500DDB1B.9030900@freescale.com>
 <1343086186.2957.46.camel@pasglop> <500DDFF3.3000408@freescale.com>
 <1343099318.3715.0.camel@pasglop> <500E1EB3.6060203@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Chen Yuanquan-B41889 <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-07-24 at 04:04 +0000, Tabi Timur-B04825 wrote:
> Benjamin Herrenschmidt wrote:
> > Sure but I don't want to create the zones in the first place (and thus
> > introduce the added pressure on the memory management) on machines that
> > don't need it.
> 
> One thing that does confuse me -- by default, we don't create a 
> ZONE_NORMAL.  We only create a ZONE_DMA.  Why is that?  Shouldn't it be 
> the other way around?

Because ZONE_NORMAL allocations can be serviced from the ZONE_DMA while
the other way isn't possible.

Especially in the old days, there were quite a few cases of drivers
and/or subsystems who were a bit heavy handed at using ZONE_DMA, so not
having one would essentially make them not work at all.

Cheers,
Ben.
