Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3C4C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 10:21:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8197920840
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 10:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8197920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fjsg2yWFzDqXM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 21:21:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fjqs2tyVzDqTY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 21:19:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fjqs0zfNz8tQK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 21:19:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fjqs0bgdz9sDB; Wed, 16 Jan 2019 21:19:37 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.196; helo=mail-qt1-f196.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fjqr33gyz9sCX
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 21:19:36 +1100 (AEDT)
Received: by mail-qt1-f196.google.com with SMTP id n32so6480879qte.11
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 02:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5aPMi4lYidLibL1tjnFXjVPtp1TMBYAyap8CKfQrzHI=;
 b=dRhiow5Iwaptj+Zx38mWmr4buGtJ6TU5/tOKa/uqS+LRM8w64DaYLqGwf6LBQjPl5h
 pPS7DVblFbl9ToNwUFQBBaTXyrV/laxft+UtU1DG629Dfi29q6Jysl+AvWJe/Otpqq6j
 pZt9LYQFpoV9fon1gfBTOj6DrgZIbFknKrESPMvxO0o42yx+hHxeUpVi7jDsfk75ZlCB
 0WWFSYqzm4Zgyyb275RuWw7fBN/9ynkFTm1jDxvkX3jGrmNvw8WKl47Ln2O6m68Z8Qwe
 A6uCTgTk0kGyzLgzcX/G38Qz+8DMogfmdtu29pifpIhpEQsmfaMDheEZ94OZ4s4AmWV+
 7FAQ==
X-Gm-Message-State: AJcUukfiYrHIvdN1rC29qta2lu1uANgcncG28pARHqI8tnSAAd9vtfkD
 fWUGGEDacvy1K5rE54GyGmvI9vdyF4XShVBB9rI=
X-Google-Smtp-Source: ALg8bN5w6XcX9Pk4it7kSliUuMSLTHj/vYT0K21uPgFoTOGwnXZP0lcpphcgD/mND8WIIr4IvN+xo/BDkI/2ITb1bu8=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr6299511qvk.40.1547633974016; 
 Wed, 16 Jan 2019 02:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20190114113620.17558-1-mpe@ellerman.id.au>
 <CAK8P3a3PnbJ1Mr01HeRUzk+cfK4t-yok4YTJdNrBs6f==fVrnw@mail.gmail.com>
 <87y37lxx1s.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y37lxx1s.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 11:19:17 +0100
Message-ID: <CAK8P3a2UA9n8VmdpRMp-2HakOk=w1UaRiPvmLhF7A4_4Z0sENw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] powerpc/syscalls: Remove unused offset parameter
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 16, 2019 at 1:31 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Mon, Jan 14, 2019 at 12:36 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >>
> >> We never pass a value for offset, nor do we need to, so remove the
> >> offset logic.
> >>
> >> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> >
> > This change and the next three defeat the idea of having a shared script across
> > all architectures.
>
> The scripts are < 100 lines total, so sharing them across arches is
> really not much of a win. Especially if it requires compromising the
> format of the table on some architectures. Shoe horning the SPU
> visibility into the ABI field was a good hack but I really dislike it
> being the permanent state of our syscall table.

IMHO the main advantage is that sharing the scripts guarantees that
the format remains compatible across all architectures, which in turn
allows us to build additional tooling around these files, and make it
less error-prone to do cross-architecture changes.

> > Firoz has already posted patches to move the scripts to scripts/syscalltbl.sh
>
> Those don't work for x86 AFAICS?

I hope we can address that in a follow-up step, integrating all of arm, s390 and
x86, which had the scripts first.

> > and I think it's better to go on with those patches, as they
> > also guarantee that the format of the files remains consistent across all
> > architectures.
>
> Why is that a requirement?
>
> Another possibility is that we have a separate file that stores the SPU
> visibility, that way our syscall.tbl would have the same format as other
> arches, and we could probably share the scripts, but we'd need our own
> script for generating the SPU table.
>
> I'll hack that up and see how it looks.

Ok. See also what x86 has done, they also have some extensions to
their copy of the script.

I still think that keeping the information about the SPU in the same file
is best, otherwise it becomes harder to maintain as changes to the
main table are done, unless we decide that we don't want to leave
the SPU syscalls as explicit opt-in for future additions.

Even as CellBE hardware was being actively marketed, the syscall
interfaces were never overly popular, so it's unlikely that anyone relies
on future syscalls here anway. From the newlib repository, I see only
eight system calls being used in total: getpid, gettid, pread, pwrite,
read, write, readv, and writev.

      Arnd
