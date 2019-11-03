Return-Path: <SRS0=PBxl=Y3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C9CA9EB0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Nov 2019 23:40:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5CF21D56
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Nov 2019 23:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPuiMxC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5CF21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 475sqT3LtnzF51J
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Nov 2019 10:40:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="iPuiMxC0"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 475snS5NDVzF4Lq
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Nov 2019 10:38:36 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id s3so12650533ioe.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Nov 2019 15:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wefieWfVXRUmsFQFvnmJ+ImMxYqnpmfAgbzmiqaDkVw=;
 b=iPuiMxC0DxIEHfVnhFcSH1oPop1EawM1Y+X/5CvZcuyNsWF0QalnLJxE3PgZx1XfEo
 Zo/VcoXYpf71GJ0e6K49dz88lyj4jGfeC9AeqXqZ5tjXW77IHZCLBrkev49qIKxvXS+J
 ezbttOo5HVj7h9j+x4TJMlf9MaOVpVxqYI4wsef+v1nM4nV+JbnzyS3SN0VDGKJUOyYV
 auKXpCep7njbi3GdtzmGSHVaWom4OcjPPoYBNDaxiZDou+DV9G4mcav/HFq2N0zici6Y
 5TShkRWuzy9HvEAmWS91TPf83GBwpMWkyUu35T4QqlFJ+DVHnOfihZXyeli4lCThdbmp
 P04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wefieWfVXRUmsFQFvnmJ+ImMxYqnpmfAgbzmiqaDkVw=;
 b=AQEDIpwWdBYzheN0at6oms4ItguXitbHDINS0zQmEgKrWvvI8+5n4nE7SW1OL9b2k9
 g+E+ntfd5PytMnr6Pb7jVjX4FiHJ5n25DKp3glJ7xLDcdRHnT24/aKJa4BSL5jYTAMXL
 gi/CaF5O5Hbh2HSo34AR43/lGBZhhj4JfpS5dfYIOumcWIIMMBN4s0ro3wmPEiuoWmp2
 le3IX7y/U5FJRt1n7vja8rXcOBKXiXILSeBvEsh163jpOn1PGdX3yRicu7xW/vVYBwPN
 9z0kCj34W2ho/SWvJp/nF6Nbxo2s3d3EIdRNqdZcCUs2H/0QFeT7d3/hPzC+XDp8tT69
 1YwQ==
X-Gm-Message-State: APjAAAV+j+ZAjaTaMXMfk9TkDtud6Lg/tzTKH4n+5W72Ia6P8RcoFcKS
 rmir+Kz62+tllPufzYFSyRVAWiTM+Y3eYkuNUlM=
X-Google-Smtp-Source: APXvYqwiK+MZRpUAnFnSJakJwzQcxVUrHRRlILr3AcPOqISHEvMncac1YAGrLNuARG22iDwUYsQFcnicgI7jhfs+KXc=
X-Received: by 2002:a05:6638:928:: with SMTP id
 8mr5239100jak.124.1572824314443; 
 Sun, 03 Nov 2019 15:38:34 -0800 (PST)
MIME-Version: 1.0
References: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
In-Reply-To: <CAG=yYwmQHyp62qKDoiM091iXKs5iP8rNBLs9kc7Wi_PDCgMrbw@mail.gmail.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Mon, 4 Nov 2019 10:38:23 +1100
Message-ID: <CAOSf1CFn7F_3gLk4sCetDd3JGUiTv50=KSqQuicpPkcRZPVKNQ@mail.gmail.com>
Subject: Re: PROBLEM: PCIe Bus Error atleast
To: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>, linux-pci@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Nov 2, 2019 at 5:46 AM Jeffrin Thalakkottoor
<jeffrin@rajagiritech.edu.in> wrote:
>
> hello ,
>
> i found a error message  as the output of "sudo dmesg -l err"
> i have attached related to that in this email.
> i  think i found this in 5.3.8 kernel

Use "uname -a" to get the current kernel version, architecture.

> But i think when i tried again today i could not reproduce it

That's unfortunate, but it might have just been a transient problem.
The log has a pile of these AER errors:

[  283.723848] pcieport 0000:00:1c.5: AER: PCIe Bus Error:
severity=Corrected, type=Data Link Layer, (Transmitter ID)
[  283.723855] pcieport 0000:00:1c.5: AER:   device [8086:9d15] error
status/mask=00001000/00002000
[  283.723859] pcieport 0000:00:1c.5: AER:    [12] Timeout

Which looks like a root port is getting a timeouts while trying to
talk to its downstream device. It's hard to say anything more without
knowing what the downstream device is, or what the system is. If this
is a laptop it might be due to buggy power management, but it might
just be flakey hardware.

Can you provide the full dmesg and the output of lspci -vv?

Oliver
