Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8948606E95C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 06:18:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZ8cv2x6Lz2xdY;
	Wed, 25 Nov 2026 17:18:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795587503;
	cv=none; b=FnSirO59lgkAwGx42KUy1vQZLfQPiJHUM9c9n9SFHKf1iEtlFOPGeoA4H4VjbkitNhjPivv+iQdio9rNyJt1+4QCXHJe2EVqPUfHgUgpG6KovF5C7U4j1/LMJLB7nDGkMkmb/Aq+jNzd1umxyYkp7EeR7ddhr34BK1sUA8cw6oNq+YrU9GzR4prFpVRAvxfkbj578pDkSRIIK+TSyf3pQkQp2mWefMCLSQ0s+c+mVDgpHVxY/HtM/Pgj+2LFOXwHesf9zUySi2B3Ni1OFjEp4QxQgjJOutPZ8W0IQNSkk49anzV5IVEYJSeLxoaCVbwP+I3ZPpeopd8sSbjRHeUK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795587503; c=relaxed/relaxed;
	bh=jaN/WIqfszFLrNNj/gphAZn4uRhMsiZROimoWt6zDMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAj+nahoozv4/HF1H+k8zGzwF1G6QJOt4RDhz1az65FeyAAgn9iUlHabuWRwb9NnBTo2VGoJcuQKRO62En3t8YSdnj7Kp1VTDC32iRPIfmQYuZJJLa0KvnmF8kpvl3euqVAEh1NlkTZ/niJM8umvLk3mJbmkMvIHKWOWM5h515wYa0Mmf4HkXRCkr9MuPWUh8bWyqpgO56+/r+if6gxJSCjAhfnzv3W4UXwihL1jZDi1ZKew4nDyUPHPE2VKp1q+62/uozfn2+fviwx/lqdl1bJxiSiuGADZwqOu2fj5CXcy+aipYuXhtBuQnE3IYKqd62Up7TtByUe6RzUzMLnYsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZ8ct1qjMz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 17:18:21 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69A8968AFE; Wed, 25 Nov 2026 07:18:14 +0100 (CET)
Date: Wed, 25 Nov 2026 07:18:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daejun Park <daejun7.park@samsung.com>
Cc: Carlos Maiolino <cem@kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Oliver O'Halloran <oohall@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: (2) [PATCH v2 2/2] xfs: skip the fsync flush when a later
 flush has completed
Message-ID: <20261125061814.GC20968@lst.de>
References: <20261120181706.GB1954@lst.de> <20261111-xfs-fsync-flush-seq-v2-0-b5c00c25d276@samsung.com> <20261111-xfs-fsync-flush-seq-v2-2-b5c00c25d276@samsung.com> <CGME20261120181715epcas2p3fe7b223290792dc835b5dff5374b2cbc@epcms2p7> <20261124023930epcms2p76ee61d14c5333dd04b4466b9f11bbcf8@epcms2p7>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124023930epcms2p76ee61d14c5333dd04b4466b9f11bbcf8@epcms2p7>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 11:39:30AM +0900, Daejun Park wrote:
> > > +	 * DAX writes are not block I/O, so DAX only skips the flush when
> > > +	 * this log force flushed, as before.
> >
> > I don't get the DAX part.  As far as cache flushes are concerned we
> > don't special case DAX anywhere else, why here?
> 
> I was not sure that a flush issued by another CPU covers DAX data on
> powerpc, so I kept the old behaviour for DAX. I never verified that.
> The existing log_flushed skip may already rely on such a flush.

Yeah, if that is an issue on powerpc, xfs and others alredy hit it.
Adding the author and maintainer who signed off on PAPR SCM to clarify
if this is an issue.  Although if it is it probably needs to be worked
around in the driver.


