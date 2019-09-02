Return-Path: <SRS0=Itbs=W5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C70C3A59B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 09:45:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF8E21897
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 09:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF8E21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MQDH4vgjzDqRN
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 19:45:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MQ9h1gcmzDqfY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 19:42:47 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3AA39ABBE;
 Mon,  2 Sep 2019 09:42:43 +0000 (UTC)
Date: Mon, 2 Sep 2019 11:42:39 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 5/6] powerpc/64: Make COMPAT user-selectable disabled
 on littleendian by default.
Message-ID: <20190902114239.32bd81f4@naga>
In-Reply-To: <87ftlftpy7.fsf@mpe.ellerman.id.au>
References: <cover.1567198491.git.msuchanek@suse.de>
 <c7c88e88408588fa6fcf858a5ae503b5e2f4ec0b.1567198492.git.msuchanek@suse.de>
 <87ftlftpy7.fsf@mpe.ellerman.id.au>
Followup-To: linux-fsdevel@vger.kernel.org
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Michael Neuling <mikey@neuling.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 David Hildenbrand <david@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Diana Craciun <diana.craciun@nxp.com>,
 Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>,
 Allison Randal <allison@lohutok.net>, Breno Leitao <leitao@debian.org>,
 Firoz Khan <firoz.khan@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 02 Sep 2019 12:03:12 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Michal Suchanek <msuchanek@suse.de> writes:
> > On bigendian ppc64 it is common to have 32bit legacy binaries but much
> > less so on littleendian.  
> 
> I think the toolchain people will tell you that there is no 32-bit
> little endian ABI defined at all, if anything works it's by accident.

I have seen a piece of software that workarounds code issues on 64bit
by always compiling 32bit code. So it does work in some way. Also it
has been pointed out that you can still switch to BE even with the
'fast-switch' removed.

> 
> So I think we should not make this selectable, unless someone puts their
> hand up to say they want it and are willing to test it and keep it
> working.

I don't really care either way.

Thanks

Michal

> 
> cheers
> 
> > v3: make configurable
> > ---
> >  arch/powerpc/Kconfig | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index 5bab0bb6b833..b0339e892329 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -264,8 +264,9 @@ config PANIC_TIMEOUT
> >  	default 180
> >  
> >  config COMPAT
> > -	bool
> > -	default y if PPC64
> > +	bool "Enable support for 32bit binaries"
> > +	depends on PPC64
> > +	default y if !CPU_LITTLE_ENDIAN
> >  	select COMPAT_BINFMT_ELF
> >  	select ARCH_WANT_OLD_COMPAT_IPC
> >  	select COMPAT_OLD_SIGACTION
> > -- 
> > 2.22.0  

