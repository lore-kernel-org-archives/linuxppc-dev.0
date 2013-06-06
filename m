Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pb0-x22b.google.com (mail-pb0-x22b.google.com
 [IPv6:2607:f8b0:400e:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9BE12C0091
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 23:45:40 +1000 (EST)
Received: by mail-pb0-f43.google.com with SMTP id md12so2223047pbc.16
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Jun 2013 06:45:38 -0700 (PDT)
Message-ID: <1370526337.24311.335.camel@edumazet-glaptop>
Subject: Re: [PATCH] net: Unbreak compat_sys_{send,recv}msg
From: Eric Dumazet <eric.dumazet@gmail.com>
To: David Miller <davem@davemloft.net>
Date: Thu, 06 Jun 2013 06:45:37 -0700
In-Reply-To: <20130606.002625.223430401087826901.davem@davemloft.net>
References: <20130606132926.f4161ddff87dc9a55e33a8ca@canb.auug.org.au>
 <e3bf421e44c6d27817c15a8683612a49e093b419.1370496702.git.luto@amacapital.net>
 <20130606.002625.223430401087826901.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mikey@neuling.org, netdev@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net, linuxppc-dev@ozlabs.org,
 trinity@vger.kernel.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-06-06 at 00:26 -0700, David Miller wrote:
> From: Andy Lutomirski <luto@amacapital.net>
> Date: Wed,  5 Jun 2013 22:38:26 -0700
> 
> > I broke them in this commit:
> > 
> >     commit 1be374a0518a288147c6a7398792583200a67261
> >     Author: Andy Lutomirski <luto@amacapital.net>
> >     Date:   Wed May 22 14:07:44 2013 -0700
> > 
> >         net: Block MSG_CMSG_COMPAT in send(m)msg and recv(m)msg
> > 
> > This patch adds __sys_sendmsg and __sys_sendmsg as common helpers that accept
> > MSG_CMSG_COMPAT and blocks MSG_CMSG_COMPAT at the syscall entrypoints.  It
> > also reverts some unnecessary checks in sys_socketcall.
> > 
> > Apparently I was suffering from underscore blindness the first time around.
> > 
> > Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> 
> Eric, can you test this patch too?

Yes, this fixes the problem as well on x86_64

Tested-by: Eric Dumazet <edumazet@google.com>

Thanks !

PS: I had following fuzz while applying on Linus tree :

patching file include/linux/socket.h
Hunk #1 succeeded at 320 (offset -1 lines).
patching file net/compat.c
patching file net/socket.c
Hunk #1 succeeded at 1956 (offset -22 lines).
Hunk #2 succeeded at 2071 (offset -22 lines).
Hunk #3 succeeded at 2125 (offset -22 lines).
Hunk #4 succeeded at 2163 (offset -22 lines).
Hunk #5 succeeded at 2255 (offset -22 lines).
Hunk #6 succeeded at 2317 (offset -22 lines).
Hunk #7 succeeded at 2515 (offset -20 lines).
