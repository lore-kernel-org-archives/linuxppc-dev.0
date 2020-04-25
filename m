Return-Path: <SRS0=123t=6J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F9C2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 00:54:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14FA2076C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 00:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rI/BJRTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14FA2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 498CHT1ZgkzDrBm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 10:54:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch
 (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256
 header.s=20171124 header.b=rI/BJRTN; dkim-atps=neutral
X-Greylist: delayed 2560 seconds by postgrey-1.36 at bilbo;
 Sat, 25 Apr 2020 10:53:11 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 498CFg6CRBzDqhF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2020 10:53:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ob1NXBZBB/TdDgKztYA6He/Fk+APvnOylQKu1hMTH+M=; b=rI/BJRTNqVy+NVyd7BqvWiEsXM
 zfrl32AEqeDlsarEfq1yg0fMt8sffr6sdbyHsSN+SfeMte5BPuk0Rc+CFMyErrHWbUlmI3wdIWhS/
 j9ZTN9s39ztp4eEr0jIsZsMB0WrwcsV0NPeLpF+HfPlQG42GozzQ30XM4nZnsIr5At2M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
 (envelope-from <andrew@lunn.ch>)
 id 1jS8Oj-004eAK-TP; Sat, 25 Apr 2020 02:10:21 +0200
Date: Sat, 25 Apr 2020 02:10:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Darren Stevens <darren@stevens-zone.net>
Subject: Re: [RFC PATCH dpss_eth] Don't initialise ports with no PHY
Message-ID: <20200425001021.GB1095011@lunn.ch>
References: <20200424232938.1a85d353@Cyrus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424232938.1a85d353@Cyrus.lan>
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
Cc: oss@buserror.net, netdev@vger.kernel.org, madalin.bacur@nxp.com,
 linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 24, 2020 at 11:29:38PM +0100, Darren Stevens wrote:
> Since cbb961ca271e ("Use random MAC address when none is given")
> Varisys Cyrus P5020 boards have been listing 5 ethernet ports instead of
> the 2 the board has.This is because we were preventing the adding of the
> unused ports by not suppling them a MAC address, which this patch now
> supplies.
> 
> Prevent them from appearing in the net devices list by checking for a
> 'status="disabled"' entry during probe and skipping the port if we find
> it. 

Hi Darren

I'm surprised the core is probing a device which has status disabled.
Are you sure this is the correct explanation?

    Thanks
	Andrew
