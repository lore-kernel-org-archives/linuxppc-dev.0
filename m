Return-Path: <SRS0=LC5L=P4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE73C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Nov 2021 22:40:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B769160FDA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Nov 2021 22:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B769160FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpjcV1gJ2z3cQN
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Nov 2021 09:40:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.53; helo=mail-lf1-f53.google.com;
 envelope-from=kswilczynski@gmail.com; receiver=<UNKNOWN>)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hpjbz0D5Sz2yP0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Nov 2021 09:40:14 +1100 (AEDT)
Received: by mail-lf1-f53.google.com with SMTP id f18so1135834lfv.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Nov 2021 14:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SMmGA0UyBNtIe/bJUCzHKc6EzFLQmLHSh4vfSbEgnwQ=;
 b=QYOfIIZgbXmUw8ZyCpwKS+cRhG9ZDlZDaOFnGqczOTfpa3tp9/rA7SsbQ36k0zXAbz
 GSa9Igp18jyQsqkyKiD7M/hGeEOT8t+l7MgIKM+3jQNNV0TWjU6FExYVvckD+PLXrx/G
 /YeayaB+PYX2VnFOK4xue/XiSWrsG3OaZ9D1JXMhXuiPSplQbL9/tbpNrKlRZSgvBg4I
 r7i3RYCxlz+ipG15EOKC9HJqnrkfm4PwjVP7xbOkOcsP0ZbhVG8KnOimpy7F/crpcoUM
 UHnD75kWtaySESeavWIReMSrYNlV/K6k2g8Sjz2oLN6gm+VUQuv3UparALUnNvtyYJz6
 TFgg==
X-Gm-Message-State: AOAM533UAGZz7BwZ+EX68PqNdfelunOk0rNFRE3aOQ0CvMbuT2nK+n1b
 2Po13UUHcfSCYeGIuD5/ENw=
X-Google-Smtp-Source: ABdhPJzDIcYqlgDjAYqusMtGJFzjceKGfVSfm2TrgguYU5jEZWNc5otiC1IjW9b0lP88LvtU1AsfZw==
X-Received: by 2002:a05:6512:3f8b:: with SMTP id
 x11mr10206874lfa.486.1636497609131; 
 Tue, 09 Nov 2021 14:40:09 -0800 (PST)
Received: from rocinante ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id b4sm2264065lft.206.2021.11.09.14.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 14:40:08 -0800 (PST)
Date: Tue, 9 Nov 2021 23:40:07 +0100
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PASEMI] Nemo board doesn't recognize any ATA disks with the
 pci-v5.16 updates
Message-ID: <YYr4x1xWfptXRmqt@rocinante>
References: <ee3884db-da17-39e3-4010-bcc8f878e2f6@xenosoft.de>
 <20211109165848.GA1155989@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211109165848.GA1155989@bhelgaas>
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
Cc: Jens Axboe <axboe@kernel.dk>, Darren Stevens <darren@stevens-zone.net>,
 mad skateman <madskateman@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Olof Johansson <olof@lixom.net>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 "bhelgaas@google.com >> Bjorn Helgaas" <bhelgaas@google.com>,
 Matthew Leaman <matthew@a-eon.biz>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

[+CC Adding Jens and Damien to get their opinion about the problem at hand]

Hello Jens and Damien,

Sorry to bother both of you, but we are having a problem that most
definitely requires someone with an extensive expertise in storage,
as per the quoted message from Christian below:

> > > The Nemo board [1] doesn't recognize any ATA disks with the pci-v5.16
> > > updates [2].
> > >
> > > Error messages:
> > >
> > > ata4.00: gc timeout cmd 0xec
> > > ata4.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > > ata1.00: gc timeout cmd 0xec
> > > ata1.00: failed to IDENTIFY (I/O error, error_mask=0x4)
> > > ata3.00: gc timeout cmd 0xec
> > > ata3.00: failed to IDENTIFY (I/O error, error_mask=0x4)

The error message is also not very detailed and we aren't really sure what
the issue coming from the PCI sub-system might be causing or leading to
this.

> > >
> > > I was able to revert the new pci-v5.16 updates [2]. After a new compiling,
> > > the kernel recognize all ATA disks correctly.
> > >
> > > Could you please check the pci-v5.16 updates [2]?
> > >
> > > Please find attached the kernel config.
> > >
> > > Thanks,
> > > Christian
> > >
> > > [1] https://en.wikipedia.org/wiki/AmigaOne_X1000
> > > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
> 
> Sorry for the breakage, and thank you very much for the report.  Can
> you please collect the complete dmesg logs before and after the
> pci-v5.16 changes and the "sudo lspci -vv" output from before the
> changes?
> 
> You can attach them at https://bugzilla.kernel.org if you don't have
> a better place to put them.
> 
> You could attach the kernel config there, too, since it didn't make it
> to the mailing list (vger may discard them -- see
> http://vger.kernel.org/majordomo-info.html).

Bjorn and I looked at which commits that went with a recent Pull Request
from us might be causing this, but we are a little bit at loss, and were
hoping that you could give us a hand in troubleshooting this.

Thank you in advance!

	Krzysztof


