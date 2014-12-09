Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63D0C1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 00:16:31 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 18:46:28 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BCE031258044
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 18:46:46 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB9DIV4760751980
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 18:48:32 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB9DFq1c017877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 18:45:52 +0530
Message-ID: <5486F607.6010706@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2014 18:45:51 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/5] powerpc: Fix handling of DSCR related facility unavailable
 exception
References: <20141209101117.1CEC9140100@ozlabs.org>
In-Reply-To: <20141209101117.1CEC9140100@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/09/2014 03:41 PM, Michael Ellerman wrote:
> On Mon, 2014-08-12 at 06:30:08 UTC, Anshuman Khandual wrote:
>> Currently DSCR (Data Stream Control Register) can be accessed with
>> mfspr or mtspr instructions inside a thread via two different SPR
>> numbers. One being the user accessible problem state SPR number 0x03
>> and the other being the privilege state SPR number 0x11. All access
>> through the privilege state SPR number get emulated through illegal
>> instruction exception. Any access through the problem state SPR number
>> raises one facility unavailable exception which sets the thread based
>> dscr_inherit bit and enables DSCR facility through FSCR register thus
>> allowing direct access to DSCR without going through this exception in
>> the future. We set the thread.dscr_inherit bit whether the access was
>> with mfspr or mtspr instruction which is neither correct nor does it
>> match the behaviour through the instruction emulation code path driven
>> from privilege state SPR number. User currently observes two different
>> kind of behaviour when accessing the DSCR through these two SPR numbers.
>> This problem can be observed through these two test cases by replacing
>> the privilege state SPR number with the problem state SPR number.
>>
>> 	(1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
>> 	(2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
> 
> Can you convert those into a selftest please?

Hey Michael,

Yeah I wanted to convert all these tests which are related to DSCR into
individual self tests for powerpc. All these test cases have Anton Blanchard
and IBM's copyright on it but they are licensed with GPL V2. Not sure whether
Anton needs to okay this before I can modify them for self tests, put his
(Anton's) signed-off-by and then post it in the mailing list.

(1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
(2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
(3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
(4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
(5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c
