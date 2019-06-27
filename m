Return-Path: <SRS0=L8Yn=U2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC9CC48BE4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 18:15:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E3D2064A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hf3pUngc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E3D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZSkH1sgTzDqg5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 04:15:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lunn.ch
 (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=lunn.ch header.i=@lunn.ch header.b="Hf3pUngc"; 
 dkim-atps=neutral
X-Greylist: delayed 962 seconds by postgrey-1.36 at bilbo;
 Fri, 28 Jun 2019 04:13:24 AEST
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZSgm6WPtzDqfd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 04:13:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9RWG4ENVqbNHPWygNQrKHZ4t4O/w4lB9Os1ruL2W55s=; b=Hf3pUngcswkLufZiC4kscPXGa4
 wVOgU+VTVnIFqE7iHc59MsMx7YJ85rFLa5Gwxz9NMInPqan8BTfQQAYEKBkAgknd2227Vb+z1gSg7
 CZOA3XUrBf4ctsUvshwULTDLz/cyGZEXTAuyFqwafkrn9ifZiAd+3BYXNDbiv4HKdBfU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1hgYe3-0002RC-JM; Thu, 27 Jun 2019 19:57:15 +0200
Date: Thu, 27 Jun 2019 19:57:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Falcon <tlfalcon@linux.ibm.com>
Subject: Re: [PATCH net] net/ibmvnic: Report last valid speed and duplex
 values to ethtool
Message-ID: <20190627175715.GP27733@lunn.ch>
References: <1561655353-17114-1-git-send-email-tlfalcon@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561655353-17114-1-git-send-email-tlfalcon@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, bjking1@us.ibm.com,
 dnbanerg@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 27, 2019 at 12:09:13PM -0500, Thomas Falcon wrote:
> This patch resolves an issue with sensitive bonding modes
> that require valid speed and duplex settings to function
> properly. Currently, the adapter will report that device
> speed and duplex is unknown if the communication link
> with firmware is unavailable.

Dumb question. If you cannot communicate with the firmware, isn't the
device FUBAR? So setting the LACP port to disabled is the correct
things to do.

       Andrew
