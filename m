Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 781EAB7B77
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 03:25:13 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA5GNO61023583
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:23:24 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA5GP6Ko1396880
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:25:06 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA5GP5vL005019
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:25:06 -0500
Date: Thu, 5 Nov 2009 11:25:01 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH] [SCSI] mpt fusion: Fix 32 bit platforms with 64 bit
	resources.
Message-ID: <20091105162501.GB30489@zod.rchland.ibm.com>
References: <1253053555-25097-1-git-send-email-pbathija@amcc.com>
	<20091105134330.GA30489@zod.rchland.ibm.com>
	<1257437226.2753.64.camel@mulgrave.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1257437226.2753.64.camel@mulgrave.site>
Cc: Eric.Moore@lsi.com, pbathija@amcc.com, linux-scsi@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2009 at 10:07:06AM -0600, James Bottomley wrote:
>On Thu, 2009-11-05 at 08:43 -0500, Josh Boyer wrote:
>> On Tue, Sep 15, 2009 at 03:25:55PM -0700, pbathija@amcc.com wrote:
>> >From: Pravin Bathija <pbathija@amcc.com>
>> >
>> >Powerpc 44x uses 36 bit real address while the real address defined
>> >in MPT Fusion driver is of type 32 bit. This causes ioremap to fail and driver
>> >fails to initialize. This fix changes the data types representing the real
>> >address from unsigned long 32-bit types to "phys_addr_t" which is 64-bit. The
>> >driver has been tested, the disks get discovered correctly and can do IO. Also,
>> >replaced phys_addr_t with resource_size_t as suggested by Ben.
>> >
>> >Signed-off-by: Pravin Bathija <pbathija@amcc.com>
>> >Acked-by: Feng Kan <fkan@amcc.com>
>> >Acked-by: Prodyut Hazarika <phazarika@amcc.com>
>> >Acked-by: Loc Ho <lho@amcc.com>
>> >Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
>> >Acked-by: Victor Gallardo <vgallardo@amcc.com>
>> 
>> Is this patch included in the scsi tree at all?  I can't seem to find it in
>> linux-next and I know it's not in the powerpc tree.  Are there further changes
>> needed, or has it simply been missed?
>
>What was the feedback from LSI ... I haven't seen any here?

I've seen no feedback on it anywhere.  The original patch used both
phys_addr_t and resource_size_t and Ben suggested they just use resource_size_t
everywhere.  Pravin reposted (which is this current patch) and it has sat here
since then.

josh
