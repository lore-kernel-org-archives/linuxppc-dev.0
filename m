Return-Path: <SRS0=nAOP=6W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F0C38A2A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 14:54:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63A5F216FD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2020 14:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63A5F216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49JYJm3x7CzDr2j
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 00:54:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.140; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0140.hostedemail.com
 [216.40.44.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49JYGJ4T8lzDr2c
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2020 00:52:37 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id D2C28100E7B40;
 Fri,  8 May 2020 14:52:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fuel50_505bb413ac133
X-Filterd-Recvd-Size: 2104
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf14.hostedemail.com (Postfix) with ESMTPA;
 Fri,  8 May 2020 14:52:32 +0000 (UTC)
Message-ID: <ff1fcc5b32a9ad209660c7cfe7e212c1a16ba10d.camel@perches.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external
 modules
From: Joe Perches <joe@perches.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, Borislav Petkov <bp@alien8.de>
Date: Fri, 08 May 2020 07:52:30 -0700
In-Reply-To: <87blmy8wm8.fsf@linux.ibm.com>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com>
 <20200508104922.72565-3-vaibhav@linux.ibm.com>
 <20200508113100.GA19436@zn.tnic> <87blmy8wm8.fsf@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2020-05-08 at 17:30 +0530, Vaibhav Jain wrote:
> Hi Boris,
> 
> Borislav Petkov <bp@alien8.de> writes:
> 
> > On Fri, May 08, 2020 at 04:19:19PM +0530, Vaibhav Jain wrote:
> > > 'seq_buf' provides a very useful abstraction for writing to a string
> > > buffer without needing to worry about it over-flowing. However even
> > > though the API has been stable for couple of years now its stills not
> > > exported to external modules limiting its usage.
> > > 
> > > Hence this patch proposes update to 'seq_buf.c' to mark
> > > seq_buf_printf() which is part of the seq_buf API to be exported to
> > > external GPL modules. This symbol will be used in later parts of this
> > 
> > What is "external GPL modules"?
> I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
> here.

Any reason why these Kernel Loadable Modules with MODULE_LICENSE("GPL")
are not in the kernel tree?


