Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zqkD6nVHzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 19:43:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 07/13] powerpc/eeh: Clean up pci_ers_result handling
In-Reply-To: <20180604012833.GA6139@tungsten.ozlabs.ibm.com>
References: <cover.1527217866.git.sbobroff@linux.ibm.com>
 <e638159f9e6dfc4931f5164220741dd99bb4c0c7.1527217866.git.sbobroff@linux.ibm.com>
 <87muwe3475.fsf@concordia.ellerman.id.au>
 <20180604012833.GA6139@tungsten.ozlabs.ibm.com>
Date: Mon, 04 Jun 2018 19:43:14 +1000
Message-ID: <87muwac2fh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sam Bobroff <sbobroff@linux.ibm.com> writes:

> On Sat, Jun 02, 2018 at 01:40:46AM +1000, Michael Ellerman wrote:
>> Sam Bobroff <sbobroff@linux.ibm.com> writes:
>> 
>> > As EEH event handling progresses, a cumulative result of type
>> > pci_ers_result is built up by (some of) the eeh_report_*() functions
>> > using either:
>> > 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
>> > 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
>> > or:
>> > 	if ((*res == PCI_ERS_RESULT_NONE) ||
>> > 	    (*res == PCI_ERS_RESULT_RECOVERED)) *res = rc;
>> > 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
>> > 	    rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
>> > (Where *res is the accumulator.)
>> >
>> > However, the intent is not immediately clear and the result in some
>> > situations is order dependent.
>> >
>> > Address this by assigning a priority to each result value, and always
>> > merging to the highest priority. This renders the intent clear, and
>> > provides a stable value for all orderings.
>> >
>> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
>> > ---
>> > ====== v1 -> v2: ======
>> >
>> > * Added the value, and missing newline, to some WARN()s.
>> > * Improved name of merge_result() to pci_ers_merge_result().
>> > * Adjusted the result priorities so that unknown doesn't overlap with _NONE.
>> 
>> These === markers seem to have confused patchwork, they ended up in the
>> patch, and then git put them in the changelog.
>> 
>> http://patchwork.ozlabs.org/patch/920194/
>> 
>> The usual format is just something like:
>> 
>> v2 - Added the value, and missing newline, to some WARN()s.
>>    - Improved name of merge_result() to pci_ers_merge_result().
>>    - Adjusted the result priorities so that unknown doesn't overlap with _NONE.
>> 
>> cheers
>
> Oh! I'll change it!

Thanks.

cheers
