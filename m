Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 399172C0378
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 15:10:16 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 5 Mar 2013 21:10:13 -0700
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1277B3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 21:09:50 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2649xUg117618
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 21:09:59 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2649wJd017106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Mar 2013 21:09:59 -0700
Date: Wed, 6 Mar 2013 12:09:35 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Fix next available MSI IRQ
Message-ID: <20130306040935.GA24016@shangw.(null)>
References: <1362466756-16113-1-git-send-email-shangw@linux.vnet.ibm.com>
 <20130306032454.GA3493@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130306032454.GA3493@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 06, 2013 at 02:24:54PM +1100, Michael Ellerman wrote:
>On Tue, Mar 05, 2013 at 02:59:16PM +0800, Gavin Shan wrote:
>> The allocation of MSI is implemented based on bitmap and working
>> like the mechanism of strict round through the traced next available
>> cursor. However, the next available MSI is never updated in current
>> implementation. The patch fixes the issue.
>> 
>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index 6f464dc..9cf18c4 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -66,6 +66,11 @@ static unsigned int pnv_get_one_msi(struct pnv_phb *phb)
>>  		rc = 0;
>>  		goto out;
>>  	}
>> +
>> +	if (id >= phb->msi_count - 1)
>> +		phb->msi_next = 0;
>> +	else
>> +		phb->msi_next = id + 1;
>>  	__set_bit(id, phb->msi_map);
>
>
>There is code in arch/powerpc/sysdev/msi_bitmap.c that implements a
>bitmap allocator for MSI. It may not do what you need but please take a
>look at it if you haven't already.
>

Thanks, Michael. I neve know that you've implemented bitmaps to manage
MSI interrupts. It seems arch/powerpc/sysdev/msi_bitmap.c meets our
requirment here except that needs device tree node. Fortunately, we
can set the corresponding device tree node to NULL and functions playing
with the device tree nodes (of_node_get/of_node_put) works well for NULL
device tree node.

I'll update powernv platform to use msi_bitmap.c to manage it MSI interrupts.

Thanks,
Gavin
