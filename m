Return-Path: <SRS0=bcc2=GX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E97C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 01:47:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC0721D79
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 01:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC0721D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DL7gB6MCHzDqvH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 12:47:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.53; helo=mail-ot1-f53.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DL7cq0Bc9zDqqW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2021 12:44:58 +1100 (AEDT)
Received: by mail-ot1-f53.google.com with SMTP id 36so10343368otp.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2021 17:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4zFLIX6YbpN5aLim6yrRCBFClVwkiMJYaqWYmkOOPrQ=;
 b=iAgPFUwxGoHCALP76RdpHA3sS3EMR44OaLCHYlf39JixMuEdo2dPaf3zzgFZcL/bfz
 cEFFuIn5zDIlEgqVYwo42QbYeoyA6XXaoxMywupPesSCmB+NWqe0eyb8pkj8e5MM/+JN
 sTXLNJHNP8jvrhL2F/FT4FSvAfPh2NgqU0aWAYPjxKepMpB9IHMggwwRqcKPonc+bqWi
 l7kuF61h4Dvvqy9yqE8k5vKqCTa5NyoEeQyyZZbW4pEMHnPs7Tz8jpOV7T4UHMAtk5kh
 fAC+t92cgIJhnye71sdxNwld7wv1uYoEDbzP42TSU1EyQk7CJRb3KwGNSZH1/td4ZF9r
 h4Sg==
X-Gm-Message-State: AOAM530R7nU7jua3OHEtxDTi4+c4wlbO/ViB+TVo3v4dgjemkIX6+J+i
 eSKDeqtlGFfredOr0dBOJA==
X-Google-Smtp-Source: ABdhPJzNzLwDdCRWb7mfJZPjC5yXOTPWn6hRch00Trm6xqHb+giSCQZAzkcjk4lDkIWsGAcxhvOK9g==
X-Received: by 2002:a9d:313:: with SMTP id 19mr5381524otv.147.1611107095736;
 Tue, 19 Jan 2021 17:44:55 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s24sm99037oij.20.2021.01.19.17.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 17:44:54 -0800 (PST)
Received: (nullmailer pid 3016866 invoked by uid 1000);
 Wed, 20 Jan 2021 01:44:53 -0000
Date: Tue, 19 Jan 2021 19:44:53 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: powerpc: Add a schema for the 'sleep'
 property
Message-ID: <20210120014453.GA3706951@robh.at.kernel.org>
References: <20201008142420.2083861-1-robh@kernel.org>
 <752e9355-defb-6d3c-248b-f626247d4cee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <752e9355-defb-6d3c-248b-f626247d4cee@gmail.com>
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
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jan 17, 2021 at 05:10:03PM +0100, Johan Jonker wrote:
> Hi Rob,
> 
> This patch generates notifications in the Rockchip ARM and arm64 tree.
> Could you limit the scope to PowerPC only.
> 
> Kind regards,
> 
> Johan Jonker
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/powerpc/sleep.yaml
> 
> Example:
> 
> /arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dt.yaml: pinctrl:
> sleep: {'ddrio-pwroff': {'rockchip,pins': [[0, 1, 1, 168]]},
> 'ap-pwroff': {'rockchip,pins': [[1, 5, 1, 168]]}} is not of type 'array'
> 	From schema: /Documentation/devicetree/bindings/powerpc/sleep.yaml

IMO, the node name should be changed or just removed. The grouping 
doesn't serve any purpose and changing wouldn't break the ABI.

Rob
