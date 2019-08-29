Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF66C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 14:37:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB5722CED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 14:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB5722CED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46K4vY4mD1zDrqF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Aug 2019 00:37:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46K4pY6qm8zDrBx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Aug 2019 00:33:09 +1000 (AEST)
Received: by mail-qk1-f196.google.com with SMTP id f13so3039031qkm.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 07:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u90BzevMbaxyx55NRwOyXEZ+TCaloyf9Ga0nSNG0ILw=;
 b=L5Dm57N5uKcaY0SyaNPZn6EwsUh7z73LiGhY2pYkgsS0l8b0OssVmMAAS0R+WyIkIZ
 JGsq7s3H9sE53kzRuLcp5LjcC10UKRPwHkHWihqT5iZh8QOWU2XXqa9r+3/LtQSLlwnO
 O/bHH7KMbqiKKroFooSSUX9XD7psVlxKPbdFiU08ruNckjY8qPQQQVsfWfv334ja7zFm
 KfJsTkMOtfgoMTo9N6ke0J0W8hxQq68HtGxYdUNXXCWv4XaZOq7bUJNU4e8DaQHG7JkQ
 MTX0l4/XYvUFBAVqdxe1dWqveFu4gDlDRCXlZ1Gk8ZzqPac8SR+J5SPQihDUsBGTUUaY
 KxIA==
X-Gm-Message-State: APjAAAXH+xmxC9dn2DVOdyUwoRQMBNE/wPGGctA9NTHKVGu5Mf8QKTlV
 ViHQPwfsj12rc+EbZxQYuXlZst4CApCfd95Lrec=
X-Google-Smtp-Source: APXvYqzK05kJtQELzAjwpofc7UfddmmDx8VQSbo2PS0jNh4V8Vc8Bi/ngrIFAioSJ4e107HuOrlcp0MS8Gpn1qE+q+w=
X-Received: by 2002:a37:4051:: with SMTP id n78mr9499689qka.138.1567089186639; 
 Thu, 29 Aug 2019 07:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567072270.git.msuchanek@suse.de>
 <061a0de2042156669303f95526ec13476bf490c7.1567072270.git.msuchanek@suse.de>
 <CAK8P3a1wR-jzFSzdPqgfCG4vyAi_xBPVGhc6Nn4KaXpk3cUiJw@mail.gmail.com>
 <20190829143716.6e41b10e@naga>
 <CAK8P3a2DHP+8Vbc4yjq5-wT9GpSxvndCa8gnvx0WcD8YAUAsMw@mail.gmail.com>
 <20190829161923.101ff3eb@kitsune.suse.cz>
In-Reply-To: <20190829161923.101ff3eb@kitsune.suse.cz>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 29 Aug 2019 16:32:50 +0200
Message-ID: <CAK8P3a3DHqhbVToqRYqTmfCcSdT5sXb=1SO5jY9jDONDa6ORkA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] powerpc: make llseek 32bit-only.
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Michael Neuling <mikey@neuling.org>, Allison Randal <allison@lohutok.net>,
 Nicolai Stange <nstange@suse.de>, David Hildenbrand <david@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <christian@brauner.io>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Breno Leitao <leitao@debian.org>, Firoz Khan <firoz.khan@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Hari Bathini <hbathini@linux.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 29, 2019 at 4:19 PM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
> On Thu, 29 Aug 2019 14:57:39 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Aug 29, 2019 at 2:37 PM Michal Such=C3=A1nek <msuchanek@suse.de=
> wrote:
> > > On Thu, 29 Aug 2019 14:19:46 +0200 Arnd Bergmann <arnd@arndb.de> wrot=
e:
> > > > On Thu, Aug 29, 2019 at 12:23 PM Michal Suchanek <msuchanek@suse.de=
> wrote:
> > > > In particular, I don't see why you single out llseek here, but leav=
e other
> > > > syscalls that are not needed on 64-bit machines such as pread64().
> > >
> > > Because llseek is not built in fs/ when building 64bit only causing a
> > > link error.
> > >
> > > I initially posted patch to build it always but it was pointed out it
> > > is not needed, and  the interface does not make sense on 64bit, and
> > > that platforms that don't have it on 64bit now don't want that useles=
s
> > > code.
> >
> > Ok, please put that into the changeset description then.
> >
> > I looked at uses of __NR__llseek in debian code search and
> > found this one:
> >
> > https://codesearch.debian.net/show?file=3Dumview_0.8.2-1.2%2Fxmview%2Fu=
m_mmap.c&line=3D328
> >
> > It looks like this application will try to use llseek instead of lseek
> > when built against kernel headers that define __NR_llseek.
> >
>
> The available documentation says this syscall is for 32bit only so
> using it on 64bit is undefined. The interface is not well-defined in
> that case either.

That's generally not how it works. If there is an existing application
that relies on the behavior of the system call interface, we should not
change it in a way that breaks the application, regardless of what the
documentation says. Presumably nobody cares about umview on
powerpc64, but there might be other applications doing the same
thing.

It looks like sparc64 and parisc64 do the same thing as powerpc64,
and provide llseek() calls that may or may not be used by
applications.

I think your original approach of always building sys_llseek on
powerpc64 is the safe choice here.

     Arnd
