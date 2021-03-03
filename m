Return-Path: <SRS0=PW48=IB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAADC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 17:47:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4057C64EE9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 17:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4057C64EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrLzQ65rtz3cbH
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 04:46:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hEUphPQ9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hEUphPQ9; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrLyz3nJqz30JP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 04:46:35 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E69D64DE8;
 Wed,  3 Mar 2021 17:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614793593;
 bh=zHovqmMgSn4g07KjIGQ3GddG/B+TRQhDfe0NCPpSiOw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hEUphPQ96zB/JRoKj9iukjVpFhvPt4O78R/PYwyDsJJCuX1/CS7JwuaoOEH35BCPO
 PEMEGix9ooCQgp+hbOQENw6SUK1IIm3A+lgyfgp9fpoN7xLENjzuVQ/IUCSakK6oSK
 XQps8gJRFEm9e2XueANVMhnqazwsU74buqS5004WiXZ5wgyPciFIwXLyh5Azi/QItx
 +AesAOBL75e28NostLCcUZSnCgvmKjyQGAU/RK9j0tJTyNqgkCclwj8OXUwZlNE4qe
 JFgAyqC+yZgWr6PSWugGHZKML8mrpCCSajWidxc5wfwh3wy38w9ngkj0ZCq03C4UCi
 gh11pwSWVe6dQ==
Date: Wed, 3 Mar 2021 17:46:28 +0000
From: Will Deacon <will@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/7] cmdline: Add generic function to build command
 line.
Message-ID: <20210303174627.GC19713@willie-the-truck>
References: <cover.1614705851.git.christophe.leroy@csgroup.eu>
 <d8cf7979ad986de45301b39a757c268d9df19f35.1614705851.git.christophe.leroy@csgroup.eu>
 <20210303172810.GA19713@willie-the-truck>
 <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0cfef11-efba-2e5c-6f58-ed63a2c3bfa0@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch@vger.kernel.org, robh@kernel.org,
 daniel@gimpelevich.san-francisco.ca.us, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, danielwa@cisco.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 03, 2021 at 06:38:16PM +0100, Christophe Leroy wrote:
> Le 03/03/2021 à 18:28, Will Deacon a écrit :
> > On Tue, Mar 02, 2021 at 05:25:17PM +0000, Christophe Leroy wrote:
> > > This code provides architectures with a way to build command line
> > > based on what is built in the kernel and what is handed over by the
> > > bootloader, based on selected compile-time options.
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >   include/linux/cmdline.h | 62 +++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 62 insertions(+)
> > >   create mode 100644 include/linux/cmdline.h
> > > 
> > > diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
> > > new file mode 100644
> > > index 000000000000..ae3610bb0ee2
> > > --- /dev/null
> > > +++ b/include/linux/cmdline.h
> > > @@ -0,0 +1,62 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_CMDLINE_H
> > > +#define _LINUX_CMDLINE_H
> > > +
> > > +static __always_inline size_t cmdline_strlen(const char *s)
> > > +{
> > > +	const char *sc;
> > > +
> > > +	for (sc = s; *sc != '\0'; ++sc)
> > > +		; /* nothing */
> > > +	return sc - s;
> > > +}
> > > +
> > > +static __always_inline size_t cmdline_strlcat(char *dest, const char *src, size_t count)
> > > +{
> > > +	size_t dsize = cmdline_strlen(dest);
> > > +	size_t len = cmdline_strlen(src);
> > > +	size_t res = dsize + len;
> > > +
> > > +	/* This would be a bug */
> > > +	if (dsize >= count)
> > > +		return count;
> > > +
> > > +	dest += dsize;
> > > +	count -= dsize;
> > > +	if (len >= count)
> > > +		len = count - 1;
> > > +	memcpy(dest, src, len);
> > > +	dest[len] = 0;
> > > +	return res;
> > > +}
> > 
> > Why are these needed instead of using strlen and strlcat directly?
> 
> Because on powerpc (at least), it will be used in prom_init, it is very
> early in the boot and KASAN shadow memory is not set up yet so calling
> generic string functions would crash the board.

Hmm. We deliberately setup a _really_ early shadow on arm64 for this, can
you not do something similar? Failing that, I think it would be better to
offer the option for an arch to implement cmdline_*, but have then point to
the normal library routines by default.

> > > +/*
> > > + * This function will append a builtin command line to the command
> > > + * line provided by the bootloader. Kconfig options can be used to alter
> > > + * the behavior of this builtin command line.
> > > + * @dest: The destination of the final appended/prepended string.
> > > + * @src: The starting string or NULL if there isn't one. Must not equal dest.
> > > + * @length: the length of dest buffer.
> > > + */
> > > +static __always_inline void cmdline_build(char *dest, const char *src, size_t length)
> > > +{
> > > +	if (length <= 0)
> > > +		return;
> > > +
> > > +	dest[0] = 0;
> > > +
> > > +#ifdef CONFIG_CMDLINE
> > > +	if (IS_ENABLED(CONFIG_CMDLINE_FORCE) || !src || !src[0]) {
> > > +		cmdline_strlcat(dest, CONFIG_CMDLINE, length);
> > > +		return;
> > > +	}
> > > +#endif
> > 
> > CONFIG_CMDLINE_FORCE implies CONFIG_CMDLINE, and even if it didn't,
> > CONFIG_CMDLINE is at worst an empty string. Can you drop the #ifdef?
> 
> Ah yes, since cbe46bd4f510 ("powerpc: remove CONFIG_CMDLINE #ifdef mess") it
> is feasible. I can change that now.
> 
> > 
> > > +	if (dest != src)
> > > +		cmdline_strlcat(dest, src, length);
> > > +#ifdef CONFIG_CMDLINE
> > > +	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) && sizeof(CONFIG_CMDLINE) > 1)
> > > +		cmdline_strlcat(dest, " " CONFIG_CMDLINE, length);
> > > +#endif
> > 
> > Likewise, but also I'm not sure why the sizeof() is required.
> 
> It is to avoid adding a white space at the end of the command line when
> CONFIG_CMDLINE is empty. But maybe it doesn't matter ?

If CONFIG_CMDLINE is empty, I don't think you can select
CONFIG_CMDLINE_EXTEND (but even if you could, I don't think it matters).

Will
