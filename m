Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C81EADDEEF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:51:52 +1000 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Avoid integer overflow in page_is_ram()
References: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
	<adak5ddf8co.fsf@cisco.com>
	<D5A2FA91-E013-41EF-BCB5-E2645C20A918@kernel.crashing.org>
Date: Mon, 15 Sep 2008 15:51:35 -0700
In-Reply-To: <D5A2FA91-E013-41EF-BCB5-E2645C20A918@kernel.crashing.org> (Kumar
	Gala's message of "Mon, 15 Sep 2008 17:44:05 -0500")
Message-ID: <ada7i9df2fc.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > > #ifndef CONFIG_PPC64	/* XXX for now */
 > > -	return paddr < __pa(high_memory);
 > > +	return pfn < max_pfn;
 > > #else
 > > +	unsigned long paddr = (pfn << PAGE_SHIFT);
 > 
 > seems like this could be a phys_addr_t

Yes, it could I guess, but that would be an unrelated change, and I'm
not sure there's much point given this is in 64-bit-only code.

 - R.
