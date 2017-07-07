Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x48vm6Zk4zDr8k
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jul 2017 08:50:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [git pull] vfs.git part 1
In-Reply-To: <CA+55aFzHBR9M+UN2CMAQ0np275iyWyAY0uKK8LFo33g0e7Z-VQ@mail.gmail.com>
References: <20170705071423.GY10672@ZenIV.linux.org.uk>
 <87eftsv2hj.fsf@concordia.ellerman.id.au>
 <CA+55aFyREtWvwCLc0iHMUOLo-VLDpxju7WwEmjOSyByHre3avQ@mail.gmail.com>
 <CA+55aFzHBR9M+UN2CMAQ0np275iyWyAY0uKK8LFo33g0e7Z-VQ@mail.gmail.com>
Date: Sat, 08 Jul 2017 08:50:27 +1000
Message-ID: <8760f3vp3g.fsf@concordia.ellerman.id.au>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jul 7, 2017 at 8:59 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> The copy_flock_fields() macro has the arguments in order <from, to>,
>> but all the users seem to do it the other way around.
>
> Looking more at it, I think I'd also like copy_flock_fields() to take
> pointer arguments, to match all the code around it (both
> copy_to/from_user and the memset calls.
>
> The actual order of arguments I suspect Michael's patch did better -
> make the copy_flock_fields() just match the order of memcpy() and
> copy_to/from_user(), both of which have <dest,src> order.
>
> So I think my preferred patch would be something like this, even if it
> is bigger than either.
>
> Comments? Michael, does this work for your case?

Yeah that works, as committed in your tree. Sorry for the slow reply,
our time zones don't line up all that well :)

cheers
