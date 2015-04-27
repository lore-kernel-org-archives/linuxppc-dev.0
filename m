Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 974211A0279
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 10:30:37 +1000 (AEST)
Message-ID: <1430094636.8494.3.camel@ellerman.id.au>
Subject: Re: [PATCH] ehea: Fix memory hook reference counting crashes
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Miller <davem@davemloft.net>
Date: Mon, 27 Apr 2015 10:30:36 +1000
In-Reply-To: <20150425.144354.1149917806926276049.davem@davemloft.net>
References: <1429854752-5698-1-git-send-email-mpe@ellerman.id.au>
 <20150425.144354.1149917806926276049.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, anton@samba.org, cascardo@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-04-25 at 14:43 -0400, David Miller wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> Date: Fri, 24 Apr 2015 15:52:32 +1000
> 
> > The recent commit to only register the EHEA memory hotplug hooks on
> > adapter probe has a few problems.
> > 
> > Firstly the reference counting is wrong for multiple adapters, in that
> > the hooks are registered multiple times. Secondly the check in the tear
> > down path is backward. Finally the error path doesn't decrement the
> > count.
> > 
> > The multiple registration of the hooks is the biggest problem, as it
> > leads to oopses when the system is rebooted, and/or errors during memory
> > hotplug, eg:
>  ...
> > Fixes: aa183323312d ("ehea: Register memory hotplug, reboot and crash hooks on adapter probe")
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Applied, but using an atomic counter for this is really inappropriate
> and is what lead to this bug in the first place.
> 
> You're not counting anything, because if you were, then you would be
> decrementing this thing somewhere.
> 
> Rather, it's purely a boolean state saying "I did X".  So it should be
> a boolean, and no atomicity nor other special considerations are
> needed for setting it to true.

Yeah I agree, it's a mess.

We should be unregistering the hooks when the last adapter is removed, which is
where we'd do the decrement. As it's written the hooks stay registered until
the driver is removed.

I'll try and find time, or someone else with time, to fix it up properly for 4.2.

cheers
