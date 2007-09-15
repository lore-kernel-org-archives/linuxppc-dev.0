Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2EF8DDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:38 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8F2TbLR016902
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:37 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8F2TcpO4435996
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:38 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8F2TLvA021693
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:22 +1000
Date: Sat, 15 Sep 2007 11:30:00 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: rtc-ds1742.c should use resource_size_t for base address
Message-ID: <20070915013000.GA25414@localhost.localdomain>
References: <20070914055427.GM481@localhost.localdomain>
	<20070914122037.65a08f48@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070914122037.65a08f48@weaponx.rchland.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 12:20:37PM -0500, Josh Boyer wrote:
> On Fri, 14 Sep 2007 15:54:27 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > Currently the rtc driver, rtc-ds1742.c uses an unsigned long to store
> > the base mmio address of the NVRAM/RTC.  This breaks on systems like
> > PowerPC 440, which is a 32-bit core with 36-bit physical addresses: IO
> > on the system, including the RTC, is typically above the 4GB point,
> > and cannot fit into an unsigned long.
> > 
> > This patch fixes the problem by replacing the unsigned long with a
> > resource_size_t.  Tested on Ebony (PPC440) (with additional patches to
> > instantiate the ds1742 platform device appropriately).
> 
> Where would those additional patches be? :)

Coming, they still need polish...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
