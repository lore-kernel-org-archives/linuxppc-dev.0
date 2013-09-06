Return-Path: <linus971@gmail.com>
Received: from mail-vb0-x235.google.com (mail-vb0-x235.google.com
 [IPv6:2607:f8b0:400c:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C2DD52C00FF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 03:56:18 +1000 (EST)
Received: by mail-vb0-f53.google.com with SMTP id i3so2428978vbh.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Sep 2013 10:56:15 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1378434264.4321.209.camel@pasglop>
References: <1378434264.4321.209.camel@pasglop>
Date: Fri, 6 Sep 2013 10:56:15 -0700
Message-ID: <CA+55aFwvPNu6-PHJmDkqihiCgMy=TH_we8LtVKm31teWhmLQPw@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 5, 2013 at 7:24 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>  * A bunch of endian fixes ! We don't have full LE support yet in that
> release but this contains a lot of fixes all over arch/powerpc to use the
> proper accessors, call the firmware with the right endian mode, etc...

Ok, this caused a conflict in arch/powerpc/kernel/prom.c, where some
of the OF CPU number accessors had been moved to generic OF code
instead.

It *looks* to me like those accessors had already been made
endian-clean as part of the move to generic code, and so my conflict
resolution was to just ignore the parts of the changes the code that
no longer exists in prom.c, but you really should double-check my
resolution. Maybe I screwed it up.

But apparent'y the LE mode isn't finished, so hopefully even if I read
those changes wrong it won't affect you guys too badly. I didn't
test-compile any of it, yadda yadda..

              Linus
