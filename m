Return-Path: <linuxppc-dev+bounces-22434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7452BCD98C5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 23:30:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbMTl75YNz2ysW;
	Thu, 11 Jun 2026 09:30:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781125595;
	cv=pass; b=E3z/CT8306hnk9a/WTeRqUN0Yax4DMZ7BIaiiXhJxdq6gTSLDFI39D49xyV4hJg/dZ3FlE6+S1BY9YWSvoMKtA86ThJ7/o378IUGQIcw9rNYc8dqsu9Wj7OoMVYVgaY3pe7QPXV+2Z6gDq6t1aEqw+R1ov8CbPxjNpvHLvBnuKxv9o09POkvDjFvQRQXgDLeVcEr49Q/ZvadZmOjvzYWjLc6bMEDAy8nOi1m7D+1ZbZUpvZP5C/FJpUgPTy6d3vWQvlV3DAxLAIPdg0K5r+YZN/WFKLjuJ1vwySko/DL3qia9u+Jv4NbdudRGjI59uLrmBXdxDindS+Dst/E4eoltQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781125595; c=relaxed/relaxed;
	bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUEQH8ZjgBj+JlgVLlpfpmLsu9t2JNBRwfXnMWoaQNogncPuf2gbJFGRDMAbR5m5uXMQGQ8jnZTVu43Kch7JGKSCn5XeV4lEMzt42qBX0XIAkAX6CZAtMTP4LBYpuToQhhCCKjb63Ec55tZ4CChDtKpXtfxwGws1RR7GOaHsZF0yFTV8wgUtuJ5rcx2U5Md7E7Gs+qI31FXKM0UmY8C0rb93iZ8Ziw9QdphtkiGnFe0PZuN5ktRyLeokCqvvPGfwTm49HwQo5qY/1HlexadI8HzHZbODtdsT2r1vYXFkFZ3Gu/ODerK/guzmxQx+SBAN9rf13rMNJgXeZcgr12RTWA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2tYPey3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=jim.cromie@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2tYPey3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com; envelope-from=jim.cromie@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbJHF18TFz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 07:06:32 +1000 (AEST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-7ea16f090b4so91568547b3.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 14:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781125589; cv=none;
        d=google.com; s=arc-20240605;
        b=Zg+BRwo5wFOivmR6OcCKUywzlSGM5Ixln0tIDbO4ZoWeypfgQPlH3N36jc1BStoUYV
         GSG13r+apfTVB98POK6NoXxQ9+Yxi90awzPzzd2TS1ofokDWJoHlInRLzab1R7XoT+x7
         okhsTxcopWlMmupNUy5QAbB82DDABmNFVb7Hxtf2qumFts6TT0ZcYo3Wu8z+FRRO3Dru
         NMBloFFXoWvltI8DcpTOpJ9HPrmwX/C8dgMAWwF8FJNRdhgHP7lJUFPm72krUIF/BO8o
         64txdgTM0fgVyK5qafkRNuaZqaxaY8+/uRMElZ46+Qo/qq8yaxKTLFWQZFr2Fe6wEi3S
         5IsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        fh=bvBki3twTlhAnzZ+dU/VBuikHuIBnyS5KyfgSVUyo4Q=;
        b=WsqGpeNl4xZJLCWRX4sFtTi0EUOsZgY9Jv8A/Cz6F32Vl08Hy6tbYx1eDJlf/axxHF
         vCvA2rRweunf3JWzstygVtLbi1d1xASafH1R438hn96qGvLDMaEItsclafU17/M4gyJF
         /ymPLwJ290EGKSYcjiy08VpIgluBRbwjNRSJ5jKR+K2V/CftFiwJRzPnJJTmcQFM3nMC
         kMI7rllJ39eOmilTAiCYWJtoGI6itzmr4fVMYUwxsKv5ATAZDNiPVYvVLL5q1yAX+ztQ
         oPWvccu+sYt9VWJyRaMWruks9mpiFDMzV7kUn1gW44o8WY5qLL6D/FEycLhGOdiJkREv
         fQOw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781125589; x=1781730389; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=p2tYPey3QuOAOyTHTFs0dfI/YysKpy3L3DeY98YgV+iaMx01FsuCAWJ3rBtI1Y50ZN
         urZPMjJNQw4G0x3ZT21zPmy3uHvr1s1DcVtfdFskEnCNw0EaTx+Ol5Cf+OYY9k3Zz1+B
         iR7lKsucgMRo9WjQGfYI/FuQW/QppYQQxylr8zKDXv3bHg2EvT2MISyT0s/iNeC54m1m
         aXH0ZOoYIe5MkeCIUhEBbTXFByW+Dtzi12QoJGbN4AvqTAX4PQo8kYm0PhzdfYvNOqwk
         5Y1/UMnzGWcRsp9guJy17LZByrjFbGpnxCG74cWmsMrrUwyUyYUpoZBmXfjYJFtXvbG4
         qwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781125589; x=1781730389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96czj6yri6D29TEjjpnrX0Ms962E0G1MVyGNh2o55HQ=;
        b=bRxwhbJTAjhWfhPm8Xwr+ZGWOUUWUBAomEC67zZdpKHpoevkTxzkCC9H4LVdOwg09e
         FOQpoLsJcXtBYwRKyN26XKlh+HZe5+pYrvLMq2HCyMGs06dssrY7uXJzCCy3DcqDEQZB
         lgW1k5Xw/EbP2jwh42nua4tZTHUm7X5zC6NHBkI4f+F/yLaCYz1LSPFSf8fd+881o85R
         iDARCKY3TyZ0iWpZXXStRfhupb70/JrjKpyyWg8ihE5P31lQhKxo/pgfBo2clldreTqb
         SIbR/rNwiwZDqtxmkah8PZJb0AHrd5DhulZ4OZLRCT/nb0NUWp9R+NaSFPP8NMoAtpYQ
         LaUA==
X-Forwarded-Encrypted: i=1; AFNElJ98cK4iybtoXUgSbr55a8mbMEmkjYbelJQu15NzS9s/Ek5o5vwRrOfszlkLleBgkarv4BMvZioAA9P9m14=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwFfQTcAIcK8QOyOVfJE9fQaor4eTwfEnczjjB2BganjLzbOM4w
	ROZHrKUegf8S8G0aQSjFqFkCjfcL26CqYn+GqNQq5W4tQLy4KNW4UZ+gx0AI9lvP1SNFau77Xi4
	VkaAeoJk/U2ob0A7wP21OGJo3+tKxjNg=
X-Gm-Gg: Acq92OFHoT2+RlSEcnhSl/Km/ev6PuXDoyf0GYNPLyEw1ps0Mbl2WFYA2YjD4it7cFX
	mEvetDjinRu25FeVlPiD1f3w7p8TH+nRFBh7VzAFubnyuwcUgqPzI6NeuOBxsCM4BUtPHUl2v8H
	BnC0EXhRRbeMDFkgan1PG8XjaId4h5pMKLXGgf+8cxTCEPKPjdAgNV+2Bu6ksosxysKS2Wc5LcO
	ZGMvPBqi+IATDX3l5iL9HkM7lMnLGiX8TS/V1LbQ7shM96mAfeRrUsHmEnIawa08LVoxzz32T/Y
	1Wr3CXq8YQxIgLw2DV1LIoKwlQ==
X-Received: by 2002:a05:690c:45c5:b0:7e9:ab56:3c99 with SMTP id
 00721157ae682-7ed0adbb616mr276188567b3.6.1781125589039; Wed, 10 Jun 2026
 14:06:29 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260521133315.work.845-kees@kernel.org> <20260521133326.2465264-4-kees@kernel.org>
 <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
In-Reply-To: <da358ae1-91b4-4a16-ac76-ffab99c230b9@suse.com>
From: jim.cromie@gmail.com
Date: Wed, 10 Jun 2026 15:06:02 -0600
X-Gm-Features: AVVi8CcLXClq9Fijm8VjZF47hQWmos5q_iXrehNZDw9kSOby-E_cMxEQI0SK-hU
Message-ID: <CAJfuBxwRuT1K=rjPX+sdNyYurEJ=OjqbJaSa_S6JnY6yzTwTvQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] treewide: Convert struct kernel_param_ops
 initializers to DEFINE_KERNEL_PARAM_OPS
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Kees Cook <kees@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Corey Minyard <corey@minyard.net>, 
	Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Jason Baron <jbaron@akamai.com>, Tiwei Bie <tiwei.btw@antgroup.com>, 
	Benjamin Berg <benjamin.berg@intel.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"David E. Box" <david.e.box@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-modules@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, 
	qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:35=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 5/21/26 3:33 PM, Kees Cook wrote:
> > Using Coccinelle, rewrite every struct kernel_param_ops initializer tha=
t
> > sets .get into a DEFINE_KERNEL_PARAM_OPS-family macro invocation,
> > for example:
> >
> > @@
> > declarer name DEFINE_KERNEL_PARAM_OPS;
> > identifier OPS;
> > expression SET, GET;
> > @@
> > - const struct kernel_param_ops OPS =3D {
> > -       .set =3D SET,
> > -       .get =3D GET,
> > - };
> > + DEFINE_KERNEL_PARAM_OPS(OPS, SET, GET);
> >
> > Using the macro for initialization means future changes can manipulate
> > the struct layout and callback prototypes without having to change ever=
y
> > initializer.
>
> Nit: For consistency, I suggest also converting the few remaining
> kernel_param_ops instances that specify only .set and no .get, such as
> simdisk_param_ops_filename.
>
> --
> Thanks,
> Petr

for the dynamic-debug changes

Reviewed-by: Jim Cromie <jim.cromie@gmail.com>

