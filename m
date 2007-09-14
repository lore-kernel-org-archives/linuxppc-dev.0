Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A0BA2DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 03:20:44 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8EHKegH024082
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 13:20:40 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8EHKdlX490528
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 11:20:39 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8EHKc1k031293
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 11:20:39 -0600
Date: Fri, 14 Sep 2007 12:20:37 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: rtc-ds1742.c should use resource_size_t for base address
Message-ID: <20070914122037.65a08f48@weaponx.rchland.ibm.com>
In-Reply-To: <20070914055427.GM481@localhost.localdomain>
References: <20070914055427.GM481@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 14 Sep 2007 15:54:27 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently the rtc driver, rtc-ds1742.c uses an unsigned long to store
> the base mmio address of the NVRAM/RTC.  This breaks on systems like
> PowerPC 440, which is a 32-bit core with 36-bit physical addresses: IO
> on the system, including the RTC, is typically above the 4GB point,
> and cannot fit into an unsigned long.
> 
> This patch fixes the problem by replacing the unsigned long with a
> resource_size_t.  Tested on Ebony (PPC440) (with additional patches to
> instantiate the ds1742 platform device appropriately).

Where would those additional patches be? :)

josh
