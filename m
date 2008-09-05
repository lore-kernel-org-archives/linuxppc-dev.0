Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id DFEAADDDEA
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 00:32:03 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so336461yxg.39
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Sep 2008 07:32:01 -0700 (PDT)
Message-ID: <48C142DF.70404@genesi-usa.com>
Date: Fri, 05 Sep 2008 09:31:59 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH, RFC] mv643xx_eth: move sram window setting code into
	the driver
References: <20080903140048.GC19602@xi.wantstofly.org>
	<48BFE63F.70700@genesi-usa.com>
	<20080904152032.GB27272@xi.wantstofly.org>
In-Reply-To: <20080904152032.GB27272@xi.wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Lennert Buytenhek wrote:
> On Thu, Sep 04, 2008 at 08:44:31AM -0500, Matt Sealey wrote:
> 
>> script, but in either case, wouldn't a real sram node in the device
>> tree be the proper solution here? Hardcoding addresses for devices
> 
> Probably.
> 
> I guess you don't want to pass that info _directly_ to the mv643xx_eth
> driver, though -- since the on-chip SRAM can be used for many things,
> and you're not necessarily sure that the user wants to use it for
> descriptors.  (Or how much of it they want to use for descriptors.)
> (Or for the descriptors of which of the 8 possible transmit and receive
> queues, considering the 2.6.27 driver supports multiple queues.)
> 
> Well, I'm not sure what the best solution is. :-)

In my view... an sram node (it would be /buildin/sram on Pegasos) which
defines the location of sram. In the mv643xx_eth driver you'd check if
you're on Pegasos and set it up, which is what the extra code amounts
to anyway. It just reduces the need to have this address hardcoded in
the kernel. Or, perhaps an sram "driver" - like the sram driver on the
MPC5200B which BestComm relies on. It's simply an rheap wrapper and a
few extra bobbins to find the base address and suchlike from the device
tree.

I'm surprised there isn't a generic sram framework in the same way there
is now a generic GPIO framework. Using rheap allocators and a generic
API you can mark every sram allocation to the owner module/usage..

>> I don't have a Pegasos running right now to test but I will, as soon
>> as possible, make sure this works first.
> 
> Cool, thanks.  It would be nice if you could give the driver in
> 2.6.27-rc5 a spin, it has seen a _lot_ of changes since 2.6.25 and
> I'd really like to make sure it still works on Pegasos.

I will definitely give it a try, time permitting.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
