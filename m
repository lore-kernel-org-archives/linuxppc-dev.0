Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA7C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 22:29:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E962084F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 22:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="gxnGbicq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E962084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44f25x70hdzDqHY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 08:29:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=lechnology.com
 (client-ip=98.142.107.122; helo=vern.gendns.com;
 envelope-from=david@lechnology.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=lechnology.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=lechnology.com header.i=@lechnology.com
 header.b="gxnGbicq"; dkim-atps=neutral
X-Greylist: delayed 1000 seconds by postgrey-1.36 at bilbo;
 Tue, 09 Apr 2019 23:29:52 AEST
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dp7422kWzDqG9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 23:29:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XWViNH1Wxw9uYqCVZQz/ft4Cplusn+KMz/3xhiiHXMY=; b=gxnGbicq2ll7/v2m+YTmEGhEQM
 Ter0pWlqbGSOz5XMmxVWe5lboZfAn7EIv7TWYDAqMjlXqXVCRRYr9kg9xgecdK9K4+mUQK4vtvvGV
 AtD5lwRL2I19cvAh/r+JYzTJL2qNwCuNqP59r8QJBwBZaZ2VsdvyODJEyVi5laIvuBFMGCIcUGeE8
 SKYQSTHIMVaSCkElu/OH5Th9JpzuXe1WF3GSWAt/1/mVCiFZ43YV7ke6YOdsP56ohL6ZaKhQEUyym
 alehLdG37gR83zxezdc93ps0/NJAoWNIyb6YU86ZNgAfBN1uw7ZpAGf7i7kANrVaThSn2YJTiN3lw
 nFzLMdMA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:50018 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1hDqYf-0002Gd-Bw; Tue, 09 Apr 2019 09:13:01 -0400
Subject: Re: [PATCH v10 02/18] counter: Documentation: Add Generic Counter
 sysfs documentation
To: Pavel Machek <pavel@ucw.cz>,
 William Breathitt Gray <vilhelm.gray@gmail.com>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <bd8362f23b99af938c7bced2104eca29888253b3.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215531.GB27592@amd>
From: David Lechner <david@lechnology.com>
Message-ID: <d7a44b77-a8e5-d4fa-9a11-96cdde862b4c@lechnology.com>
Date: Tue, 9 Apr 2019 08:12:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408215531.GB27592@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.ozlabs.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Mailman-Approved-At: Wed, 10 Apr 2019 08:28:14 +1000
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, shawnguo@kernel.org,
 lars@metafoo.de, daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 tglx@linutronix.de, fabrice.gasnier@st.com, esben@haabendal.dk,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 knaack.h@gmx.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/8/19 4:55 PM, Pavel Machek wrote:
> 
> pavel@amd:~$ cat /sys/power/state
> freeze mem disk
> 
> And we use [] to mark current selection:

I know this is used elsewhere, but I don't think it is a good pattern
to copy. Parsing it from user-space is annoying. Also it breaks the
sysfs rule of "one item per file" since it tells us two things - the
list of possible values _and_ the current active value.

> 
> pavel@amd:~$ cat /sys/class/leds/tpacpi\:\:thinkvantage/trigger
> [none] bluetooth-power rfkill-any rfkill-none kbd-scrolllock
> kbd-numlock kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock
> kbd-ctrllock kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock
> kbd-ctrlrlock AC-online BAT0-charging-or-full BAT0-charging BAT0-full
> BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
> phy0radio phy0tpt mmc0 timer heartbeat audio-mute audio-micmute
> rfkill1
> 
> Note this only works if you have less than PAGE_SIZE of entries... and
> will never have more.
> 
> 									Pavel
> 

