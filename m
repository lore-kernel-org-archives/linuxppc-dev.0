Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 317F32C00A2
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Sep 2013 13:38:34 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 3 Sep 2013 00:32:29 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4F4492CE8051
 for <linuxppc-dev@ozlabs.org>; Mon,  2 Sep 2013 13:38:28 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r823cE0N6095258
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Sep 2013 13:38:17 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r823cOlK029754
 for <linuxppc-dev@ozlabs.org>; Mon, 2 Sep 2013 13:38:25 +1000
Message-ID: <52240800.6060002@linux.vnet.ibm.com>
Date: Mon, 02 Sep 2013 09:07:36 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH V2 0/6] perf: New conditional branch filter
References: <1377836690-32710-1-git-send-email-khandual@linux.vnet.ibm.com>
 <CABPqkBS2AD873tHnyCHeC7uwsJdP1V6=8WGUTHG+R0z2pphHjQ@mail.gmail.com>
In-Reply-To: <CABPqkBS2AD873tHnyCHeC7uwsJdP1V6=8WGUTHG+R0z2pphHjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, ellerman@au1.ibm.com,
 michael.neuling@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/30/2013 05:18 PM, Stephane Eranian wrote:
> 2013/8/30 Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> >
>> >         This patchset is the re-spin of the original branch stack sampling
>> > patchset which introduced new PERF_SAMPLE_BRANCH_COND filter. This patchset
>> > also enables SW based branch filtering support for PPC64 platforms which have
>> > branch stack sampling support. With this new enablement, the branch filter support
>> > for PPC64 platforms have been extended to include all these combinations discussed
>> > below with a sample test application program.
>> >
>> >
> I am trying to understand which HW has support for capturing the
> branches: PPC7 or PPC8.
> Then it seems you're saying that only PPC8 has the filtering support.
> On PPC7 you use the
> SW filter. Did I get this right?
> 
> I will look at the patch set.
> 

Hey Stephane,

POWER7 does not have BHRB support required to capture the branches. Right
now its only POWER8 (which has BHRB) can capture branches in HW. It has some
PMU level branch filters and rest we have implemented in SW. But these SW
filters cannot be applied in POWER7 as it does not support branch stack 
sampling because of lack of BHRB. I have mentioned PPC64 support in the
sense that this SW filtering code could be used in existing or future generation
powerpc processors which would have PMU support for branch stack sampling. My
apologies if the description for the patchset was ambiguous.

Regards
Anshuman
