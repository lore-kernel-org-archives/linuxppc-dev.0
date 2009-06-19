Return-Path: <Geoff.Thorpe@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 803ECB72B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 13:59:51 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 173B5DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 13:59:49 +1000 (EST)
Message-ID: <4A3B0D39.2000306@freescale.com>
Date: Thu, 18 Jun 2009 23:59:53 -0400
From: Geoff Thorpe <Geoff.Thorpe@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] RFC: powerpc: expose the multi-bit ops that underlie
	single-bit ops.
References: <1243361946-6771-1-git-send-email-Geoff.Thorpe@freescale.com>	<1245124418.12400.67.camel@pasglop>
	<4A37AC09.1020200@freescale.com>	<1245188026.14036.17.camel@pasglop>
	<4A3AA3FE.8090903@freescale.com> <1245363751.8693.6.camel@pasglop>
In-Reply-To: <1245363751.8693.6.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2009-06-18 at 16:30 -0400, Geoff Thorpe wrote:
>> I've left the volatile qualifier in the generated API because I didn't
>> feel so comfortable changing APIs, but I also added the "memory" clobber
>> for all cases - whereas it seems the existing set_bits(), clear_bits(),
>> [...] functions didn't declare this... Do you see any issue with having
>> the 'volatile' in the prototype as well as the clobber in the asm?
>>
>> Actually, might as well just respond to the new patch instead... :-) Thx.
> 
> I think the story with the memory clobber is that it depends whether
> we consider the functions as ordering accesses or not (ie, can
> potentially be used with lock/unlock semantics).
> 
> The general rule is that those who don't return anything don't need
> to have those semantics, and thus could only be advertised as clobbering
> p[word] -but- there are issues there. For example, despite the
> (relatively new) official _lock/_unlock variants, there's still code
> that abuses constructs like test_and_set_bit/clear_bit as locks and in
> that case, clear bits needs a clobber.
> 
> So I would say at this stage better safe than having to track down
> incredibly hard to find bugs, and let's make them all take that clobber.

Well I'm tempted agree because I'm abusing these constructs in  exactly
the manner you describe. :-) However I didn't know that this was abuse
until you mentioned it. Some time ago I noticed that the bitops code was
very similar to spinlocks, and so I presumed that a bitops word could
act as its own spinlock (ie. rather than spinlocking access to a u32).
Now that I look at spinlocks again, I see the presence of those
CLEAR_IO_SYNC definitions in the function preambles - is that the
distinction I'm abusing? CLEAR_IO_SYNC appears to be undefined except on
64-bit, in which case it's "(get_paca()->io_sync = 0)".

W.r.t the _lock/_unlock variants on the bitops side, the "lock"
particulars appear to depend on LWSYNC_ON_SMP and ISYNC_ON_SMP, which
are "isync" and "lwsync" for all platforms IIUC. So it seems the locking
intentions here are different from that of spinlocks? Is there something
I can look at that describes what semantics these primitives (are
supposed to) guarantee? I may be assuming other things that I shouldn't
be ...

Cheers,
Geoff
