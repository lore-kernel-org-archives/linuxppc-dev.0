Return-Path: <SRS0=SBso=6B=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D244C352BE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 09:40:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 272BD208E4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 09:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjKdyJ7l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjKdyJ7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 272BD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 493WLG3SlxzDrfd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2020 19:40:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.120;
 helo=us-smtp-1.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=CjKdyJ7l; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CjKdyJ7l; 
 dkim-atps=neutral
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 493WHt5RjpzDqB5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 19:38:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587116327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AS65wi1kZP3VxZRCQZGc81KrRmxUlIH1PUIsognZGTU=;
 b=CjKdyJ7ltbL0Xd+/36TV9XJvzB/8Y/IeWRJmRzcnoVM44zZk5zNJS4RFG5MyRVEojijQ25
 LKsUVF5G5UrOBgw1SchQ6oOiqj+tqNcz1tzMxbakuxY5x+6MAE1XYsCCamKsDE8dg5rwCI
 XUwcEXfdzU8qftI119lljV1Xrw1kgdw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587116327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AS65wi1kZP3VxZRCQZGc81KrRmxUlIH1PUIsognZGTU=;
 b=CjKdyJ7ltbL0Xd+/36TV9XJvzB/8Y/IeWRJmRzcnoVM44zZk5zNJS4RFG5MyRVEojijQ25
 LKsUVF5G5UrOBgw1SchQ6oOiqj+tqNcz1tzMxbakuxY5x+6MAE1XYsCCamKsDE8dg5rwCI
 XUwcEXfdzU8qftI119lljV1Xrw1kgdw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-jRZ7Z6yMPju66oLKcZ9BvA-1; Fri, 17 Apr 2020 05:38:43 -0400
X-MC-Unique: jRZ7Z6yMPju66oLKcZ9BvA-1
Received: by mail-wm1-f71.google.com with SMTP id q5so712726wmc.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2020 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EVkbDn8gkw5+Noos0y5yOQUyWaS8jqC9S0wOjm7uqw4=;
 b=e9wlIKwn4is4lfQQRiFlQtoHX3ko+qjMgXvo3zyn6sxGVjb5rBVa43jE5eWBc3Mc0J
 zhmBNpBp4avS4hoqRup9XRFTvzN9Lolrr2+Rz9jkZfW1SInO0Uo9j2z1MAz82KotOf9+
 vxlCn/UG21YfwnYkzWdgymeq8c3UYfK7fonoQfNtj/1Zp1bXV909a1u4wXXjeAibniAo
 F7lDwIMgfp6+F162oUVsvOifnTJonPI4iBZ8TA8Np/gGA9Id82nh+zk5zctSEcDKpFtk
 cxq1Mi5GLOwCZjANVNbGyHun5PeiTxhS2evXuhtr0kq0z81geh/b7/ng3Vw9c8lGHxzs
 GAdA==
X-Gm-Message-State: AGi0PuabvVaS7Lr6KLqSjIp5y8+gWT8t0DMZ5R9/J/80ZxuuFwa/v2Ta
 6HfgQeTo4iX5xJSCrYyn/o7ReINcZ6Cf6Mxir7jTWjeLKq8Qgy6WRTvtYjtSGyw+mbOwSHN0fM4
 6rCglStzmp+Jn/nzskgeLqiT2RQ==
X-Received: by 2002:adf:e711:: with SMTP id c17mr1264159wrm.334.1587116322164; 
 Fri, 17 Apr 2020 02:38:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypLI0ZplMhJRXp9IgnvDd4jNrwD2zcF2noQBvqCsovqT0NxBwm05qUG6Nsovmh0zi9ATjf9KqA==
X-Received: by 2002:adf:e711:: with SMTP id c17mr1264134wrm.334.1587116321952; 
 Fri, 17 Apr 2020 02:38:41 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id a24sm6912835wmb.24.2020.04.17.02.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 02:38:41 -0700 (PDT)
Date: Fri, 17 Apr 2020 05:38:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
Message-ID: <20200417053803-mutt-send-email-mst@kernel.org>
References: <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
 <20200417022929-mutt-send-email-mst@kernel.org>
 <4274625d-6feb-81b6-5b0a-695229e7c33d@redhat.com>
 <20200417042912-mutt-send-email-mst@kernel.org>
 <fdb555a6-4b8d-15b6-0849-3fe0e0786038@redhat.com>
 <20200417044230-mutt-send-email-mst@kernel.org>
 <73843240-3040-655d-baa9-683341ed4786@redhat.com>
 <20200417050029-mutt-send-email-mst@kernel.org>
 <ce8a18e5-3c74-73cc-57c5-10c40af838a3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ce8a18e5-3c74-73cc-57c5-10c40af838a3@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: linux-s390@vger.kernel.org, tsbogend@alpha.franken.de, gor@linux.ibm.com,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
 linux-mips@vger.kernel.org, virtualization@lists.linux-foundation.org,
 borntraeger@de.ibm.com, geert@linux-m68k.org, netdev@vger.kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 17, 2020 at 05:33:56PM +0800, Jason Wang wrote:
>=20
> On 2020/4/17 =E4=B8=8B=E5=8D=885:01, Michael S. Tsirkin wrote:
> > > There could be some misunderstanding here. I thought it's somehow sim=
ilar: a
> > > CONFIG_VHOST_MENU=3Dy will be left in the defconfigs even if CONFIG_V=
HOST is
> > > not set.
> > >=20
> > > Thanks
> > >=20
> > BTW do entries with no prompt actually appear in defconfig?
> >=20
>=20
> Yes. I can see CONFIG_VHOST_DPN=3Dy after make ARCH=3Dm68k defconfig

You see it in .config right? So that's harmless right?

--=20
MST

