Return-Path: <SRS0=eg2t=WC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF018C31E40
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 22:17:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBB421874
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Aug 2019 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="vO84MS8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBB421874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4638CB72Q6zDr5k
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Aug 2019 08:17:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=netronome.com
 (client-ip=2607:f8b0:4864:20::842; helo=mail-qt1-x842.google.com;
 envelope-from=jakub.kicinski@netronome.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=netronome-com.20150623.gappssmtp.com
 header.i=@netronome-com.20150623.gappssmtp.com header.b="vO84MS8C"; 
 dkim-atps=neutral
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4638993fDDzDqgN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2019 08:15:53 +1000 (AEST)
Received: by mail-qt1-x842.google.com with SMTP id d23so86340720qto.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Aug 2019 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netronome-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :organization:mime-version:content-transfer-encoding;
 bh=yVcWYkkzAVBWRmZ0DK7bYffmU6FU9N6ado8O6IIQho4=;
 b=vO84MS8CKoIJfWDX4UFm0l40mw14mmDz/6H+85o1Fb9uOSVphDCCbHc13po45EP0Z4
 wXdB/QXwJH3g4duppJOSUbE6odymRu/NgH+pr2P+cDLfcXNLuU/uz/Cf2jOvT8vA4c0A
 a9FFcVsZvn+4w5/ujsXsHHsd88fsGa3/cC4dJygHmgsoNqwC1QRTnAFU7Vl7yQeqj/gf
 Z1cHXhkuTYHPmSYBAugMg3Sy43duFm4tWRKDPYsZ41i0N17fYsvd0SVQG+olHNqn9RD4
 wSWSUJNiBbchVH3TlF0hfxCcNymjRPBwN8GOeq0Cmj+0/t7it3MH/FvdWavfIpEYFzwU
 dKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=yVcWYkkzAVBWRmZ0DK7bYffmU6FU9N6ado8O6IIQho4=;
 b=ras2kKV+bMS6krEmM7jfT+Ixu1BF1xS2S5YtoQv7qK4YYDrO7IB1ggiRDkzcnUGVS7
 UPU/HlbHPe6UknzGiogZ0YcAmPh0ScgGgOxhpIVzDXZmbsMBiiWaJDykPELpOl2x9Z4g
 2V7oeh7WHeY9gb9tEx2gE4A5NH2xMIwDgg13Nc0PbIQ6nFKTW5t2U6NslJ2xM5jcc6Qk
 2Hpi8Um1qECQrhzPK+RN9gvOYVKNMwEuK5Bd8TceS8OVSeyihC+0WryUD02Q2cr9L3R7
 ikvCNfwFHDEx+Mbi1kJESVkbCgleB08tAR3zKMYEEt5q25y+MPTZDIYh+kxCp1B97vsG
 lyJg==
X-Gm-Message-State: APjAAAVrbuT4muktGk1eE7/kEG4BLMahsj/QvNRRaEiQH5VTOsbkY0Sh
 Zb6S1Q6CUZOEQtKAJBrzP/ImwA==
X-Google-Smtp-Source: APXvYqzLPLtbPIF/9YqtOwJARgaNU8oLbCzg3y8+Sy9wYHWfic5HgglnBpWrrhOG0EUzqY/ZH5PauA==
X-Received: by 2002:ac8:5547:: with SMTP id o7mr5292130qtr.297.1565129750072; 
 Tue, 06 Aug 2019 15:15:50 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
 by smtp.gmail.com with ESMTPSA id y67sm40298563qkd.40.2019.08.06.15.15.49
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 15:15:49 -0700 (PDT)
Date: Tue, 6 Aug 2019 15:15:24 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net-next v2] ibmveth: Allow users to update reported
 speed and duplex
Message-ID: <20190806151524.69d75f8d@cakuba.netronome.com>
In-Reply-To: <1565108588-17331-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1565108588-17331-1-git-send-email-tlfalcon@linux.ibm.com>
Organization: Netronome Systems, Ltd.
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
Cc: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue,  6 Aug 2019 11:23:08 -0500, Thomas Falcon wrote:
> Reported ethtool link settings for the ibmveth driver are currently
> hardcoded and no longer reflect the actual capabilities of supported
> hardware. There is no interface designed for retrieving this information
> from device firmware nor is there any way to update current settings
> to reflect observed or expected link speeds.
> 
> To avoid breaking existing configurations, retain current values as
> default settings but let users update them to match the expected
> capabilities of underlying hardware if needed. This update would
> allow the use of configurations that rely on certain link speed
> settings, such as LACP. This patch is based on the implementation
> in virtio_net.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>

Looks like this is the third copy of the same code virtio and
netvsc have :(  Is there a chance we could factor this out into
helpers in the core?
