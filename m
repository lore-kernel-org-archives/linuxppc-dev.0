Return-Path: <srs0=hipf=57=aculab.com=david.laight@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxFCT6WFqzDr26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 02:40:05 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wxFCT5kVnz8vLp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 02:40:05 +1000 (AEST)
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wxFCT2wxbz9s81
 for <linuxppc-dev@ozlabs.org>; Tue, 27 Jun 2017 02:40:05 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Michael Ellerman' <mpe@ellerman.id.au>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
Subject: RE: [PATCH] powerpc/32: Avoid miscompilation w/GCC 4.6.3 - don't
 inline copy_to/from_user()
Date: Mon, 26 Jun 2017 16:22:09 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD002B1DB@AcuExch.aculab.com>
References: <1498484055-13783-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1498484055-13783-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman
> Sent: 26 June 2017 14:34
..
> Al also pointed out that inlining copy_to/from_user() is probably of litt=
le or
> no benefit, which is correct
...

I was a bit horrified at the x86-64 versions of copy_to/from_user() as well=
.
With code that (tries to) error kernel pointers that cross stack frame
boundaries I'm fairly sure they expand to a lot of code.

I also suspect the cost of that kernel address check is not insignificant
especially if it has to walk down several stack frames.
(Never mind what happens to code compiled without stack frames.)

	David
