Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C3ECDE3B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:19:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343D8208E4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrXjuZHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343D8208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b4nW0f7ZzF3Zm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 08:19:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WrXjuZHZ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="WrXjuZHZ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b4kv5LR3zF3Zj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 08:17:27 +1100 (AEDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 775CE21479
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539811045;
 bh=g2il2KgyF0vLxwMylQFDgfxo+XL4J5qudxh9j/KR35g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=WrXjuZHZ824L7He7U1uvSiBNpx9QBSCtBr9wVYZ1T5aapuFl4NzhNVVE+U/zD8siF
 upTWTXPMCfcC25luy1HX+O28/Hked8dd52902RKqjn3PPCd0mrcYC49E6oYUHNq609
 zcVvrsG754iSk+Pm6yQdJc7zROvG/7a1h52Rf+IU=
Received: by mail-ed1-f45.google.com with SMTP id w19-v6so26250503eds.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 14:17:25 -0700 (PDT)
X-Gm-Message-State: ABuFfohV9f/DxnwRini2Nn8lmBq4iziXIKsH4aV4UzfguzqmzkdRqEoF
 DYW3QvkAQIEen59Q2mlZrV3+L7Iit9HmH4F814k=
X-Google-Smtp-Source: ACcGV616i1NX6BUJvbOs8GjNFRy5Boj0HC7hOVmHumIBdrfNuHf+DMwGpsYLlnNvNAfTlu0bTE8YlDYvFoCrfL4H8Bo=
X-Received: by 2002:a50:cd57:: with SMTP id
 d23-v6mr1716930edj.60.1539811043733; 
 Wed, 17 Oct 2018 14:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <87murekyts.fsf@concordia.ellerman.id.au>
 <bbbbe52c-8415-e22a-48d7-95f919942c68@gmail.com>
In-Reply-To: <bbbbe52c-8415-e22a-48d7-95f919942c68@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 17 Oct 2018 16:16:47 -0500
X-Gmail-Original-Message-ID: <CANk1AXSa1bMHxp7-PiTtfniDukDO51M=4P5u98Xc=rRo06zP7Q@mail.gmail.com>
Message-ID: <CANk1AXSa1bMHxp7-PiTtfniDukDO51M=4P5u98Xc=rRo06zP7Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] of: overlay: validation checks, subsequent fixes
To: Frank Rowand <frowand.list@gmail.com>
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 16, 2018 at 10:08 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/16/18 02:47, Michael Ellerman wrote:
> > frowand.list@gmail.com writes:
> >
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Add checks to (1) overlay apply process and (2) memory freeing
> >> triggered by overlay release.  The checks are intended to detect
> >> possible memory leaks and invalid overlays.
> >>
> >> The checks revealed bugs in existing code.  Fixed the bugs.
> >>
> >> While fixing bugs, noted other issues, which are fixed in
> >> separate patches.
> >>
> >> *****  Powerpc folks: I was not able to test the patches that
> >> *****  directly impact Powerpc systems that use dynamic
> >> *****  devicetree.  Please review that code carefully and
> >> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> >
> > Hi Frank,
> >
> > Do you have this series in a git tree somewhere?
> >
> > I tried applying it on top of linux-next but hit some conflicts which I
> > couldn't easily resolve.
> >
> > cheers
> >
>
>
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git
>
> $ git checkout v4.19-rc1--kfree_validate--v4
>
> $ git log --oneline v4.19-rc1..
> 2ba1b7d353dd of: unittest: initialize args before calling of_*parse_*()
> 4f9108209f79 of: unittest: find overlays[] entry by name instead of index
> 353403c76ff8 of: unittest: allow base devicetree to have symbol metadata
> 8fc37e04a01b of: overlay: set node fields from properties when add new overlay n
> 05d5df0e5151 of: unittest: remove unused of_unittest_apply_overlay() argument
> 8c021cba757a of: overlay: check prevents multiple fragments touching same proper
> 797a6f66e039 of: overlay: check prevents multiple fragments add or delete same n
> c385e25a040d of: overlay: test case of two fragments adding same node
> c88fd240f0e0 of: overlay: make all pr_debug() and pr_err() messages unique
> 1028a215d32a of: overlay: validate overlay properties #address-cells and #size-c
> f1a97ef74ce4 of: overlay: reorder fields in struct fragment
> ffe78cf7a1fb of: dynamic: change type of of_{at,de}tach_node() to void
> 5f5ff8ec0c0c of: overlay: do not duplicate properties from overlay for new nodes
> 06e72dcb2bb0 of: overlay: use prop add changeset entry for property in new nodes
> a02f8d326a08 powerpc/pseries: add of_node_put() in dlpar_detach_node()
> e203be664330 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
> 8eb46208e7c8 of: overlay: add missing of_node_put() after add new node to change
> b22067db7cf9 of: overlay: add tests to validate kfrees from overlay removal

That branch is a real time saver, thanks!

ALan
