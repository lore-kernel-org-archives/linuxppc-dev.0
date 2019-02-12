Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF859C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 07:30:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003012070C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 07:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4dWgYtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003012070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zDnn3RtCzDqPH
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 18:30:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=srs0=5jtu=qt=linuxfoundation.org=gregkh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="g4dWgYtF"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zDlv4GwCzDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 18:28:27 +1100 (AEDT)
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 833762083B;
 Tue, 12 Feb 2019 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549956505;
 bh=+JfyTDTQ7p5u7zNst0aiMSzCg/K44ftDsfjYwEBGeaU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g4dWgYtFpYNEJ0Cf5T6rgUftz5dYoCcYdaZb+yHv1CfvTi2rCyKtMNDWHUBQxad1X
 0WPnA3dVarOMGn7/L8MRo/Wvm2oRsbsuIoOvGUzx3rVnZiP7nQRimRM2d0TG7KmV4F
 GeIpIxDZZLYtvqaOHWXbXJ/mZNBSxS7CjKh1QxkQ=
Date: Tue, 12 Feb 2019 08:28:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Tull <atull@kernel.org>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
Message-ID: <20190212072821.GA2940@kroah.com>
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com>
 <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
 <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
 <20190211191341.GA13134@kroah.com>
 <CANk1AXRnX+=v+7g-_rM3TwNmM3aVcOqRknv9BR+hBOeCtT24Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXRnX+=v+7g-_rM3TwNmM3aVcOqRknv9BR+hBOeCtT24Fg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 linux-fpga@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Moritz Fischer <mdf@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Feb 11, 2019 at 02:43:48PM -0600, Alan Tull wrote:
> On Mon, Feb 11, 2019 at 1:13 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 11, 2019 at 12:41:40PM -0600, Alan Tull wrote:
> > > On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:
> > >
> > > What LTSI's are these patches likely to end up in?  Just to be clear,
> > > I'm not pushing for any specific answer, I just want to know what to
> > > expect.
> >
> > I have no idea what you are asking here.
> >
> > What patches?
> 
> I probably should have asked my question *below* the pertinent context
> of the the 17 patches listed in the pull request, which was:
> 
> >       of: overlay: add tests to validate kfrees from overlay removal
> >       of: overlay: add missing of_node_put() after add new node to changeset
> >       of: overlay: add missing of_node_get() in __of_attach_node_sysfs
> >       powerpc/pseries: add of_node_put() in dlpar_detach_node()
> >       of: overlay: use prop add changeset entry for property in new nodes
> >       of: overlay: do not duplicate properties from overlay for new nodes
> >       of: overlay: reorder fields in struct fragment
> >       of: overlay: validate overlay properties #address-cells and #size-cells
> >       of: overlay: make all pr_debug() and pr_err() messages unique
> >       of: overlay: test case of two fragments adding same node
> >       of: overlay: check prevents multiple fragments add or delete same node
> >       of: overlay: check prevents multiple fragments touching same property
> >       of: unittest: remove unused of_unittest_apply_overlay() argument
> >       of: overlay: set node fields from properties when add new overlay node
> >       of: unittest: allow base devicetree to have symbol metadata
> >       of: unittest: find overlays[] entry by name instead of index
> >       of: unittest: initialize args before calling of_*parse_*()
> 
> > What is "LTSI's"?
> 
> I have recently seen some of devicetree patches being picked up for
> the 4.20 stable-queue.  That seemed to suggest that some, but not all
> of these will end up in the next LTS release.

If the git commit has the "cc: stable@" marking in it, yes, it will be
picked up.  Without the actual git ids, it's hard to know what did, and
what did not, get backported :)

> Also I was wondering if any of this is likely to get backported to
> LTSI-4.14.

Note, "LTSI" and "LTS" are two different things.  "LTSI" is a project
run by some LF member companies, and "LTS" are the normal long term
kernels that I release on kernel.org.  They have vastly different
requirements for inclusion in them.

If you have questions about LTSI, I recommend go asking on their mailing
list.

As for showing up in the 4.14 "LTS" kernel, again, I need git commit ids
to know for sure.

Also, as these are now in Linus's tree, you should be able to look at
the stable releases yourself to see if they are present there, right?

thanks,

greg k-h
