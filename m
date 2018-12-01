Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E5C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 11:21:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D072220834
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 11:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPWa1whI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D072220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 436TNC6Lm8zDrPQ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 22:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPWa1whI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::541; helo=mail-ed1-x541.google.com;
 envelope-from=richard.weiyang@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DPWa1whI"; 
 dkim-atps=neutral
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 436CLM5XBRzDrSt
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 11:48:40 +1100 (AEDT)
Received: by mail-ed1-x541.google.com with SMTP id x30so6275266edx.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 16:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=EOVAa37zAMd3GHb0E839TjKYefsuUjxDal4HP8U8APQ=;
 b=DPWa1whIB3zZEe3eHcRIMRwtsrJi0uwKBaLKgmDwBIoGxeqwSEuTc0a+mg4I9wP6Qc
 EFaDNehrHeMEFTuGe2WqdwJ+pJY2X9DnUUwQDFaG0iq36WWYHNRjhN2vuOUYmxrQ4a40
 Z/5V5oAvKSsqp3eRvgcxT1BUEygE7vjGXB2fOvaT2HouuLCkWkIbHu3R0W4kOgPNwZ8q
 ft/Gx8j+2y48Ja21AFlZvKaZDa0f2mWFAzlrt2s5Tf4Zmo2N8JTog8eJp/Cqbi9Z6WzI
 kRX7ZxAtZFyjdMGd7XaqoRJ1ZY/AP79qRhmS9FF8m6QbENUE8eTuxIzJ+7N93kyX1n8M
 oD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=EOVAa37zAMd3GHb0E839TjKYefsuUjxDal4HP8U8APQ=;
 b=lh32xzMfGygXGJMX4JNbsAdgZeJgXXl9QMbPkDxlMoIi+CDVhdWa7w5LuFjur9wR03
 BLxswWiSytpK1Z5hz5jls+vi4O1hsocAeclhUru2Aqnbkpql0k4wXYPoiLIgQgvrCUDC
 NVQglrDBqzeL0fVkD7xoBJMz0mJyc67+N1IpNOmQ9wcrf7BEAUn9SzpQ56hb42uFch60
 rITWZyhkPdKP1+h1n0VvgSwYXSX6U+JUma5Lu8nzEm/z2bQGGUc8YDIrpwKv0PH/Acau
 JrnQGVOs7gVQSw6NbNjnu/wwK1yqBsbSB7xzg1bSvN2XslvmOSQdT1fl7PlG3UF/yY67
 E1DA==
X-Gm-Message-State: AA+aEWbHJB0DmYZHm0D3mZFvzs1vHzeL7jQutFA4ckuonTvOcXxw7QwP
 +v9mf7JAHE4my0jbIpis3sU=
X-Google-Smtp-Source: AFSGD/VGLjMN0Luk/CN14wAmma8De03AHIirudWHw6IqgOLMGvAvn6GG8Dv1auuUlHK1yKe2ebjdIQ==
X-Received: by 2002:a50:c2d9:: with SMTP id u25mr7037669edf.280.1543625317384; 
 Fri, 30 Nov 2018 16:48:37 -0800 (PST)
Received: from localhost ([185.92.221.13])
 by smtp.gmail.com with ESMTPSA id o37sm1763205edc.32.2018.11.30.16.48.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 30 Nov 2018 16:48:36 -0800 (PST)
Date: Sat, 1 Dec 2018 00:48:36 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv2 0/4] mm/memory_hotplug: Introduce memory block types
Message-ID: <20181201004836.jr6r3vyenpph3agj@master>
References: <20181130175922.10425-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130175922.10425-1-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Mailman-Approved-At: Sat, 01 Dec 2018 22:14:53 +1100
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: Oscar Salvador <osalvador@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Michal Hocko <mhocko@suse.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>,
 linux-mm@kvack.org, Pavel Tatashin <pavel.tatashin@microsoft.com>,
 Rich Felker <dalias@libc.org>, Arun KS <arunks@codeaurora.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Rashmica Gupta <rashmica.g@gmail.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Paul Mackerras <paulus@samba.org>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-s390@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Logan Gunthorpe <logang@deltatee.com>, x86@kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org, Michal Such??nek <msuchanek@suse.de>,
 Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 "Jan H. Sch??nherr" <jschoenh@amazon.de>, Juergen Gross <jgross@suse.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Rob Herring <robh@kernel.org>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Jonathan Neusch??fer <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>, J??r??me Glisse <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Oscar Salvador <osalvador@suse.de>,
 Tony Luck <tony.luck@intel.com>, Andrew Banman <andrew.banman@hpe.com>,
 Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 30, 2018 at 06:59:18PM +0100, David Hildenbrand wrote:
>This is the second approach, introducing more meaningful memory block
>types and not changing online behavior in the kernel. It is based on
>latest linux-next.
>
>As we found out during dicussion, user space should always handle onlining
>of memory, in any case. However in order to make smart decisions in user
>space about if and how to online memory, we have to export more information
>about memory blocks. This way, we can formulate rules in user space.
>
>One such information is the type of memory block we are talking about.
>This helps to answer some questions like:
>- Does this memory block belong to a DIMM?
>- Can this DIMM theoretically ever be unplugged again?
>- Was this memory added by a balloon driver that will rely on balloon
>  inflation to remove chunks of that memory again? Which zone is advised?
>- Is this special standby memory on s390x that is usually not automatically
>  onlined?
>
>And in short it helps to answer to some extend (excluding zone imbalances)
>- Should I online this memory block?
>- To which zone should I online this memory block?
>... of course special use cases will result in different anwers. But that's
>why user space has control of onlining memory.
>
>More details can be found in Patch 1 and Patch 3.
>Tested on x86 with hotplugged DIMMs. Cross-compiled for PPC and s390x.
>
>
>Example:
>$ udevadm info -q all -a /sys/devices/system/memory/memory0
>	KERNEL=="memory0"
>	SUBSYSTEM=="memory"
>	DRIVER==""
>	ATTR{online}=="1"
>	ATTR{phys_device}=="0"
>	ATTR{phys_index}=="00000000"
>	ATTR{removable}=="0"
>	ATTR{state}=="online"
>	ATTR{type}=="boot"
>	ATTR{valid_zones}=="none"
>$ udevadm info -q all -a /sys/devices/system/memory/memory90
>	KERNEL=="memory90"
>	SUBSYSTEM=="memory"
>	DRIVER==""
>	ATTR{online}=="1"
>	ATTR{phys_device}=="0"
>	ATTR{phys_index}=="0000005a"
>	ATTR{removable}=="1"
>	ATTR{state}=="online"
>	ATTR{type}=="dimm"
>	ATTR{valid_zones}=="Normal"
>
>
>RFC -> RFCv2:
>- Now also taking care of PPC (somehow missed it :/ )
>- Split the series up to some degree (some ideas on how to split up patch 3
>  would be very welcome)
>- Introduce more memory block types. Turns out abstracting too much was
>  rather confusing and not helpful. Properly document them.
>
>Notes:
>- I wanted to convert the enum of types into a named enum but this
>  provoked all kinds of different errors. For now, I am doing it just like
>  the other types (e.g. online_type) we are using in that context.
>- The "removable" property should never have been named like that. It
>  should have been "offlinable". Can we still rename that? E.g. boot memory
>  is sometimes marked as removable ...
>

This make sense to me. Remove usually describe physical hotplug phase,
if I am correct. 

-- 
Wei Yang
Help you, Help me
