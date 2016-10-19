Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szVlR2w8XzDt37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 22:56:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>, Nicholas Piggin <npiggin@gmail.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: RE: [PATCH] powerpc: link error on orphan sections
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB01E8778@AcuExch.aculab.com>
References: <20161012070020.30170-1-npiggin@gmail.com>
 <87zim7dag4.fsf@concordia.ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6DB01E8778@AcuExch.aculab.com>
Date: Wed, 19 Oct 2016 22:56:18 +1100
Message-ID: <87d1iw4knx.fsf@concordia.ellerman.id.au>
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

David Laight <David.Laight@ACULAB.COM> writes:

> From: Michael Ellerman
>> Sent: 14 October 2016 01:46
> ...
>> > +LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-y) --orphan-handling=error
>> 
>> At least some old(er) toolchains don't support that:
>> 
>>   /opt/cross/kisskb/gcc-4.6.3-nolibc/powerpc-linux/bin/powerpc-linux-ld: unrecognized option '--
>> orphan-handling=error'
>> 
>> So we'll need an ld-option wrapper around it.
>
> In the past I've caused orphan sections to error by assigning them
> to the same address as something that exists.
> Works with all linkers, even if the error message isn't as useful.

How do you assign them an address without knowing what they are? With a
wild card rule?

Anyway I think I'm happy for this to only work on newer toolchains.

cheers
