Return-Path: <acahalan@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 7FB55679FB
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Aug 2006 02:02:10 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p48so110719nfa
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 09:02:07 -0700 (PDT)
Message-ID: <787b0d920608140902m3da2592ejbd5a1a9cee3182e4@mail.gmail.com>
Date: Mon, 14 Aug 2006 12:02:06 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "=?ISO-8859-1?Q?Michel_D=E4nzer?=" <michel@tungstengraphics.com>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <1155547172.12664.115.camel@thor.lorrainebruecke.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<1155547172.12664.115.camel@thor.lorrainebruecke.local>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/14/06, Michel D=E4nzer <michel@tungstengraphics.com> wrote:
> On Sun, 2006-08-13 at 23:20 -0400, Albert Cahalan wrote:
> >
> > If you want heap protection, change VM_DATA_DEFAULT_FLAGS32
> > in include/asm-powerpc/page.h to be like VM_STACK_DEFAULT_FLAGS.
> > I'd love to hear if anybody can get X to start with this change.
> > For me (Xorg w/ ATI) a module load fails.
>
> Which versions of the X server and driver, and which module fails to
> load exactly how? As of X.Org 6.9, the X server no longer uses a custom
> module loader but just dlopen and friends.

xorg                    1:7.0.20
xserver-xorg            1:7.0.20
xserver-xorg-core       1:1.0.2-8
xserver-xorg-video-ati  1:6.5.8.0-1

Debian's aptitude program didn't complain, and I didn't do anything
like holding back a package, so the version mismatch isn't my doing.

What calls does the old X server use to allocate the memory?
Knowing the mmap() and/or mprotect() args might help to let
the old server still work.

If dlopen() doesn't need to patch up the code, W^X could be
enforced on the new X server.
