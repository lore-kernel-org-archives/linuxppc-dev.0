Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732B1C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 08:09:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA3420856
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 08:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="GNop4NB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA3420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T3hJ3CTFzDqLc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:09:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="GNop4NB2"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T3fX5rb8zDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 19:08:20 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44T3fQ0NbGz9v0yJ;
 Tue, 26 Mar 2019 09:08:14 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=GNop4NB2; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id Q4lrZz2J9YE4; Tue, 26 Mar 2019 09:08:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44T3fP68bwz9v0yH;
 Tue, 26 Mar 2019 09:08:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553587693; bh=fHlUorOW1PLb+F6VBcezhvDqA2G5C4fxSEBQb7e9/fw=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=GNop4NB2xhGSbWJxnPoLyMj5rg6zAcV0Vha2iHQP8nghR5pKsR2J3cD6t7qNG5yN6
 l0VciZkKwgWZIyO6bcm6ZkMk3UtYkFGJd48hrHtKz3YNX7cHdAc7MP9PH7Gj9ofTJQ
 bbylaFA3arxH7DuPMFRSMvxAmz7UVY1VjYa/lUH4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C6E278B74C;
 Tue, 26 Mar 2019 09:08:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 8MK1k56WFYX9; Tue, 26 Mar 2019 09:08:14 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A77C8B8BE;
 Tue, 26 Mar 2019 09:08:14 +0100 (CET)
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
To: Michael Ellerman <mpe@ellerman.id.au>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <197cd8df-11c4-0ff9-f35b-e708f712b97c@c-s.fr>
Date: Tue, 26 Mar 2019 09:08:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <874l7qpi7l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/03/2019 à 01:55, Michael Ellerman a écrit :
> Joel Stanley <joel@jms.id.au> writes:
>> Segher added some workarounds for GCC 4.2 and bintuils 2.18. We now set
>> 4.6 and 2.20 as the minimum, so they can be dropped.
>>
>> This is mostly a revert of c69cccc95fe4 ("powerpc: Fix build bug with
>> binutils < 2.18 and GCC < 4.2").
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   arch/powerpc/kernel/vmlinux.lds.S | 35 ++++---------------------------
>>   1 file changed, 4 insertions(+), 31 deletions(-)
> 
> Seems this breaks some toolchains, at least the one from kernel.org:
> 
>    /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: .tmp_vmlinux1: Not enough room for program headers, try linking with -N
>    /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: final link failed: Bad value
>    make[1]: *** [/kisskb/src/Makefile:1024: vmlinux] Error 1
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/13743374/
> 
> Not sure why.
> 
> That's binutils 2.30.
> 

ld doc says:

6586 @cindex not enough room for program headers
6587 @cindex program headers, not enough room
6588 When producing an ELF output file, if the linker script uses the
6589 @code{SIZEOF_HEADERS} builtin function, the linker must compute the
6590 number of program headers before it has determined all the section
6591 addresses and sizes.  If the linker later discovers that it needs
6592 additional program headers, it will report an error @samp{not enough
6593 room for program headers}.  To avoid this error, you must avoid using
6594 the @code{SIZEOF_HEADERS} function, or you must rework your linker
6595 script to avoid forcing the linker to use additional program 
headers, or
6596 you must define the program headers yourself using the @code{PHDRS}
6597 command (@pxref{PHDRS}).
6598 @end table


What about just removing the dummy section, and keeping everything else ? :

diff --git a/arch/powerpc/kernel/vmlinux.lds.S 
b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..511bff8e4a8f 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -20,20 +20,6 @@ ENTRY(_stext)
  PHDRS {
  	kernel PT_LOAD FLAGS(7); /* RWX */
  	notes PT_NOTE FLAGS(0);
-	dummy PT_NOTE FLAGS(0);
-
-	/* binutils < 2.18 has a bug that makes it misbehave when taking an
-	   ELF file with all segments at load address 0 as input.  This
-	   happens when running "strip" on vmlinux, because of the AT() magic
-	   in this linker script.  People using GCC >= 4.2 won't run into
-	   this problem, because the "build-id" support will put some data
-	   into the "notes" segment (at a non-zero load address).
-
-	   To work around this, we force some data into both the "dummy"
-	   segment and the kernel segment, so the dummy segment will get a
-	   non-zero load address.  It's not enough to always create the
-	   "notes" segment, since if nothing gets assigned to it, its load
-	   address will be zero.  */
  }

  #ifdef CONFIG_PPC64
@@ -179,14 +165,6 @@ SECTIONS

  	NOTES :kernel :notes

-	/* The dummy segment contents for the bug workaround mentioned above
-	   near PHDRS.  */
-	.dummy : AT(ADDR(.dummy) - LOAD_OFFSET) {
-		LONG(0)
-		LONG(0)
-		LONG(0)
-	} :kernel :dummy
-
  /*
   * Init sections discarded at runtime
   */


Christophe
