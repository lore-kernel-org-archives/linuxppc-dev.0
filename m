Return-Path: <bobby.prani@gmail.com>
Received: from mail-vc0-x230.google.com (mail-vc0-x230.google.com
 [IPv6:2607:f8b0:400c:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D403B1A0216
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Dec 2014 16:47:24 +1100 (AEDT)
Received: by mail-vc0-f176.google.com with SMTP id hq12so5505309vcb.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Dec 2014 21:47:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1419843707.30395.5.camel@ellerman.id.au>
References: <1419700667-24888-1-git-send-email-bobby.prani@gmail.com>
 <1419700667-24888-2-git-send-email-bobby.prani@gmail.com>
 <1419843707.30395.5.camel@ellerman.id.au>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 30 Dec 2014 00:46:52 -0500
Message-ID: <CAJhHMCDNGRxWn41Wo+4i3-Y4okpgCyiKwNFXxciZZF=T+nwmgw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Select CONFIG_PRINTK to fix build failure
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>, hegdevasant@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 29, 2014 at 4:01 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Sat, 2014-12-27 at 12:17 -0500, Pranith Kumar wrote:
>> In an allnoconfig we get the following build failure:
>
> An allnoconfig doesn't include CONFIG_PPC_POWERNV? But I think I know what you
> mean.
>
>> arch/powerpc/platforms/built-in.o: In function `.__machine_initcall_powernv_opal_init':
>> opal.c:(.init.text+0x468): undefined reference to `.log_buf_addr_get'
>> opal.c:(.init.text+0x474): undefined reference to `.log_buf_len_get'
>> make: *** [vmlinux] Error 1
>>
>> This happens because powernv requires printk() support. Enable it in the config
>> file.
>
> Sort of. It just requires those two routines. Or is there a stronger
> dependency?
>
> I think the better fix is for those two routines to be defined for
> CONFIG_PRINTK=n, but return NULL and zero respectively.
>
> And the opal code could skip registering the region when they return NULL/zero.
>
> Care to do a couple of patches?
>

Sure, I will give it a try. Thanks for the review!


-- 
Pranith
