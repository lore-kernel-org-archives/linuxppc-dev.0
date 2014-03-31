Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2D4B1400DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 09:15:24 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 1 Apr 2014 03:45:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EDA533940023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 03:45:12 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2VMFANZ10027344
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Apr 2014 03:45:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2VMFB4p010468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Apr 2014 03:45:12 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/le: enable RTAS events support
In-Reply-To: <20140331104716.1385b516@bahia.local>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
 <20140331104716.1385b516@bahia.local>
Date: Tue, 01 Apr 2014 09:15:11 +1100
Message-ID: <87ob0m8174.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
> On Mon, 31 Mar 2014 09:27:16 +1100
> Stewart Smith <stewart@linux.vnet.ibm.com> wrote:
>> Greg Kurz <gkurz@linux.vnet.ibm.com> writes:
>> >  struct rtas_error_log {
>> > +#ifdef __BIG_ENDIAN__
>> > +	/* Byte 0 */
>> >  	unsigned long version:8;		/* Architectural version */
>> > +	/* Byte 1 */
>> 
>> I think it would be great if we got rid of the usage of bitfields. As
>> soon as the mood of the compiler changes, this code is going to break.
>
> True... even though I am not so sure the compiler is likely to break
> things in this specific case where no bitfield crosses the byte boundary.
> Anyway, Nathan has done some work in the direction you suggest.

It's allowed to, and it's allowed to based on compiler flags or phase of
the moon (and I've seen odd things because of this in the past) and my
bet is that there's no automated regression test that actually checks
that a newly built kernel from all distros actually works for parsing RTAS.

Besides, for things like unsigned long version:8 can easily be replaced
by uint8_t and teh problem goes away (at least for that bit).

I just hope the code we're getting this from doesn't also use bitfields :)
