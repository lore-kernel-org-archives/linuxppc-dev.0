Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DFC8DDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 07:52:05 +1100 (EST)
In-Reply-To: <B63F38A9-0DD0-4DA7-8D9A-67E0829CDF37@kernel.crashing.org>
References: <1168968034.31963.11.camel@gentoo-jocke.transmode.se>
	<20070116201110.GA4332@localdomain>
	<B63F38A9-0DD0-4DA7-8D9A-67E0829CDF37@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <69C9B328-FA91-448B-BD47-49CC7D2FC6A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Warnings when booting rc5 on a mpc83xx based board
Date: Tue, 16 Jan 2007 14:51:06 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 16, 2007, at 2:36 PM, Kumar Gala wrote:

>
> On Jan 16, 2007, at 2:11 PM, Nathan Lynch wrote:
>
>> Joakim Tjernlund wrote:
>>> after upgrading to rc5 I get this:
>>>
>>> IPIC (128 IRQ sources) at fdefd700
>>> QEIC (64 IRQ sources) at fdefc080
>>> PID hash table entries: 512 (order: 9, 2048 bytes)
>>> ------------[ cut here ]------------
>>> Badness at c00f4278 [verbose debug info unavailable]
>>> Call Trace:
>>> [C0249DC0] [C00085BC] show_stack+0x48/0x194 (unreliable)
>>> [C0249DF0] [C00F2158] report_bug+0x84/0xac
>>> [C0249E00] [C000DD28] program_check_exception+0xe0/0x538
>>> [C0249E40] [C000F78C] ret_from_except_full+0x0/0x4c
>>> --- Exception: 700 at kref_get+0xc/0x24
>>>     LR = of_node_get+0x20/0x38
>>> [C0249F00] [FFFFFFFF] 0xffffffff (unreliable)
>>> [C0249F10] [C000CCA0] of_find_node_by_type+0x8c/0xd0
>>> [C0249F30] [C02198A0] get_freq+0x2c/0x80
>>> [C0249F50] [C021992C] generic_calibrate_decr+0x38/0xdc
>>> [C0249F70] [C0219E5C] time_init+0x48c/0x530
>>> [C0249FD0] [C02135F4] start_kernel+0x120/0x250
>>> [C0249FF0] [00003438] 0x3438
>>
>> Looks like it could be an unbalanced of_node_put causing a node's
>> refcount to underflow, probably the root node.  The warning in
>> kref_get has unearthed a couple of these recently, see
>>
>> http://patchwork.ozlabs.org/linuxppc/patch?id=8840
>>
>> for example.
>
> Joakim,
>
> In your board code do you having something like:
>
>          np = of_find_node_by_type(NULL, "qeic");
>          if (!np)
>                  return;
>
>          qe_ic_init(np, 0);
>          of_node_put(np);
>
> in _init_IRQ?
>
> if so remove the of_node_put() after qe_ic_init() and see if the
> issue still exists.

If this ends up being the issue we'll change qe_ic_init to stop doing  
the of_node_put() and change ipic_init() as well.  But lets first  
validate that this is the cause.

- k
