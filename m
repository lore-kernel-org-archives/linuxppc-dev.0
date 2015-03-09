Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 029DD1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 18:31:43 +1100 (AEDT)
Message-ID: <1425886285.4636.241.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: book3e_64: fix the align size for paca_struct
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Mon, 09 Mar 2015 18:31:25 +1100
In-Reply-To: <20150309011314.GA13617@pek-khao-d1.corp.ad.wrs.com>
References: <1425726893-30605-1-git-send-email-haokexin@gmail.com>
 <1425806006.4636.223.camel@kernel.crashing.org>
 <20150309011314.GA13617@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-09 at 09:13 +0800, Kevin Hao wrote:
> On Sun, Mar 08, 2015 at 08:13:26PM +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2015-03-07 at 19:14 +0800, Kevin Hao wrote:
> > > All the cache line size of the current book3e 64bit SoCs are 64 bytes.
> > > So we should use this size to align the member of paca_struct.
> > > With this change we save 192 bytes. Also change it to __aligned(size)
> > > since it is preferred over __attribute__((aligned(size))).
> > 
> > Why should we favor the book3e CPUs over the book3s ones ?
> 
> Why do you think so? This only change the align size of the paca_struct's
> members which are private to book3e CPUs, and should not have any effect
> to book3s ones. Did I miss something?

No, your explanation was lacking that important detail :-)

> Thanks,
> Kevin
