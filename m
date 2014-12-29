Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E96941A00CA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Dec 2014 20:02:03 +1100 (AEDT)
Message-ID: <1419843707.30395.5.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Select CONFIG_PRINTK to fix build failure
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>
In-Reply-To: <1419700667-24888-2-git-send-email-bobby.prani@gmail.com>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
 <1419700667-24888-2-git-send-email-bobby.prani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Dec 2014 20:01:47 +1100
Mime-Version: 1.0
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>, hegdevasant@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "open
 list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-12-27 at 12:17 -0500, Pranith Kumar wrote:
> In an allnoconfig we get the following build failure:
 
An allnoconfig doesn't include CONFIG_PPC_POWERNV? But I think I know what you
mean.

> arch/powerpc/platforms/built-in.o: In function `.__machine_initcall_powernv_opal_init':
> opal.c:(.init.text+0x468): undefined reference to `.log_buf_addr_get'
> opal.c:(.init.text+0x474): undefined reference to `.log_buf_len_get'
> make: *** [vmlinux] Error 1
> 
> This happens because powernv requires printk() support. Enable it in the config
> file.

Sort of. It just requires those two routines. Or is there a stronger
dependency?

I think the better fix is for those two routines to be defined for
CONFIG_PRINTK=n, but return NULL and zero respectively.

And the opal code could skip registering the region when they return NULL/zero.

Care to do a couple of patches?

cheers
