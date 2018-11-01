Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9E3C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 06:51:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186482064C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 06:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qF3Kypgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186482064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lwpy71BQzDqC3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 17:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qF3Kypgy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com;
 envelope-from=amodra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qF3Kypgy"; 
 dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lwmK51RVzDqT3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 17:49:18 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id b5-v6so7860859pla.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 23:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Qhz9qXz2LcZ2ztaI/Cz8A/BpkYdbYPQO8Nm2eJrXEAQ=;
 b=qF3Kypgyh8nvtMXbCt/V7XyXzn/gLHzEs9y+OwH5uhYxTbWdlXim4r7qv+MFkE56bf
 2zerImU2TXRlF00LAcwY/IKjziDNljDnPrzlokwBktGa7YZaQsEUoqfcwqwCqLQFqliU
 uyIVmbDc5Nf97yeMIzJVymIc+DUqcq3bWQbbgRw9i9xfr7w/hrLvrR6icsr8eHm6dc4n
 ShYon0wv0L+DvywJgmZ2V32B4ogsZYMnHS2PeX34I7jvjvifwEGX2576Tm0F8aHMDON1
 kQvtBcr3QgSnuQeKlXCy+v6pUFasD2UaK6Gka9bhGg0NZ8enX6HO8sO5KlvGpHVyBK7T
 Uzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Qhz9qXz2LcZ2ztaI/Cz8A/BpkYdbYPQO8Nm2eJrXEAQ=;
 b=nAV5cdN/Db1YPGPPoV2mlh6IjyOm9qFGxUt+AbpEvzqutBxHDaQihaMUiOxBqjECig
 c+YKd5OmZ/j+n0hQ6ZFEu9tAr6NPHxVvdLQXwhOB0I9q3Dbp71w0E0g7rWfHlJF8VS+k
 Qneetv6u9Cag+KkhVFPdojVO2kHggTHGCfOcNJkg8H333o+dV1ANAZMSyCErks1DeFJY
 p562AjY8cALc7TGK9Tl8HUL4iVhWtfMkcaN7Vayp+YWvSJ2k2b4SYfa22peD/FWirFTc
 va5sa9iCBWtA5UcezErE73XIzEyxGJds/AWYou6FzNwrGyqasXa9H0jC8SJ4AClj0JjW
 aUfg==
X-Gm-Message-State: AGRZ1gJw2jiuXTLV0Zau1/5LXz1G8FhLLgZ90MWuNpGAm6PrtOXnIPlu
 ByjAjuPUi5j4sYu6hP4A7BI=
X-Google-Smtp-Source: AJdET5da/UaFPjsCcuNZI1kXthV/Tq77pYm2HiH1SwWQ6C9nWnqIK8Ij9wxDJVEo5wCAPK8sr1iLiw==
X-Received: by 2002:a17:902:64c1:: with SMTP id
 y1-v6mr6546371pli.210.1541054956461; 
 Wed, 31 Oct 2018 23:49:16 -0700 (PDT)
Received: from bubble.grove.modra.org ([58.175.241.133])
 by smtp.gmail.com with ESMTPSA id e2-v6sm31499689pgv.25.2018.10.31.23.49.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 31 Oct 2018 23:49:15 -0700 (PDT)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
 id 778768052F; Thu,  1 Nov 2018 17:19:11 +1030 (ACDT)
Date: Thu, 1 Nov 2018 17:19:11 +1030
From: Alan Modra <amodra@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: PIE binaries are no longer mapped below 4 GiB on ppc64le
Message-ID: <20181101064911.GB29482@bubble.grove.modra.org>
References: <87k1lyf2x3.fsf@oldenburg.str.redhat.com>
 <87lg6dfo3t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg6dfo3t.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, keescook@chromium.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 01, 2018 at 02:55:34PM +1100, Michael Ellerman wrote:
> Hi Florian,
> 
> Florian Weimer <fweimer@redhat.com> writes:
> > We tried to use Go to build PIE binaries, and while the Go toolchain is
> > definitely not ready (it produces text relocations and problematic
> > relocations in general), it exposed what could be an accidental
> > userspace ABI change.
> >
> > With our 4.10-derived kernel, PIE binaries are mapped below 4 GiB, so
> > relocations like R_PPC64_ADDR16_HA work:
> >
> > 21f00000-220d0000 r-xp 00000000 fd:00 36593493                           /root/extld
> > 220d0000-220e0000 r--p 001c0000 fd:00 36593493                           /root/extld
> > 220e0000-22100000 rw-p 001d0000 fd:00 36593493                           /root/extld
> ...
> >
> > With a 4.18-derived kernel (with the hashed mm), we get this instead:
> >
> > 120e60000-121030000 rw-p 00000000 fd:00 102447141                        /root/extld
> > 121030000-121060000 rw-p 001c0000 fd:00 102447141                        /root/extld
> > 121060000-121080000 rw-p 00000000 00:00 0 
> 
> I assume that's caused by:
> 
>   47ebb09d5485 ("powerpc: move ELF_ET_DYN_BASE to 4GB / 4MB")
> 
> Which did roughly:
> 
>   -#define ELF_ET_DYN_BASE	0x20000000
>   +#define ELF_ET_DYN_BASE		(is_32bit_task() ? 0x000400000UL : \
>   +					   0x100000000UL)
> 
> And went into 4.13.
> 
> > ...
> > I'm not entirely sure what to make of this, but I'm worried that this
> > could be a regression that matters to userspace.
> 
> It was a deliberate change, and it seemed to not break anything so we
> merged it. But obviously we didn't test widely enough.
> 
> So I guess it clearly can matter to userspace, and it used to work, so
> therefore it is a regression.
> 
> But at the same time we haven't had any other reports of breakage, so is
> this somehow specific to something Go is doing? Or did we just get lucky
> up until now? Or is no one actually testing on Power? ;)

Mapping PIEs above 4G should be fine.  It works for gcc C and C++
after all.  The problem is that ppc64le Go is generating code not
suitable for a PIE.  Dynamic text relocations are evidence of non-PIC
object files.

Quoting Lynn Boger <boger@us.ibm.com>:
"When building a pie binary with golang, they should be using
-buildmode=pie and not just pass -pie to the linker".

-- 
Alan Modra
Australia Development Lab, IBM
