Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1A7F1A1052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 22:11:30 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 751DE14028F
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:11:30 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 22:11:29 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D115A2BB0040
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:11:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5ACBIGk58523878
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:11:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5ACArPp027082
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2015 22:10:54 +1000
Message-ID: <5578293B.9060506@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 17:40:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 08/10] powerpc, perf: Change POWER8 PMU configuration
 to work with SW filters
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-8-git-send-email-khandual@linux.vnet.ibm.com>
 <1433915365.3096.44.camel@axtens.net>
In-Reply-To: <1433915365.3096.44.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2015 11:19 AM, Daniel Axtens wrote:
> On Mon, 2015-06-08 at 17:08 +0530, Anshuman Khandual wrote:
>> > The kernel now supports SW based branch filters for book3s systems with
>> > some specific requirements while dealing with HW supported branch filters
>> > in order to achieve overall OR semantics prevailing in perf branch stack
>> > sampling framework. This patch adapts the BHRB branch filter configuration
>> > to meet those protocols. POWER8 PMU can only handle one HW based branch
>> > filter request at any point of time. For all other combinations PMU will
>> > pass it on to the SW.
>> > 
>> > Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> > ---
>> >  arch/powerpc/perf/power8-pmu.c | 51 ++++++++++++++++++++++++++++++++++++------
>> >  1 file changed, 44 insertions(+), 7 deletions(-)
>> > 
>> > diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
>> > index 5e17cb5..8fccf6c 100644
>> > --- a/arch/powerpc/perf/power8-pmu.c
>> > +++ b/arch/powerpc/perf/power8-pmu.c
>> > @@ -656,6 +656,16 @@ static int power8_generic_events[] = {
>> >  
> This is, I think, the third time you've modified this function in this
> patch series. I appreciate the fact that you're trying to keep logical
> changes separate, but it seems to me like this change might be able to
> be combined with patch 4, and given a single commit message that clearly
> explains the complete scope of the changes.

Here I have to disagree with you. The changes in this patch like PMU
should not handle multiple filter requests as it does not support the
OR semantic required in the protocol, the fact that we need to pass
on the entire branch filtering responsibility to the SW comes into
picture after we have enabled the SW branch filtering support in the
previous patch. So these changes have to follow that up logically and
sequentially in that order.
