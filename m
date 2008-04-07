Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E3FBDE066
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:20:38 +1000 (EST)
Date: Mon, 7 Apr 2008 11:20:53 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Message-ID: <20080407162053.GB2688@loki.buserror.net>
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
	<279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 08:09:57AM -0500, Kumar Gala wrote:
> On Apr 6, 2008, at 6:48 PM, Paul Mackerras wrote:
>> More generally, I think we need to take an overall look at what things
>> we are using fixed virtual addresses for, and why they need to be
>> fixed.  If there are indeed several such things then we can introduce
>> the fixmap stuff.
>
> The list as I see it:
> * kmap
> * pci-e config for 4xx/83xx
> * kexec/kdump (ben commented on this when Dale posted his patches for  
> ppc32 support)
>
> future:
> * possible usage by HV
>
> since we already have three users and a possible fourth it seems like a 
> useful change.

Another possible use is a BAT/TLB1 mapping for SoC registers (or anything
else on the board which is frequently accessed), which can be reused by
ioremap() to avoid wasting normal TLB entries, and to facilitate early
debugging.

-Scott
