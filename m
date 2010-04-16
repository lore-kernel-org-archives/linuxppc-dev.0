Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7889EB7D7E
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Apr 2010 01:48:14 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3GFmACj018714
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 08:48:10 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3GFvroU017671
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 10:57:54 -0500 (CDT)
Message-ID: <4BC886B9.7080202@freescale.com>
Date: Fri, 16 Apr 2010 10:48:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2] powerpc: Add hibernation support for FSL BookE
	processors
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>
	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
	<4BC77174.1020305@freescale.com>
	<20100416054010.GA391@oksana.dev.rtsoft.ru>
In-Reply-To: <20100416054010.GA391@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Thu, Apr 15, 2010 at 03:05:08PM -0500, Scott Wood wrote:
>> Kumar Gala wrote:
>>> On Apr 15, 2010, at 1:45 PM, Anton Vorontsov wrote:
>>>> Kumar,
>>>>
>>>> According to patchwork, this is now delegated to you. Do you
>>>> have any objections to merge this?
>>> Would like Scott's Ack.
>> I think we need to save IACn, DACn, DBCRn,
> 
> Does the kernel actually need these registers? I mean, they're
> saved per thread anyway.
> 
>> PID0,
> 
> Kernel clears it early at boot, why would we save it?

What context are we in when we suspend, and what context is expected 
after resume?  If we're guaranteed not to be on a thread that cares 
about any of this, then OK.

>> and USPRG0.
> 
> Currently this isn't used at all.

Was thinking that it's up to userspace whether to use it or not -- 
though it ought to be saved on thread switch instead.

>> Might want to also save TLB1 contents, and maybe things like HIDn,
>> cache registers, etc. -- I don't think they're changeable post-boot
>> currently, but it'd be good to avoid surprises if that were to
>> change.
> 
> Hm. I don't really like the idea of doing things 'just in case',
> it just adds a code which functionality isn't tested, and which
> we will might never actually need.

The intent was to reduce dependencies between the suspend code and what 
the rest of the kernel does -- it's likely that someone adding some 
runtime manipulation of one of these things (e.g. hugetlbfs modifying 
TLB1) would not think to check suspend/hibernation code.  It would still 
be somewhat tested, in that you would see problems if you restored the 
wrong values (just not if you failed to restore at all).

We'll need to save/restore those things anyway for deep sleep -- but I'm 
not sure whether it'll be feasible to share code with hibernate (I 
recall trying on 83xx and giving up).  In any case, it can probably wait 
until 85xx deep sleep gets pushed out.

-Scott
