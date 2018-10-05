Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E299C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:12:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD842064E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD842064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RLXx5Zr4zF3Mv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:12:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.221.66; helo=mail-wr1-f66.google.com;
 envelope-from=osalvador.vilardaga@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=techadventures.net
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RLTH5SPszF3Qn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:08:51 +1000 (AEST)
Received: by mail-wr1-f66.google.com with SMTP id e4-v6so12413359wrs.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Oct 2018 00:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KqQzeVZYtmVkFZOaqknZA3xIVwZZa1gZvkCWFceOmmo=;
 b=i9WxLUvPhFL29w9qqwFboXlNDXp3Mv1H4wZm/2PTRaex88v1bQmXnq5BbMm8IJa4u1
 1CPJqXK0uhlx32mcTF0LiaGEucDguLmylB8nEr+pNrl2O9x6SJnOHy4xyValltV1i5H9
 rnlIYE6Xu9hd1UVX09++7kEOkQLcXERdY9PQBzYeHU078w8GBcJUm+q3tpzpbJebiCZj
 xKStyyY/nw1N8G07xpvc7Ers5y30Fsjqwi7Yu3gyAgBXsSrwRtE8Kle39b3MH3nCujNN
 6ZMyhp4wT1ZvfHFUGnbuN5xfKw8Z8hlda7SLNVK3oCnn/uauawRN1e5nByatpSgrCef2
 /SRg==
X-Gm-Message-State: ABuFfog4esfYKiYWEbEHvsgVOMhVC+Zw5kZzl8V2RH96KdxvydY28wuy
 bzNmGqRt0uiPSDoUuygxRW8=
X-Google-Smtp-Source: ACcGV616tnx56WJhiIzmz9oIWdZhcimyd3YS7JE3nmf5t+adonBlGtww9uMP29FazXKwUQBOXjm+cg==
X-Received: by 2002:adf:dd4c:: with SMTP id u12-v6mr6959548wrm.2.1538723328611; 
 Fri, 05 Oct 2018 00:08:48 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
 by smtp.gmail.com with ESMTPSA id r134-v6sm1172743wmg.9.2018.10.05.00.08.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Oct 2018 00:08:47 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
 id 53B0D125824; Fri,  5 Oct 2018 09:08:47 +0200 (CEST)
Date: Fri, 5 Oct 2018 09:08:47 +0200
From: Oscar Salvador <osalvador@techadventures.net>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 6/6] memory-hotplug.txt: Add some details about
 locking internals
Message-ID: <20181005070847.GB27754@techadventures.net>
References: <20180927092554.13567-1-david@redhat.com>
 <20180927092554.13567-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927092554.13567-7-david@redhat.com>
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
Cc: Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@suse.com>,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, devel@linuxdriverproject.org,
 xen-devel@lists.xenproject.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 27, 2018 at 11:25:54AM +0200, David Hildenbrand wrote:
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
