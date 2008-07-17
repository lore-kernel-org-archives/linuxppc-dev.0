Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.232])
	by ozlabs.org (Postfix) with ESMTP id 361C2DDF36
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 10:38:16 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so5129862rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 17:38:14 -0700 (PDT)
Message-ID: <9e4733910807161738g58da8bd7v78e9d50dc4d846cb@mail.gmail.com>
Date: Wed, 16 Jul 2008 20:38:14 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Milton Miller" <miltonm@bga.com>
Subject: Re: [HOW] binutils-2.17 breaks the 2.6.26 kernel
In-Reply-To: <1dce2aab6509053e60f7a59a30974749@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1dce2aab6509053e60f7a59a30974749@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Alan Modra <amodra@bigpond.net.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/16/08, Milton Miller <miltonm@bga.com> wrote:
> Hi.

Previous threads have mentioned that binutil-2.17 is broken for
building powerpc kernels. It is fixed in binutils-2.18.

I have encountered this and upgrading to 2.18 fixed my build. The
symptom is large kernel sizes and a long time in gzip. In my case it
was gziping a 2GB file.

>
>  I've been working with Debian bintuils 2.17-3 (which identifies
>  itself as 2.17) on my build box for some time.
>
>  When testing all-yes-config, I was getting warnings, but the
>  vmlinux was booting via kexec.
>
>  Since I was replicating the warnings from BFD about section lmas
>  overlapping in vmlinux.strip.$$, I was encouraged to actually try
>  booting the resulting stripped kernel.  After a false start (getting
>  the old binary) I ended up replicating the fail-to-boot some people
>  have reported on linuxppc-dev.
>
>  Digging into the failure, we were trying to copy *way* too much data
>  in copy_and_flush from after_prom.   I found the value loaded from
>  _klimit was something like 0x00002fea_00400000, not quite _end that
>  it was initialized.
>
>  I tracked this down to the .rodata and all sections following loosing
>  the inter-section alignment.
>
>
>  /DISCARD/ {
>   ....
>  }
>  text: AT( .text - LOAD_OFFSET): {
>   ....
>  }
>
>  . = ALIGN(0x1000)   /* this align directive aparently gets lost
>                        when stripping the file */
>
>  .rodata: AT (.rodata - LOAD_OFFSET): {
>   ...
>  }
>
>  the effects of that align were dropped during strip, shifting all
>  following sections up in memory and the resulting failure.
>
>  I don't know if the fault is ld or strip.
>
>  The behavior came between 2.6.24 and -next-20080710, but others
>  have suggested their kernels don't boot in the 2.6.25 to 2.6.26
>  transition, and a likely candidate is the addition of AT(x) to
>  set the lma, although we also switched form TEXT_TEXT macro in
>  include/asm-generic.h to a hand-rolled .text section.
>
>  Can we come up with a workaround?
>
>  thanks,
>  milton
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Jon Smirl
jonsmirl@gmail.com
