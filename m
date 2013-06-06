Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pb0-x231.google.com (mail-pb0-x231.google.com
 [IPv6:2607:f8b0:400e:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF99B2C02B6
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 14:35:29 +1000 (EST)
Received: by mail-pb0-f49.google.com with SMTP id jt11so2699174pbb.8
 for <linuxppc-dev@ozlabs.org>; Wed, 05 Jun 2013 21:35:27 -0700 (PDT)
Message-ID: <1370493325.24311.332.camel@edumazet-glaptop>
Subject: Re: [PATCH 5/5] net: Block MSG_CMSG_COMPAT in send(m)msg and
 recv(m)msg
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Michael Neuling <mikey@neuling.org>
Date: Wed, 05 Jun 2013 21:35:25 -0700
In-Reply-To: <CAEjGV6xcF776C6N6VxeMY0Vyk+X51oNixdbN42-xkWjQOaMEQA@mail.gmail.com>
References: <cover.1369177867.git.luto@amacapital.net>
 <aa015609319786835bcab445d507faa75c11f111.1369177867.git.luto@amacapital.net>
 <CAEjGV6xcF776C6N6VxeMY0Vyk+X51oNixdbN42-xkWjQOaMEQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Andy Lutomirski <luto@amacapital.net>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, trinity@vger.kernel.org,
 torvalds@linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-06 at 12:56 +1000, Michael Neuling wrote:
> On Thu, May 23, 2013 at 7:07 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> > MSG_CMSG_COMPAT is (AFAIK) not intended to be part of the API --
> > it's a hack that steals a bit to indicate to other networking code
> > that a compat entry was used.  So don't allow it from a non-compat
> > syscall.
> 
> Dave & Linus
> 
> This is causing a regression on 64bit powerpc with 32bit usermode.
> When I hit userspace, udev is broken and I suspect all networking is
> broken as well.
> 
> Can we please revert 1be374a0518a288147c6a7398792583200a67261 upstream?
> 

It seems to also break x86_64, if using 32bit usermode.
