Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB9A71400AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 09:49:47 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 1 Apr 2014 08:49:46 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A3E1D2BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 09:49:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2VMT8qN11207112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Apr 2014 09:29:08 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2VMngqR012888
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Apr 2014 09:49:42 +1100
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/le: enable RTAS events support
In-Reply-To: <1396266973.11529.77.camel@pasglop>
References: <20140328073344.26823.32931.stgit@bahia.local>
 <87vbuv9vaz.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
 <1396266973.11529.77.camel@pasglop>
Date: Tue, 01 Apr 2014 09:49:41 +1100
Message-ID: <87a9c67zlm.fsf@river.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org,
 nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Mon, 2014-03-31 at 09:27 +1100, Stewart Smith wrote:
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
>  ... as would a whole pile of kernel code including filesystems :)
>
> Now, don't get me wrong, I hate bitfields as much as you do for the same
> reasons. However (unfortunately ?) we've somewhat painted ourselves into
> a corner here in kernel-land and I suspect gcc would have a very hard
> time changing the format considering how many people did just the same
> we did.
>
> Now if we were a userspace program, I would still insist on fixing it on
> the ground on not depending on gcc but this is the kernel ... we have
> more gcc'isms than spots on the face of a 14 yrs old..

A quick grep didn't show up anything that looked like on disk
formats... at least for anything I care about :)

Maybe I've spent too long writing code for more than one compiler :)
