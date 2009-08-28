Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 82183B7BEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 01:11:10 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 1C8DEDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Aug 2009 01:11:09 +1000 (EST)
Date: Fri, 28 Aug 2009 19:11:04 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] powerpc/qe: Make qe_reset() code path safe for
	repeated invocation
Message-ID: <20090828151104.GA20329@oksana.dev.rtsoft.ru>
References: <20090827173017.GB739@oksana.dev.rtsoft.ru>
	<A4A4F2A7-4F4C-48A9-A598-6BFB0982656A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A4A4F2A7-4F4C-48A9-A598-6BFB0982656A@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2009 at 12:34:50AM -0500, Kumar Gala wrote:
[...]
> >static int qe_sdma_init(void)
> >{
> >	struct sdma __iomem *sdma = &qe_immr->sdma;
> >-	unsigned long sdma_buf_offset;
> >+	static unsigned long sdma_buf_offset;
> >
> >	if (!sdma)
> >		return -ENODEV;
> >
> >	/* allocate 2 internal temporary buffers (512 bytes size each) for
> >	 * the SDMA */
> >- 	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
> >-	if (IS_ERR_VALUE(sdma_buf_offset))
> >-		return -ENOMEM;
> >+	if (!sdma_buf_offset) {
> >+		sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
> >+		if (IS_ERR_VALUE(sdma_buf_offset))
> 
> shouldn't we zero out sdma_buf_offset otherwise if we call this
> again we'll think its set.

Technically, no. If qe_sdma_init() fails, kernel will panic:

void __init qe_reset(void)
{
        ...
        if (qe_sdma_init())
                panic("sdma init failed!");
}

But I see your point, it isn't obvious and may lead to a bug if
we'll decide to not panic later on. Therefore I'd better make the
change.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
