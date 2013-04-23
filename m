Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A8372C0142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 18:54:17 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 18:44:38 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F41F22BB0058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 18:53:42 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3N8lUXl31719578
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 18:53:36 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3N8g86Z024813
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 18:42:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V6 05/27] powerpc: New hugepage directory format
In-Reply-To: <20130423070103.GB30092@iris.ozlabs.ibm.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130423070103.GB30092@iris.ozlabs.ibm.com>
Date: Tue, 23 Apr 2013 14:12:04 +0530
Message-ID: <87k3ntprj7.fsf@linux.vnet.ibm.com>
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

> On Mon, Apr 22, 2013 at 03:30:39PM +0530, Aneesh Kumar K.V wrote:
>
>> Instead of storing shift value in hugepd pointer we use mmu_psize_def index
>> so that we can fit all the supported hugepage size in 4 bits
>
> That works, but does mean that we have to scan the mmu_psize_defs[]
> array to work out the encoding for a particular page size.

We do the scan only when allocating hugepgd. While walking it is only
mmu_psize_defs dereference. Yes, that could possibly have a performance
impact, but having a well defined way to map page shift to a smaller
index and using the same method all the place is nice. I will try to
measure the impact and switch to the below method if needed.

>  Instead,
> we could use the fact that all large page sizes are powers of 4, as
> are all supported page sizes on embedded processors.  So we could
> encode using page_code = (page_order - 12) / 2, where page_order is
> the log base 2 of the page size, and that lets us represent all power
> of 4 page sizes between 2^12 (4kB) and 2^42 bytes (4TB).

I guess i can add this as an addon patch on the top of the series if the
current patch series is going in to Benh's tree ?

-aneesh
