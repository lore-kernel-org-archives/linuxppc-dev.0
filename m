Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C63C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 05:53:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40B221722
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 05:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJzXJp5D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40B221722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tg0W50RgzF3Qr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 16:53:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="uJzXJp5D";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="uJzXJp5D"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tfww6g7zzF3Vh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 16:50:08 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id f8-v6so3535655pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Nov 2018 21:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RrmL7Du1NbWY/5sS9o08zjGgUgjgtOcnb7Ykw9rbzKE=;
 b=uJzXJp5DBuVrqA9qOfPwdBfl0pOcSJ9gmbVLppKY9ayC5xdujydFpNFFd0axJVVneG
 ueNWDRTuEUCV+5S/mdsKmha3gDfZfn2EqUI7RIcNnyxvmAw5LxuZQfFFhXU4QBmS1dpX
 HhWn+m0KNmYsZq///TgNBxL+VKkZoxuDYha3pFbw8shMTh5HIF4eK7Pwc2HmgdPeYGCi
 dlysU86T6p7V3L6kwi11wIhRiPg2fQI2J9txgKrcgw1JR1Mh/0LPpiPsv4P/SRtiGkBf
 cpx9UiSrEDeKfOsd4yaTuH+iSID0CETMbo1xbBRicY1pAFXYM6ifWphPIZPLfKlhO6X0
 Jhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RrmL7Du1NbWY/5sS9o08zjGgUgjgtOcnb7Ykw9rbzKE=;
 b=f/9LK+dwAYTpZ9vMbMAp2j/d5pMvxSFAA9fM/0uyKZCMt5w6X/ckOmW3ol7pyDXl4P
 cYRMCiHs58pN8clAZ3knGETRJo3uz991xvlOfMTFYQ+QkQk4R000DqpEJTVBqL9dh5OO
 yolxzsewDUIHTkCB69iHYd0/AHlT7x9eWaeZBO+2NBA1wuoOxpcD2cLsC0p38tjBCDcO
 ZQUqDMpb5LIByMWtayWC3rmY8goEqsgahUZAqIRYyFfIeRK0ViPGHBGG69wIGbbI8hkc
 5zyNRSsvM1QxUOIVWt600T+dO9+P55A+cymQdoflPyYCyn/NRXzmlW5nvjHMv5HV2E81
 Ymmw==
X-Gm-Message-State: AGRZ1gI9AoDDUEIDmuXwR72pNuJdp/P3bnyMez4cYjObMdt6JDcpRr2n
 DwVtBxW9BjMk+TLfYh2/s8c=
X-Google-Smtp-Source: AJdET5f1tcOT6q/FlP65O7ElMKcTuljCQhQuCxoFHc7UFMZMe1+BxgLkCcOUz0I+MQTnxIDCJ5UTNQ==
X-Received: by 2002:a63:9402:: with SMTP id m2mr15656255pge.93.1542001806794; 
 Sun, 11 Nov 2018 21:50:06 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id d202sm758911pfd.58.2018.11.11.21.50.01
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 11 Nov 2018 21:50:06 -0800 (PST)
Message-ID: <5da8d8aa9f3818af649b1ac547bc4e6062626ddf.camel@gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
From: Oliver O'Halloran <oohall@gmail.com>
To: Alex_Gagniuc@Dellteam.com, gregkh@linuxfoundation.org
Date: Mon, 12 Nov 2018 16:49:59 +1100
In-Reply-To: <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
References: <20180918221501.13112-1-mr.nuke.me@gmail.com>
 <20181107234257.GC41183@google.com> <20181108200855.GE41183@google.com>
 <20181108220117.GA11466@kroah.com>
 <20181108223258.GD2932@localhost.localdomain>
 <20181108224255.GA20619@kroah.com>
 <20d68e586fff4dcca5616d5056f6fc21@ausx13mps321.AMER.DELL.COM>
 <20181108225109.GA3023@kroah.com>
 <16bf9d14bc5f4a90b2b88dd2eb165186@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
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
Cc: Shyam.Iyer@dell.com, sbobroff@linux.ibm.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, keith.busch@intel.com, lukas@wunner.de,
 helgaas@kernel.org, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, jonathan.derrick@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-08 at 23:06 +0000, Alex_Gagniuc@Dellteam.com wrote:
> On 11/08/2018 04:51 PM, Greg KH wrote:
> > On Thu, Nov 08, 2018 at 10:49:08PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> > > In the case that we're trying to fix, this code executing is a result of
> > > the device being gone, so we can guarantee race-free operation. I agree
> > > that there is a race, in the general case. As far as checking the result
> > > for all F's, that's not an option when firmware crashes the system as a
> > > result of the mmio read/write. It's never pretty when firmware gets
> > > involved.
> > 
> > If you have firmware that crashes the system when you try to read from a
> > PCI device that was hot-removed, that is broken firmware and needs to be
> > fixed.  The kernel can not work around that as again, you will never win
> > that race.
> 
> But it's not the firmware that crashes. It's linux as a result of a 
> fatal error message from the firmware. And we can't fix that because FFS 
> handling requires that the system reboots [1].

Do we know the exact circumsances that result in firmware requesting a
reboot? If it happen on any PCIe error I don't see what we can do to
prevent that beyond masking UEs entirely (are we even allowed to do
that on FFS systems?).

> If we're going to say that we don't want to support FFS because it's a 
> separate code path, and different flow, that's fine. I am myself, not a 
> fan of FFS. But if we're going to continue supporting it, I think we'll 
> continue to have to resolve these sort of unintended consequences.
> 
> Alex
> 
> [1] ACPI 6.2, 18.1 - Hardware Errors and Error Sources

