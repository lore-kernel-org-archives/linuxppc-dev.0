Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E6EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 08:43:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72A920857
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 08:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72A920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T4QW5WvDzDqJ5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 19:42:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T4NY18LvzDqJ5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 19:41:16 +1100 (AEDT)
Received: by mail-qk1-f196.google.com with SMTP id n68so7108634qka.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 01:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FsvXmJOm0pyAEzqJwh7QrRIEtsG70UpLjTLyzkR25QM=;
 b=sfBU+362Sl3l/bQhGmuqiij5fIL5/lIQcluD9NWAM7nfM4gPFwY5rIV/rE6N4jGboD
 Pj4TcK/aYpYyQSd/vBz/FO6FuDOkY4fsNPkHkN2ULlUAQGLY0aSQ1CilNouuwiYCUtlP
 KznjG4Bx4Gc/v4h9NmuMv2wDCRTQcJpG71C88ixEJ+kPx8XD9/pM5EslT2eIn0HjNX4C
 VTvANUvTejE+MyRUj4D5c3d7WMuGAfmsHX3vrGKqLMD0s40veGesLrrKy9YO7H3PLgSa
 I3+LZQwAU5Rvo33UCzc7Of4cvcK0ZhQs3V9RR1hMiK5HOILB3wKbgskHacPA4GBk3fNH
 OA2Q==
X-Gm-Message-State: APjAAAVl6VH3/op+x/S2pdrLkSQbsBwPhbylsxuvm0ZgKIlEzHhafAZ9
 r7/wYHmjeERG5a9pp5PVCJ1IIUIe6pljN3SA2M0=
X-Google-Smtp-Source: APXvYqzWbuWCanAHJozGrgBku0Nl3U4qpb5NhALU98xKcvW3XcvnqLpIieND44urCirxL5XGMyEfYrhtUAoIc81gmlU=
X-Received: by 2002:a05:620a:133b:: with SMTP id
 p27mr23057938qkj.173.1553589674188; 
 Tue, 26 Mar 2019 01:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <20190325173704.mun2cj2ulswv7s3i@pburton-laptop>
In-Reply-To: <20190325173704.mun2cj2ulswv7s3i@pburton-laptop>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 26 Mar 2019 09:40:57 +0100
Message-ID: <CAK8P3a1dVLdL_oM8iCGP1R0SG=4BrrsPSaTare5NN5WLxJb_Uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To: Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 25, 2019 at 6:37 PM Paul Burton <paul.burton@mips.com> wrote:
> On Mon, Mar 25, 2019 at 03:47:37PM +0100, Arnd Bergmann wrote:
> > Add the io_uring and pidfd_send_signal system calls to all architectures.
> >
> > These system calls are designed to handle both native and compat tasks,
> > so all entries are the same across architectures, only arm-compat and
> > the generic tale still use an old format.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >%
> > diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > index c85502e67b44..c4a49f7d57bb 100644
> > --- a/arch/mips/kernel/syscalls/syscall_n64.tbl
> > +++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
> > @@ -338,3 +338,7 @@
> >  327  n64     rseq                            sys_rseq
> >  328  n64     io_pgetevents                   sys_io_pgetevents
> >  # 329 through 423 are reserved to sync up with other architectures
> > +424  common  pidfd_send_signal               sys_pidfd_send_signal
> > +425  common  io_uring_setup                  sys_io_uring_setup
> > +426  common  io_uring_enter                  sys_io_uring_enter
> > +427  common  io_uring_register               sys_io_uring_register
>
> Shouldn't these declare the ABI as "n64"?
>
> I don't see anywhere that it would actually change the generated code,
> but a comment at the top of the file says that every entry should use
> "n64" and so far they all do. Did you have something else in mind here?

You are right, the use of 'common' here is unintentional but harmless,
and I should have used 'n64' here.

We may decide to do things differently in the future, i.e. we could
have just a single global file for newly added system calls once
it turns out that the tables are consistent across all architectures,
but I'd probably go on with the separate identical entries for a bit
before changing that.

     Arnd
