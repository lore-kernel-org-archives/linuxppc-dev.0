Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BF452C0397
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 16:44:42 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Jul 2012 12:14:38 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6N6iYOj6684914
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 12:14:34 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6NCE8MP012583
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:44:08 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V3 05/11] arch/powerpc: remove masking top 16 bit of va
 in tlb invalidate
In-Reply-To: <20120723034912.GA5019@drongo>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20120722235610.GE17790@bloggs.ozlabs.ibm.com>
 <1343006528.29855.25.camel@pasglop> <20120723034912.GA5019@drongo>
Date: Mon, 23 Jul 2012 12:14:34 +0530
Message-ID: <87d33nht7x.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Mon, Jul 23, 2012 at 11:22:08AM +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2012-07-23 at 09:56 +1000, Paul Mackerras wrote:
>> > > That indicate we should not mask the top 16 bits. So remove the
>> > same.
>> > 
>> > Older versions of the architecture (2.02 and earler) require the
>> > masking, so we can't just unconditionally remove it, since that would
>> > potentially break POWER5 and PPC970.  People are definitely still
>> > running Linux bare-metal on PPC970s (though arguably not on POWER5). 
>> 
>> Are you sure ? I couldn't convince myself ... the old architectures say
>> that it only uses some of the bits but it doesn't mark the other ones as
>> "reserved" (as in must be 0).
>> 
>> (At least 1.x, I haven't looked at 2.x with x < 03)
>
> 2.01 and 2.02 say bits 0..15 must be zero.

is this 0..15 of va or 0..15 of AVA ?

if it is 0.. 15 then that clear bit is wrong right ? We are doing that
on a 64 bit va. So with that we already have ignored 0..14. 

-aneesh
