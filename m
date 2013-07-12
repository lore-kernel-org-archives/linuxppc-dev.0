Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AF1282C033F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 09:06:49 +1000 (EST)
Message-ID: <1373670396.19894.215.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc/hibernate: add restore mmu context after
 resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 13 Jul 2013 09:06:36 +1000
In-Reply-To: <1373666090.8183.290@snotra>
References: <1373666090.8183.290@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "anton@enomsg.org" <anton@enomsg.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-07-12 at 16:54 -0500, Scott Wood wrote:
> set_context() doesn't exist for hash MMUs.
> 
> Whatever you do, please try actually building it on various targets,  
> including both 32 and 64 bits, and both hash and non-hash.  And make  
> sure that whatever effect PPC32 was depending on switch_mmu_context
> for  
> is preserved, including on non-booke.

The right thing to do is probably to have the various tlb_* files
provide a pair of save/restore functions that do the right thing
for that specific MMU type.

Ben.
