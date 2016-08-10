Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8MXC61DjzDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 17:02:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Kujau <lists@nerdbynature.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: 4.8.0-rc1: Invalid memory access at $SRR0: 0140f86c $SRR1:
 00003030
In-Reply-To: <alpine.DEB.2.20.14.1608092224220.8131@trent.utfs.org>
References: <alpine.DEB.2.20.14.1608082213450.8131@trent.utfs.org>
 <alpine.DEB.2.20.14.1608090157090.8131@trent.utfs.org>
 <1470743530.3015.38.camel@kernel.crashing.org>
 <87inv9te2n.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.14.1608092224220.8131@trent.utfs.org>
Date: Wed, 10 Aug 2016 17:02:03 +1000
Message-ID: <874m6tt8d0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Kujau <lists@nerdbynature.de> writes:

> On Wed, 10 Aug 2016, Michael Ellerman wrote:
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
>> > On Tue, 2016-08-09 at 02:06 -0700, Christian Kujau wrote:
>> >> On Mon, 8 Aug 2016, Christian Kujau wrote:
>> >> >=20
>> >> > while trying to upgrade this PowerBook G4 from 4.7-rc7 to 4.8-rc1,
>> >> > it's=C2=A0
>> >> > unable to boot the Yaboot (v1.3.16 from Debian/stable) boot loader:
>> >
>> > There should already be a fix for that:
>> >
>> > http://patchwork.ozlabs.org/patch/654560/
>> >
>> > It should be in Michael's tree if not already in Linus.
>>=20
>> That fix is in rc1, so this must be a different bug.
>
> Does the git bisect help?

No it doesn't sorry.

Because as soon as you bisected prior to that fix, you would have been
hitting the bug fixed by that commit.

To make the bisect work you need to try and apply the above fix at every
stage with patch. If the point you're bisecting already has the fix then
obviously you don't need to apply it again. You then build the kernel,
test it, and unapply the patch before doing git bisect good/bad.

eg.

$ git bisect start
$ git bisect good xxx
$ git bisect bad yyy
<checks out some version>
$ git show 2c0f99516f53 | patch -p1
$ make
... test kernel ....
$ git reset --hard
$ git bisect good/bad
...

cheers
