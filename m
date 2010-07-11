Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9CA6D1007D4
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 02:21:11 +1000 (EST)
Subject: Re: [PATCH 1/2] edac: mpc85xx: Fix MPC85xx dependency
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100708045627.GA32489@oksana.dev.rtsoft.ru>
Date: Sun, 11 Jul 2010 11:20:57 -0500
Message-Id: <D4D6F1B7-CCA0-49ED-8CDD-8F9385DDF03E@kernel.crashing.org>
References: <20100702124111.GA23320@oksana.dev.rtsoft.ru>
	<20100707144502.22b91374.akpm@linux-foundation.org>
	<20100708045627.GA32489@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Peter Tyser <ptyser@xes-inc.com>, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, linuxppc-dev@ozlabs.org,
	Doug Thompson <dougthompson@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 7, 2010, at 11:56 PM, Anton Vorontsov wrote:

> On Wed, Jul 07, 2010 at 02:45:02PM -0700, Andrew Morton wrote:
>> On Fri, 2 Jul 2010 16:41:11 +0400
>> Anton Vorontsov <avorontsov@mvista.com> wrote:
>> 
>>> Since commit 5753c082f66eca5be81f6bda85c1718c5eea6ada ("powerpc/85xx:
>>> Kconfig cleanup"), there is no MPC85xx Kconfig symbol anymore, so the
>>> driver became non-selectable.
>> 
>> hm.  5753c082f66eca5be81f6bda85c1718c5eea6ada got merged into mainline
>> six months ago.  How come nobody noticed?
> 
> Dunno. Well, it's hard to notice these sorts of things until
> somebody actually needs this driver on MPC85xx platform. :-)
> 
>>> This patch fixes the issue by switching to PPC_85xx symbol.
>>> 
>>> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
>>> ---
> [...]
>>> -	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || MPC85xx)
>>> +	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || PPC_85xx)
>>> 	help
>>> 	  Support for error detection and correction on the Freescale
>>> 	  MPC8349, MPC8560, MPC8540, MPC8548
>> 
>> I suppose we shold scoot this into 2.6.35 and mark it for -stable
>> backporting.  All very odd.
> 
> Yeah, -stable 2.6.{33,34} sounds good.
> 
> Thanks.

we should add this to mpc85xx_defconfig so we build by default.

- k
