Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29B8A2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 04:51:58 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 4 May 2013 00:16:37 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 23186125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 00:23:32 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43Iph526881574
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 00:21:43 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43IplDP018804
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 04:51:48 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V7 01/18] mm/THP: HPAGE_SHIFT is not a #define on some
 arch
In-Reply-To: <20130430050101.GY20202@truffula.fritz.box>
References: <1367177859-7893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367177859-7893-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130430022149.GU20202@truffula.fritz.box>
 <871u9sfzvy.fsf@linux.vnet.ibm.com>
 <20130430050101.GY20202@truffula.fritz.box>
Date: Sat, 04 May 2013 00:21:47 +0530
Message-ID: <87obcr522k.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Tue, Apr 30, 2013 at 09:12:09AM +0530, Aneesh Kumar K.V wrote:
>> David Gibson <dwg@au1.ibm.com> writes:
>> 
>> > On Mon, Apr 29, 2013 at 01:07:22AM +0530, Aneesh Kumar K.V wrote:
>> >> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> >> 
>> >> On archs like powerpc that support different hugepage sizes, HPAGE_SHIFT
>> >> and other derived values like HPAGE_PMD_ORDER are not constants. So move
>> >> that to hugepage_init
>> >
>> > These seems to miss the point.  Those variables may be defined in
>> > terms of HPAGE_SHIFT right now, but that is of itself kind of broken.
>> > The transparent hugepage mechanism only works if the hugepage size is
>> > equal to the PMD size - and PMD_SHIFT remains a compile time constant.
>> >
>> > There's no reason having transparent hugepage should force the PMD
>> > size of hugepage to be the default for other purposes - it should be
>> > possible to do THP as long as PMD-sized is a possible hugepage size.
>> >
>> 
>> THP code does
>> 
>> #define HPAGE_PMD_SHIFT HPAGE_SHIFT
>> #define HPAGE_PMD_MASK HPAGE_MASK
>> #define HPAGE_PMD_SIZE HPAGE_SIZE
>> 
>> I had two options, one to move all those in terms of PMD_SHIFT
>
> This is a much better option that you've taken now, and really
> shouldn't be that hard.  The THP code is much more strongly tied to
> the fact that it is a PMD than the fact that it's the same size as
> explicit huge pages.
>

Ok I tried the above and that turned out to be much simpler. I will have
to make sure i didn't break other archs that support THP.

-aneesh
