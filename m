Return-Path: <SRS0=vgOh=RJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C78C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 13:09:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07BE20684
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Mar 2019 13:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="cLak+fkR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07BE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DvHP3lxKzDq6N
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Mar 2019 00:09:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="cLak+fkR"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DvCr5GRczDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2019 00:06:30 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id u9so8381397pgo.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Mar 2019 05:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=lYFisdL+emxX/yjhRwvfei8UQc72RGGLjL/HzcIurDc=;
 b=cLak+fkRb0O9N36cRBXR0tIORoqVJxZ7ho2DOkLt9kahJGvAC87zHhp1EhS+FaCI6N
 64Nca7nkQJmc8Ta4Xu5NycVUDhC+r0AdMVUYL3w+51kWq9QtPbdBEF2WaGRHDv03lA3V
 0/b/Rf4n74LhnFC3Kksz+CwFlyn5hivfSwNhTuzAZU7m6SVWyix3v7rS4wyqjjZOlQuX
 zX1kyt/LbnnJgOYR9xb2o+9l5g/v3e371TkOhKxTCH3gTa3ftEUk55v9oRM+IqBC2dUn
 i9j2ihAYu03W9iivIo1u4bpyt44/sSHgVPZS+Sg9DcAbppyJSuoiEyGosF4XIvC4e9Zr
 KhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=lYFisdL+emxX/yjhRwvfei8UQc72RGGLjL/HzcIurDc=;
 b=TfLMzjrE5mae3QdnOqRM257ky6ZVk/iYa6FFsv8pkkx+1JPpDo19WHeoBwdorLWtJV
 9XBSCaOjlUF1Mz7Tfil++SvUudFIQWryARbovoSHgRoIa1LZU/Js/AL9yQbq0RD0wNPD
 eqa/TSjMF6NBmA22jnZWNhuK0CWMslsQXrV/HQcRUT0GsBDfiw1p2jibaz6un/SMBMKE
 fylHKmg6VUFvP1h8fcAf8UeyX8V62t2NHfPOtogSZT6WCsTZGJGF5NeyhqnnaXZlwpsL
 8bZD2xQ/NtYfkVGRprv55iiwwZ4wycgup5KGPrpbxYHvOhFQ+drVQaXMPbRcBwsrAPel
 3bcg==
X-Gm-Message-State: APjAAAUmvqEa1f+MNqaUZVcJQtExjgaCaSJ53Stqgwj9G/81Xh2ySUO4
 QqFChSo6ZYKq2alxObu3UhoCIw==
X-Google-Smtp-Source: APXvYqzAzhlyQEbt3pF4RlErlixy++ggRJiOcUf8oHOCw2kVjZAxkP62zfdXeK2RBjhWPna+/sKHbg==
X-Received: by 2002:a62:4553:: with SMTP id s80mr7069624pfa.141.1551877586275; 
 Wed, 06 Mar 2019 05:06:26 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com.
 [192.55.54.39])
 by smtp.gmail.com with ESMTPSA id h10sm3128992pfo.128.2019.03.06.05.06.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Mar 2019 05:06:25 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id 98357301186; Wed,  6 Mar 2019 16:06:21 +0300 (+03)
Date: Wed, 6 Mar 2019 16:06:21 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
Message-ID: <20190306130621.qrwybv5dpv3bzyym@kshutemo-mobl1>
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com>
 <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com>
 <20190306124453.126d36d8@naga.suse.cz>
 <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df01bf6e-84a1-53fb-bf0c-0957af2f79e1@linux.ibm.com>
User-Agent: NeoMutt/20180716
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
Cc: Jan Kara <jack@suse.cz>, linux-nvdimm@lists.01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux MM <linux-mm@kvack.org>, Oliver <oohall@gmail.com>,
 Ross Zwisler <zwisler@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2019 at 06:15:25PM +0530, Aneesh Kumar K.V wrote:
> On 3/6/19 5:14 PM, Michal Suchánek wrote:
> > On Wed, 06 Mar 2019 14:47:33 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > > Dan Williams <dan.j.williams@intel.com> writes:
> > > 
> > > > On Thu, Feb 28, 2019 at 1:40 AM Oliver <oohall@gmail.com> wrote:
> > > > > 
> > > > > On Thu, Feb 28, 2019 at 7:35 PM Aneesh Kumar K.V
> > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > Also even if the user decided to not use THP, by
> > > echo "never" > transparent_hugepage/enabled , we should continue to map
> > > dax fault using huge page on platforms that can support huge pages.
> > 
> > Is this a good idea?
> > 
> > This knob is there for a reason. In some situations having huge pages
> > can severely impact performance of the system (due to host-guest
> > interaction or whatever) and the ability to really turn off all THP
> > would be important in those cases, right?
> > 
> 
> My understanding was that is not true for dax pages? These are not regular
> memory that got allocated. They are allocated out of /dev/dax/ or
> /dev/pmem*. Do we have a reason not to use hugepages for mapping pages in
> that case?

Yes. Like when you don't want dax to compete for TLB with mission-critical
application (which uses hugetlb for instance).

-- 
 Kirill A. Shutemov
