Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37754DED3C
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 03:51:08 +1000 (EST)
Message-Id: <C69E510D-5838-4BE6-AB57-56FCB0592414@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18441.58154.608911.337978@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Patches added to powerpc.git master and powerpc-next branches
Date: Mon, 21 Apr 2008 12:51:04 -0500
References: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
	<9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
	<18441.58154.608911.337978@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2008, at 7:18 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> [POWERPC] 85xx: Add support for relocatble kernel (and booting at  
>> non-
>> zero)
>
> Should be OK to go though probably not in the first batch.  I want to
> look through it carefully again since it's touching code that is
> common to a lot of platforms.  The patch description looks reasonable
> as to what it explains but the english could use a touch-up here or
> there (e.g. "a physical address that is module 256M" doesn't actually
> mean anything; "a physical address that is 0 modulo 256M" would be
> correct).

Ok.  I'll have my grammar police review it and repost.

>> [POWERPC] Port fixmap from x86 and use for kmap_atomic
>
> Once again I want to go through it carefully and understand how it all
> works, and in particular understand things like the way it ensures
> that the base address for the kmap region is aligned to a 4M boundary
> so all the kmap ptes are in a single page (assuming it does :).

I'm not clear on why this is needed.  I can see value in having the  
PGD entry in place but the pte PAs would be changing all the time so I  
don't see what benefit there is in keeping them in one page.

For normal kmap ptes we cover things in one PGD via:

#define PKMAP_BASE      ((FIXADDR_BOOT_START - PAGE_SIZE*(LAST_PKMAP +  
1)) & PMD_MASK)

The kmap_atomic ptes do NOT have a similar guarantee as they are  
controlled via fixmap.  However we do "pre-allocate" the PGD via  
calling map_page() on all fixmap addresses.

- k
