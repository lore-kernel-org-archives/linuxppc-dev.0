Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB1A92C012A
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 13:53:48 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 10 Sep 2013 13:42:12 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D6D8B2CE8054
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 13:53:43 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8A3bM0h63570018
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 13:37:22 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8A3rg9q005672
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Sep 2013 13:53:43 +1000
Message-ID: <522E9793.7060003@linux.vnet.ibm.com>
Date: Tue, 10 Sep 2013 09:22:51 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1378778772.25578.1.camel@concordia>
In-Reply-To: <1378778772.25578.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 eranian@google.com, acme@redhat.com, linuxppc-dev@ozlabs.org,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/10/2013 07:36 AM, Michael Ellerman wrote:
> On Fri, 2013-08-30 at 09:54 +0530, Anshuman Khandual wrote:
>> 	This patchset is the re-spin of the original branch stack sampling
>> patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>> also enables SW based branch filtering support for PPC64 platforms which have
>> branch stack sampling support. With this new enablement, the branch filter support
>> for PPC64 platforms have been extended to include all these combinations discussed
>> below with a sample test application program.
> 
> ...
> 
>> Mixed filters
>> -------------
>> (6) perf record -e branch-misses:u -j any_call,any_ret ./cprog
>> Error:
>> The perf.data file has no samples!
>>
>> NOTE: As expected. The HW filters all the branches which are calls and SW tries to find return
>> branches in that given set. Both the filters are mutually exclussive, so obviously no samples
>> found in the end profile.
> 
> The semantics of multiple filters is not clear to me. It could be an OR,
> or an AND. You have implemented AND, does that match existing behaviour
> on x86 for example?

I believe it does match. X86 code drops the branch records (originally captured
in the LBR) while applying the SW filters.

Regards
Anshuman
