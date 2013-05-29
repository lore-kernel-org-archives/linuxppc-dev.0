Return-Path: <fweisbec@gmail.com>
Received: from mail-wg0-x231.google.com (mail-wg0-x231.google.com
 [IPv6:2a00:1450:400c:c00::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C7E262C013D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 07:32:07 +1000 (EST)
Received: by mail-wg0-f49.google.com with SMTP id y10so6708403wgg.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 14:32:03 -0700 (PDT)
Date: Wed, 29 May 2013 23:32:01 +0200
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v3 0/5] powerpc: Support context tracking for Power
 pSeries
Message-ID: <20130529213159.GD17419@somewhere>
References: <1368422493-9831-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1368424306.19924.20.camel@pasglop>
 <1368432193.2618.30.camel@ThinkPad-T5421>
 <1368435563.19924.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368435563.19924.28.camel@pasglop>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 13, 2013 at 06:59:23PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-13 at 16:03 +0800, Li Zhong wrote:
> > 
> > To my understanding, it is used to enable RCU user extended quiescent
> > state, so RCU on that cpu doesn't need scheduler ticks. And together
> > with some other code(already in 3.10), we are able to remove the ticks
> > in some cases (e.g. only 1 task running on the cpu, with some other
> > limitations).
> 
> Ok, sounds interesting. Once you fix the little cosmetic issue, I don't
> see any reason not to merge them as it's basically wiring up an existing
> feature (in that regard the patches are pretty straightforward) and I
> assume the overhead is only there when you enable it.

Yeah when CONFIG_RCU_USER_QS=n and CONFIG_VIRT_CPU_ACCOUNTING_GEN=n this
should be zero overhead. And those configs are only needed for full dynticks.

Thanks.

> 
> Cheers,
> Ben.
> 
> 
