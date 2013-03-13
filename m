Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04F982C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:17:17 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Mar 2013 14:42:54 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 94597E004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 14:48:28 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2D9H41S29098234
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 14:47:04 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2D9H72O006354
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2013 20:17:07 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V3 2/3] powerpc: Update kernel VSID range
In-Reply-To: <20130313034254.GC21125@iris.ozlabs.ibm.com>
References: <1363090131-14545-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1363090131-14545-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130313034254.GC21125@iris.ozlabs.ibm.com>
Date: Wed, 13 Mar 2013 14:47:06 +0530
Message-ID: <87a9q7d5gt.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Mar 12, 2013 at 05:38:50PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This patch change the kernel VSID range so that we limit VSID_BITS to 37.
>> This enables us to support 64TB with 65 bit VA (37+28). Without this patch
>> we have boot hangs on platforms that only support 65 bit VA.
>> 
>> With this patch we now have proto vsid generated as below:
>> 
>> We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
>> from mmu context id and effective segment id of the address.
>> 
>> For user processes max context id is limited to ((1ul << 19) - 5)
>> for kernel space, we use the top 4 context ids to map address as below
>> 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
>> 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
>> 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
>> 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Mostly looks OK, and it could go in as is, so
>
> Acked-by: Paul Mackerras <paulus@samba.org>
>
> Some minor comments below...
>
>> + * For user processes max context id is limited to ((1ul << 19) - 6)
>
> should be ((1ul << 19) - 5)

I update the commit message but missed updating this.  

Ben,

Let me know if you want me to send V4 to take care of these review
feedbacks.

-aneesh
