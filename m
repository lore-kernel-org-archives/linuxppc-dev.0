Return-Path: <linus971@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402MPh5gFYzF1Vd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 08:37:28 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id e98-v6so5725099itd.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 14:37:28 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
 <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 14:37:25 -0700
Message-ID: <CA+55aFw8LJ7T_4jTe4q5q0d2JuP0iBWdwcTXZULKe-c4w7QrPA@mail.gmail.com>
Subject: Re: [PATCH RFC rebase 2/9] powerpc: Use barrier_nospec in
 copy_from_user
To: Michal Suchanek <msuchanek@suse.de>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 Nicholas Piggin <npiggin@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 15, 2018 at 12:15 PM, Michal Suchanek <msuchanek@suse.de> wrote:
> This is based on x86 patch doing the same.
>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -258,8 +259,10 @@ do {                                                               \
>         long __gu_err = -EFAULT;                                        \
>         unsigned long  __gu_val = 0;                                    \
>         const __typeof__(*(ptr)) __user *__gu_addr = (ptr);             \
> +       int can_access = access_ok(VERIFY_READ, __gu_addr, (size));     \
>         might_fault();                                                  \
> -       if (access_ok(VERIFY_READ, __gu_addr, (size)))                  \
> +       barrier_nospec();                                               \
> +       if (can_access)                                                 \
>                 __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
>         (x) = (__force __typeof__(*(ptr)))__gu_val;                             \
>         __gu_err;                                                       \

Is the above really correct? The barrier is *before* the conditional
branch that might be mis-predicted.

I don't know how the ppc barrier works, but that sounds completely bogus.

               Linus
