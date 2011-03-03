Return-Path: <dan.j.williams@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BE6B1007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Mar 2011 07:51:27 +1100 (EST)
Received: by fxm11 with SMTP id 11so1550845fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 03 Mar 2011 12:51:23 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <1299174901-16762-8-git-send-email-iws@ovro.caltech.edu>
References: <1299174901-16762-1-git-send-email-iws@ovro.caltech.edu>
	<1299174901-16762-8-git-send-email-iws@ovro.caltech.edu>
Date: Thu, 3 Mar 2011 12:51:14 -0800
Message-ID: <AANLkTik6G6zh+=-5pJZRWBcQXry=3DUrc=CQ+QNbsSuH@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] fsldma: support async_tx dependencies and
	automatic unmapping
From: Dan Williams <dan.j.williams@intel.com>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Koul, Vinod" <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 3, 2011 at 9:54 AM, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> Previous to this patch, the dma_run_dependencies() function has been
> called while holding desc_lock. This function can call tx_submit() for
> other descriptors, which may try to re-grab the lock. Avoid this by
> moving the descriptors to be cleaned up to a temporary list, and
> dropping the lock before cleanup.
>
> At the same time, add support for automatic unmapping of src and dst
> buffers, as offered by the DMAEngine API.

Unfortunately, this may be a short lived addition as Russell has put
the the kibosh on how the dmaengine api supports dependencies and
automated unmapping [1].  It really needs to be up to the client to
maintain all the mappings until the dma operation is complete.  If we
cross dma mapping domains we need to queisce operations, remap the
buffers and submit the dma to the next channel.  The current approach
of using overlapping mappings is broken on at least ARM v6+ platforms.

So I need to rework how md raid submits dependencies and manages the
dma mapping api, and will most likely end up removing dependency
support from the api as I do not see a clean way for this to be
automated behind the client's back.  Mapping needs to be sole
responsibility of the client.

Other than that this patch looks good.

--
Dan

[1] http://marc.info/?l=linux-raid&m=129407256602759&w=2
