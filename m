Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 2E67067BE1
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 14:33:32 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id k27so2446472nfc
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 21:33:31 -0700 (PDT)
Message-ID: <787b0d920608132133g6e052fah4df23fcf81a71e6d@mail.gmail.com>
Date: Mon, 14 Aug 2006 00:33:30 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <17631.62940.63888.908937@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<17631.62940.63888.908937@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/14/06, Paul Mackerras <paulus@samba.org> wrote:
> Albert Cahalan writes:
>
> > If you want heap protection, change VM_DATA_DEFAULT_FLAGS32
> > in include/asm-powerpc/page.h to be like VM_STACK_DEFAULT_FLAGS.
> > I'd love to hear if anybody can get X to start with this change.
>
> In general I would expect dynamically-linked programs to fail unless
> you compile everything with gcc -msecure-plt.

I wouldn't, unless they are also buggy. The PLT should be
marked for full rwx permissions. Enforcing W^X is another
matter entirely of course.

For me, X is the only observed failure with that extra change.
I successfully got to a console, did a bit of exploring at the
command prompt, watched X go to the stiple background
before shutting down in an orderly fashion, and rebooted.
Perhaps do_brk could get a third argument to specify the
caller, so that VM_EXEC could be cleared for some callers.
Then again, pretending to be a Vista developer, I could just
have the kernel recognize the buggy X server.

Other notes:

For maximum benefit, shared objects should be built such
that the executable part can be mapped without any
relation to the other parts. The next best thing would be
to have the executable parts start 256 MiB above where
the other parts start. This allows randomization to be
added without causing loss of no-execute capability.

We need a new gcc default: -msecure-plt -pie -fPIE
