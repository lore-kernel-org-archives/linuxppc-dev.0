Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE56C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 02:45:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDC820879
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 02:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDC820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bS092J9gzDqyk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 13:45:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=osadl.at
 (client-ip=178.115.242.59; helo=mail.osadl.at; envelope-from=hofrat@osadl.at;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=hofr.at
Received: from mail.osadl.at (178.115.242.59.static.drei.at [178.115.242.59])
 by lists.ozlabs.org (Postfix) with ESMTP id 43bRyM6PZWzDqxM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 13:43:53 +1100 (AEDT)
Received: by mail.osadl.at (Postfix, from userid 1001)
 id AE90F5C033D; Fri, 11 Jan 2019 03:43:34 +0100 (CET)
Date: Fri, 11 Jan 2019 03:43:34 +0100
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Message-ID: <20190111024334.GA12140@osadl.at>
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
 <20181222075944.GA26155@osadl.at>
 <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Nicholas Mc Guire <hofrat@osadl.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 01:43:01PM -0600, Li Yang wrote:
> On Sat, Dec 22, 2018 at 2:02 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
> >
> > On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> > > On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > > > devm_kstrdup() may return NULL if internal allocation failed, but
> > > > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > > > can be used here, which will only copy the reference.
> > >
> > > Is it really going to only copy the reference?  That would require that
> > > is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> > > of the kernel image.
> > >
> > I had tried to figure out what is RO and what not but was not
> > able to determine that - from the discussion it seemed that the
> > assumption of RO is correct though I did not ask if it would
> > satisfy is_kernel_rodata() so that explains the incorrect assertion.
> > see https://lkml.org/lkml/2018/12/6/42
> > So then the only option is to check the return and cleanup
> > on allocation failure as the orriginal patch proposed.
> 
> Thanks for the good discussion. I will drop the previous patch. But
> would it also be good to just have "soc_dev_attr.machine = machine"
> directly?
>
I think that the intent is to switch to 
managed devm API so that the cleanup is handled properly
currently you would get "machine" from 
 of_property_read_string_index 
  -> of_property_read_string_helper
   -> of_find_property
which does not do any allocation - so there would actually
not be anything to cleanup here - don´t see why your solution
would not be suitable given the current API. the only advantage
of the devm_kstrdup() is that underlying APIs internal changes
would have no effect.

thx!
hofrat
