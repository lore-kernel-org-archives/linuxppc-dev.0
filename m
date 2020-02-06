Return-Path: <SRS0=dZYZ=32=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E971C2D0B1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 03:39:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27B320661
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 03:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rLS0PFZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27B320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48CkhT0PDnzDqcq
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Feb 2020 14:39:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48CkPQ4wPgzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2020 14:26:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=rLS0PFZd; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48CkPN3S20z9sRG;
 Thu,  6 Feb 2020 14:26:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1580959609;
 bh=8OfTVfN8xQPUJ7uI6RIUaXiPM9RlpWEIvFQyGAd09m4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rLS0PFZdW3p2Rhbqx+18BYen6fJK1S7v7vVgd2/tz8PnZoOMzjwcAc2u6w5fOc3EM
 cPKUh9kXagQ/vuNKl6ZjK3U1EUtDkRtiyhbo+FA57K3n80m668HEUbArubeliGvOE9
 ysBeRW1JGvvnVCPur3tmNPYowD9fsj2yPjJb6pvsrAjeHdb44NY/gUR7INkzWq4VX2
 lNc84tXcy/2vt+axddHuR7mgqY2Op2K0CAPFODWGp0B3lrQ7JFQV967hUfFMVyTu1z
 TcWBSZvLPCnjgzCbt0c+c1qq5F/RXFumFqjbnZOySXxOOfcTkMx7S4PGsXR6YdaQ/+
 SpulMtXKHQZ+w==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "H.J. Lu" <hjl.tools@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [yyu168-linux_cet:cet 55/58] powerpc64le-linux-ld: warning:
 discarding dynamic section .rela___ksymtab+jiffies_to_timeval
In-Reply-To: <CAMe9rOrJEVL8Qw3fgm9FeDjwGZNxGoZ-OO6bfmV=gtK=g68cvQ@mail.gmail.com>
References: <202002050743.dc2PtIsm%lkp@intel.com>
 <CAMe9rOrJEVL8Qw3fgm9FeDjwGZNxGoZ-OO6bfmV=gtK=g68cvQ@mail.gmail.com>
Date: Thu, 06 Feb 2020 14:26:47 +1100
Message-ID: <87wo901jm0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, kbuild-all@lists.01.org,
 Kees Cook <keescook@chromium.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"H.J. Lu" <hjl.tools@gmail.com> writes:
> On Tue, Feb 4, 2020 at 3:37 PM kbuild test robot <lkp@intel.com> wrote:
>>
>> tree:   https://github.com/yyu168/linux_cet.git cet
>> head:   bba707cc4715c1036b6561ab38b16747f9c49cfa
>> commit: 71bb971dd76eeacd351690f28864ad5c5bec3691 [55/58] Discard .note.gnu.property sections in generic NOTES
>> config: powerpc-rhel-kconfig (attached as .config)
>> compiler: powerpc64le-linux-gcc (GCC) 7.5.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 71bb971dd76eeacd351690f28864ad5c5bec3691
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=7.5.0 make.cross ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>    powerpc64le-linux-ld: warning: discarding dynamic section .rela___ksymtab_gpl+__wait_rcu_gp
>
> arch/powerpc/kernel/vmlinux.lds.S has
>
>  .rela.dyn : AT(ADDR(.rela.dyn) - (0xc000000000000000 -0x00000000))
>  {
>   __rela_dyn_start = .;
>   *(.rela*) <<<<<<<< Keep .rela* sections
>  }

The above is inside #ifdef CONFIG_RELOCATABLE

> ...
>  /DISCARD/ : {
>   *(*.EMB.apuinfo)
>   *(.glink .iplt .plt .rela* .comment)
>                            ^^^^ Discard  .rela* sections.  But it is ignored.
>   *(.gnu.version*)
>   *(.gnu.attributes)
>   *(.eh_frame)
>  }

But that is not #ifdef'ed at all.

> With my
>
> ommit 71bb971dd76eeacd351690f28864ad5c5bec3691
> Author: H.J. Lu <hjl.tools@gmail.com>
> Date:   Thu Jan 30 12:39:09 2020 -0800
>
>     Discard .note.gnu.property sections in generic NOTES
>
>     With the command-line option, -mx86-used-note=yes, the x86 assembler
>     in binutils 2.32 and above generates a program property note in a note
>     section, .note.gnu.property, to encode used x86 ISAs and features.  But
>     kernel linker script only contains a single NOTE segment:
>
> /DISCARD/ : { *(.note.gnu.property) }
>
> is placed before
>
> .rela.dyn : AT(ADDR(.rela.dyn) - (0xc000000000000000 -0x00000000))
>  {
>   __rela_dyn_start = .;
>   *(.rela*) <<<<<<<< Keep .rela* sections
>  }
>
> Then .rela* in
>
>  /DISCARD/ : {
>   *(*.EMB.apuinfo)
>   *(.glink .iplt .plt .rela* .comment)
>   *(.gnu.version*)
>   *(.gnu.attributes)
>   *(.eh_frame)
>  }
>
> is honored.  Can someone from POWERPC comment on it?

Hmm OK. I'm not really a toolchain person.

The comment on DISCARDS says:

   * Some archs want to discard exit text/data at runtime rather than
   * link time due to cross-section references such as alt instructions,
   * bug table, eh_frame, etc.  DISCARDS must be the last of output
   * section definitions so that such archs put those in earlier section
   * definitions.
   */

But I guess you're changing those semantics in your series.

This seems to fix the warning for me?

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index b4c89a1acebb..076b3e8a849d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -365,9 +365,12 @@ SECTIONS
 	DISCARDS
 	/DISCARD/ : {
 		*(*.EMB.apuinfo)
-		*(.glink .iplt .plt .rela* .comment)
+		*(.glink .iplt .plt .comment)
 		*(.gnu.version*)
 		*(.gnu.attributes)
 		*(.eh_frame)
+#ifndef CONFIG_RELOCATABLE
+		*(.rela*)
+#endif
 	}
 }


cheers
