Return-Path: <rpjday@mindspring.com>
Received: from toq11-srv.bellnexxia.net (toq11.bellnexxia.net
	[209.226.175.118]) by ozlabs.org (Postfix) with ESMTP id 837612BD6A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Oct 2004 06:09:34 +1000 (EST)
Date: Tue, 5 Oct 2004 15:52:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <A337CA12-1703-11D9-B4FB-003065F9B7DC@embeddededge.com>
Message-ID: <Pine.LNX.4.60.0410051543230.3549@localhost.localdomain>
References: <Pine.LNX.4.60.0410051228520.5107@dell.enoriver.com>
	<A337CA12-1703-11D9-B4FB-003065F9B7DC@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] first in a series to enhance microcode patches
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 5 Oct 2004, Dan Malek wrote:

> No, send a whole patch that _does_ something.  Let's see all of these
> changes at once.  By itself, this patch is useless and doesn't add any
> features, it just wastes our time discussing it.

ok, not a problem.  i'll submit it any way the powers that be prefer, 
i just wanted explicit instructions on how.  give me a day and i'll 
have a full, working patch.  that does something.

>>   2) redeclares reserved chunks in structures to be in terms of a
>>      standard char array, rather than the hideous combination of uint,
>>      ushort, and so on.  (a purely aesthetic fix, admittedly.)
>
> Just for information, most of the original data structures were all
> machine generated with some minor manual touch ups.  I certainly
> wasn't going to type in all of that stuff and risk mistakes with offsets
> and sizes.

that's definitely understandable.  it's just potentially confusing to 
have a structure's reserved chunks declared as some combination of 
uchar, ushort, uint and/or ulong, when it's obviously more 
comprehensible to make each reserved chunk a standard array of char 
whose size is obvious at a glance.

just for fun,

   $ cd include/asm-ppc
   $ grep -i reserved *.h

man.  the standards for declaring reserved space are all over the map, 
including this one:

mpc52xx.h:      volatile u32    reserved[4];    /* MMAP_CTRL + 0x3c .. 
0x48 */
mpc52xx.h:      volatile u32    reserved1;      /* INTR + 0x20 */
mpc52xx.h:      volatile u32    reserved2;      /* INTR + 0x34 */
...

   now *that* kind of creeps me out.  why is reserved space being 
declared as "volatile"?  yeesh.

   i may not understand what's happening here but, IMHO, if something 
is declared as reserved, that should be an indication that *nobody* is 
using it.  if it's being used for anything, then it shouldn't be 
labelled as "reserved"; it should have a name.  to be both volatile 
and reserved just makes me queasy. but that's just me.

rday
