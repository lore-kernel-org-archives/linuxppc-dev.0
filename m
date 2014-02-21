Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BCD442C033A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 14:34:42 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Fri, 21 Feb 2014 13:34:41 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 390192BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 14:34:39 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1L3YPTx7012686
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 14:34:25 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1L3YcZi028169
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 14:34:38 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v2] powernv: don't attempt to refetch the FSP dump until
 the user has explicitly acked it.
In-Reply-To: <21091.1392951172@ale.ozlabs.ibm.com>
References: <20140116121411.624.55662.stgit@hegdevasant.in.ibm.com>
 <1392941701-2871-1-git-send-email-stewart@linux.vnet.ibm.com>
 <21091.1392951172@ale.ozlabs.ibm.com>
Date: Fri, 21 Feb 2014 14:34:36 +1100
Message-ID: <87vbw9m94j.fsf@river.au.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hegdevasant@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:
> Stewart Smith <stewart@linux.vnet.ibm.com> wrote:
>
>> This fixes a bug where we would get two events from OPAL with DUMP_AVAIL
>> set (which is valid for OPAL to do) and in the second run of extract_dump()
>> we would fail to free the memory previously allocated for the dump
>> (leaking ~6MB+) as well as on the second dump_read_data() call OPAL
>> would not retrieve the dump, leaving us with a dump in linux that was
>> the correct size but all zeros.
>> 
>> Changes since v1: fixed typo
>> 
>> Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> Should we CC stable on this?

we don't need to as the code this patches hasn't made it to stable
yet. Hopefully Vasant resends a version of the patch incorporating my
fix :)
