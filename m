Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [64.234.241.98])
	by ozlabs.org (Postfix) with ESMTP id E4835B7157
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2010 04:59:50 +1100 (EST)
Message-ID: <4CE95E11.1050606@mlbassoc.com>
Date: Sun, 21 Nov 2010 10:59:45 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Change in PCI behaviour
References: <4CE69AF6.6090408@mlbassoc.com> <1290203218.32570.48.camel@pasglop>
In-Reply-To: <1290203218.32570.48.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/19/2010 02:46 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2010-11-19 at 08:42 -0700, Gary Thomas wrote:
>> In this case, note that PCI device 0000:00:0c.0 is at 0xc0000000.
>> This causes problems because it's a truly stupid device that does
>> not work properly at PCI [relative] address 0x00000000.  It simply
>> does not respond at that address.  Pick anywhere else and it will
>> work fine!
>
> Hrm, we used to have a trick avoid giving out the first meg of a bus to
> avoid that sort of thing, I suppose it got lost. The rest is related to
> the way you map your PCI I suppose in your dts. You can switch back to a
> 1:1 instead of 1:0 mapping I suppose.
>
> One way to achieve the above result would be to, in your platform code,
> reserve the mem region that corresponds to PCI 0...1M (c0000000...+1M)
> before the device resources are assigned/allocated.
>
> I though we had code to do that with the "legacy" regions somewhere...
> oh well, no code at hand to check right now.

Thanks, I found a combo of regions in my DTS that fixed this.

That went well and the system is now running, but it's not stable :-(
It will crash randomly, generally leaving no trace of what went wrong.
I've attached a BDI to it, but mostly all it can tell me is "it's dead"
The one thing that seems to pop up is it looks like it's jumping into
space (aka the wrong place) when doing rfi (this is a guess).  I've
seen things like the MSR ends up loaded with an address, or similar
strangeness.

Were there any system level changes during this period (I know it's
some time ago) that might have introduced such an instability?  It's
tough to scan through the diffs and get a feeling for any little details
like this.

Any ideas or hints greatly appreciated, thanks

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
