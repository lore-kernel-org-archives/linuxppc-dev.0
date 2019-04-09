Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08607C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 04:58:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DEAE2084F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 04:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Culiuvlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEAE2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dZmg5NBrzDqHj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 14:58:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=vilhelm.gray@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Culiuvlb"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dZl00PLDzDqGX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 14:56:43 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id k19so8590649pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fSbzNkjsSwkHQttu+TEGQLmXcM0+AN4d0v8/VJDirT0=;
 b=Culiuvlbppghdx3mpcnmXq4pzQXD5BxfSCgJKFEUMLy2pfANurqs3aMveGuAU+//Sd
 C+HkR2TId1a65C+Bo6ktfpH6qtezABxMeWdi3IU4yxdHOMX7CRbwtNVqVQtGFydqlqY7
 J4tA52veE1Z4EaI+8fPOA13dAMVMWacUydP6vlOr0ZFcaDJgDFjZQYFNCevaLZ6D62A/
 tA3Ifbn7eRJHLljSTd4MnV015V0Y+o5bLCLfTqzo4ObooBELVzIPxaTivrRIsWe3PSQu
 29mm7qT0SQn+xhx4bh4fKQ48FF7Z9PTbrFcfy9kHalvV2kkQOxpVOSB1se0uqwyjeovy
 lNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fSbzNkjsSwkHQttu+TEGQLmXcM0+AN4d0v8/VJDirT0=;
 b=MLyce1qPSflCIg0VYexpQv18NyG7kh2//jIlONhQ9LrKkO3OjiUXX+A+krwn+KOzt0
 KZeSZ+Jk/JmEUNcavzIJtqjR9lp77SJXVsEhbc6cSrlJZW8vGB4KhYfhoFCQCIB1ZMz2
 LfoiPnDHFZXDxMKT5Z8ySa/6cGD8UvMRGo440yOijux4mUJuWPx3JTdDivLV0F1BvvJY
 QeOTmEwxlXRWxCHVx4e9MijCcy3vOcbJRoYrSQeUGQAw9stM5lGkjXJAJ5FnbTHERxa6
 gEPPCFFYLncMMNEtLzp2R0ph75w/ayF5bDm6ZZ6q+bV0yS3aVTlLSLh+M2lVlQyEeQIr
 hlGw==
X-Gm-Message-State: APjAAAXCXvLxJZkE4uU4fkAkFi9ZyMzQApo9wwsHKUQnKQM3a0z9KwC7
 p8c4R5K9D2p6URL+Cf1CjCg=
X-Google-Smtp-Source: APXvYqzVtYQ7/TWepFOzztOXYsTBLeJbErgA6c9WPKnHOmXfWudaRv0t8mDaEzmknLvq8tWARXeHxg==
X-Received: by 2002:a63:195e:: with SMTP id 30mr32256554pgz.312.1554785800471; 
 Mon, 08 Apr 2019 21:56:40 -0700 (PDT)
Received: from icarus ([2001:268:c1c0:11e:c70:4af9:86e2:2])
 by smtp.gmail.com with ESMTPSA id c189sm48847177pfg.24.2019.04.08.21.56.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 08 Apr 2019 21:56:39 -0700 (PDT)
Date: Tue, 9 Apr 2019 13:57:28 +0900
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v10 01/18] counter: Introduce the Generic Counter interface
Message-ID: <20190409045728.GA2842@icarus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <ad3a8c427a911848373eae1c08e89353ffb6cb6d.1554184734.git.vilhelm.gray@gmail.com>
 <20190408215515.GA27592@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190408215515.GA27592@amd>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
 thierry.reding@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de,
 daniel.lezcano@linaro.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, david@lechnology.com,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, tglx@linutronix.de,
 fabrice.gasnier@st.com, esben@haabendal.dk, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, knaack.h@gmx.de,
 akpm@linux-foundation.org, shawnguo@kernel.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 08, 2019 at 11:55:15PM +0200, Pavel Machek wrote:
> Hi!
> 
> > +const char *const counter_count_direction_str[2] = {
> > +	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
> > +	[COUNTER_COUNT_DIRECTION_BACKWARD] = "backward"
> > +};
> > +EXPORT_SYMBOL_GPL(counter_count_direction_str);
> > +
> > +const char *const counter_count_mode_str[4] = {
> > +	[COUNTER_COUNT_MODE_NORMAL] = "normal",
> > +	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
> > +	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
> > +	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
> > +};
> > +EXPORT_SYMBOL_GPL(counter_count_mode_str);
> 
> Dunno. Exporting const tables saying "forward" and "backward". Can we
> ... somehow make it work without need to export this?
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

Right now there are only have 4 counter devices supported in this
patchset, but it is expected that support for a greater variety of
devices will be added. For these future cases, new count directions will
be added to match their functionality.

For example, suppose support for a rotary encoder device is added. These
type of devices do not move forward/backward but rather rotate. In these
cases, the following count directions may be added:

    [COUNTER_COUNT_DIRECTION_CLOCKWISE] = "clockwise",
    [COUNTER_COUNT_DIRECTION_COUNTERCLOCKWISE] = "counterclockwise"

Or as another example, suppose support for a two-axis precision
positioning table is added. These devices support positioning in a
cartesian coordinate system. In these cases, spatial direction may serve
as useful count directions:

    [COUNTER_COUNT_DIRECTION_NORTH] = "north",
    [COUNTER_COUNT_DIRECTION_NORTHEAST] = "northeast",
    [COUNTER_COUNT_DIRECTION_EAST] = "east",
    [COUNTER_COUNT_DIRECTION_SOUTHEAST] = "southeast",
    [COUNTER_COUNT_DIRECTION_SOUTH] = "south",
    [COUNTER_COUNT_DIRECTION_SOUTHWEST] = "southwest",
    [COUNTER_COUNT_DIRECTION_WEST] = "west",
    [COUNTER_COUNT_DIRECTION_NORTHWEST] = "northwest"

A const table is conveinent in these scenarios because support for new
count directions may be easily added by simple entry into the table.

William Breathitt Gray
