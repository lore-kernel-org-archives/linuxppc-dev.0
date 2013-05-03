Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7EEFD2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 04:55:00 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 4 May 2013 00:18:29 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 056D61258023
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 00:26:30 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43Isgf763439026
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 00:24:42 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43IsjWk027901
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 04:54:46 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V7 02/10] powerpc/THP: Implement transparent hugepages
 for ppc64
In-Reply-To: <20130503115428.GW13041@truffula.fritz.box>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367178711-8232-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130503045201.GO13041@truffula.fritz.box>
 <1367569143.4389.56.camel@pasglop>
 <20130503115428.GW13041@truffula.fritz.box>
Date: Sat, 04 May 2013 00:24:45 +0530
Message-ID: <87li7v51xm.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Fri, May 03, 2013 at 06:19:03PM +1000, Benjamin Herrenschmidt wrote:
>> On Fri, 2013-05-03 at 14:52 +1000, David Gibson wrote:
>> > Here, specifically, the fact that PAGE_BUSY is in PAGE_THP_HPTEFLAGS
>> > is likely to be bad.  If the page is busy, it's in the middle of
>> > update so can't stably be considered the same as anything.
>> 
>> _PAGE_BUSY is more like a read lock. It means it's being hashed, so what
>> is not stable is _PAGE_HASHPTE, slot index, _ACCESSED and _DIRTY. The
>> rest is stable and usually is what pmd_same looks at (though I have a
>> small doubt vs. _ACCESSED and _DIRTY but at least x86 doesn't care since
>> they are updated by HW).
>
> Ok.  It still seems very odd to me that _PAGE_BUSY would be in the THP
> version of _PAGE_HASHPTE, but not the normal one.
>

64-4k definition:
/* PTE flags to conserve for HPTE identification */
#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | \
			 _PAGE_SECONDARY | _PAGE_GROUP_IX)

64-64K definition:
/* PTE flags to conserve for HPTE identification */
#define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | _PAGE_COMBO)

BTW I have dropped that change in my current patch. I dropped the
usage of _PAGE_COMBO and instead started using _PAGE_4K_PFN for
identifying THP.That enabled me to use _PAGE_HPTEFLAGS as it is.

-aneesh
