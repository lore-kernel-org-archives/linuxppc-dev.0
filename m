Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBE6F2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 13:42:19 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 30 Apr 2013 09:05:56 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id A6D00E002D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 09:14:22 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3U3g7rr51314768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 09:12:07 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3U3gB3T010298
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Apr 2013 13:42:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V7 01/18] mm/THP: HPAGE_SHIFT is not a #define on some
 arch
In-Reply-To: <20130430022149.GU20202@truffula.fritz.box>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367177859-7893-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130430022149.GU20202@truffula.fritz.box>
Date: Tue, 30 Apr 2013 09:12:09 +0530
Message-ID: <871u9sfzvy.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Mon, Apr 29, 2013 at 01:07:22AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> On archs like powerpc that support different hugepage sizes, HPAGE_SHIFT
>> and other derived values like HPAGE_PMD_ORDER are not constants. So move
>> that to hugepage_init
>
> These seems to miss the point.  Those variables may be defined in
> terms of HPAGE_SHIFT right now, but that is of itself kind of broken.
> The transparent hugepage mechanism only works if the hugepage size is
> equal to the PMD size - and PMD_SHIFT remains a compile time constant.
>
> There's no reason having transparent hugepage should force the PMD
> size of hugepage to be the default for other purposes - it should be
> possible to do THP as long as PMD-sized is a possible hugepage size.
>

THP code does

#define HPAGE_PMD_SHIFT HPAGE_SHIFT
#define HPAGE_PMD_MASK HPAGE_MASK
#define HPAGE_PMD_SIZE HPAGE_SIZE

I had two options, one to move all those in terms of PMD_SHIFT or switch
ppc64 to not use HPAGE_SHIFT the way it use now. Both would involve large
code changes. Hence I end up moving some of the checks to runtime
checks. Actual HPAGE_SHIFT == PMD_SHIFT check happens in the has_transparent_hugepage() 

https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-April/106002.html

IMHO what the patch is checking is that, HPAGE_SHIFT
value is not resulting in a page order higher than MAX_ORDER. 

Related to Reviewed-by: that came from V5 patchset 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-April/105299.html

Your review suggestion to move that runtime check back to macro happened
in V6. I missed dropping reviewed-by after that. 

-aneesh
