Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 87E102C02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 22:02:36 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 4 Mar 2013 20:56:07 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 6E6FD2CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2013 22:02:28 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r24Anixd8651048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Mar 2013 21:49:45 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r24B2R7F030040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Mar 2013 22:02:27 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH -V1 07/24] powerpc: Add size argument to pgtable_cache_add
In-Reply-To: <20130304051340.GC27523@drongo>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1361865914-13911-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130304051340.GC27523@drongo>
Date: Mon, 04 Mar 2013 16:32:24 +0530
Message-ID: <871ubv2zsv.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Feb 26, 2013 at 01:34:57PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> We will use this later with THP changes to request for pmd table of double the size.
>> THP code does PTE page allocation along with large page request and deposit them
>> for later use. This is to ensure that we won't have any failures when we split
>> huge pages to regular pages.
>> 
>> On powerpc we want to use the deposited PTE page for storing hash pte slot and
>> secondary bit information for the HPTEs. Hence we save them in the second half
>> of the pmd table.
>
> Looks OK, but you should explain why you made the wholesale change of
> "shift" to "index".  Is there some important semantic difference, or
> do you just prefer the "index" name for some reason?
>

Now with table_size argument, the first arg is no more the shift value,
rather it is index into the array. Hence i changed the variable name. I
will split that patch to make it easy for review.

-aneesh
