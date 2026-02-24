Return-Path: <linuxppc-dev+bounces-17118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C052F3C9AC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 16:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fL2tJ3xlzz3cVZ;
	Wed, 25 Feb 2026 03:17:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771949832;
	cv=none; b=YPSoOnueQiu1aLyFILpikbsS+/cRp7L22dkFwlH8HMuuwvSHbWlJuWH+GRB9bH89/TpkmN+noMySI8c6XPOK/MejeIrJZIZa9qLHwgitUs0AHiUkaUMH1eoxf587mWyOTT0U5ePsSrnTZnHCpdVsYfyYdGn5jsf8L4ryJAjviKF6+RpkNwsQrRofCmrxztDwoSWvvyNlO//7V9kF/MXaDl/9svWFTGEgLMLS8avsNckvBwOteIG7DlKhnN8vYKVPnKxpSO9quL8Q/pe4BMfpfRwLoxT3aCO6+rUQexUsaeHeUJyV2g3Qnrai0KefZKqSf90/dO/N62XZPjTVPzPVow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771949832; c=relaxed/relaxed;
	bh=NPLGxYtKAl2lhKKNtOfe8iy6bfv+S/34HO6rlrpilBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HByIRgC8+6Xysj1hvKNHCFjmSc17TG1FS5EiboGjYm8eZ/rYkgQuYC1ZEHeQASpcGonO8sRb3S1Cv+/kflUJrQ8CdaMV4iy0VakA8+Kct5ZSlZ9FP+RwaVS6u+qj5zXJOspsF2CW8llOKtbABVS0Insf5Oa9BDqlzhc2fRFKW9m+ZDP84v2SHDu0stQaIdSQvXFutMci3OJxuVdyCv/Bkeqy31RlMv7F//nivQfMxKqwg69rJ5YAJPJaU9SGech8+4gRHP+q6uN3eBQRnMGgFx8ByE3zZNnOZI4p4gE4Fi24WWxrxh/G1PFklHkp6b0zQ8I4VH5skGtvUhgUh65Y3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dE5DsgJe; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dE5DsgJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=nsc@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fL2tH1dXGz3cVK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Feb 2026 03:17:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 176BA6111B;
	Tue, 24 Feb 2026 16:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2CAC116D0;
	Tue, 24 Feb 2026 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771949828;
	bh=SXv8kNok4zxMnc5pPBCN8E77XIiooRBkXlI+BOUS8Dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dE5DsgJe4eWwAhLUkc52afWpncNFQHm3ITfjxXTQs8pZ3HAdZoxX3E9+yw84PuWfc
	 8hv0jBSBocClUd7acb2nBgtY0uf3R+6IJ9CaSBzL6ITcI6T+FBM4oFlesEeJM8ib+K
	 5uZ/5NDfic7g+vqbPRCzSUckWiK+3QDVPDhtTPlOjE84675xU/g2iZz6oR/8YvKW4l
	 4AL1i725kN9lXS1UU2SngsrbrekRgSdTqNC7/UOua/J6J9V+z4azuGI6LX2qWBuTwE
	 SZwRe4f0R4aadCnfUfk4peBnSm5w+WJWSP6gTO15tqNeDIuiLzQBAAPazq1vUyzKiJ
	 dizgCboB6pIOA==
Date: Tue, 24 Feb 2026 17:14:52 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Message-ID: <aZ3OfJJSJgfOb0rJ@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
 <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
 <aZol1Rsa2tX-WNaZ@derry.ads.avm.de>
 <0d70db8d-702b-46ec-a010-298fe6515aab@t-8ch.de>
 <aZyfcDCWOBJJztQ2@levanger>
 <06054e9a-2b7a-4063-98b8-7d6c539e543f@t-8ch.de>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06054e9a-2b7a-4063-98b8-7d6c539e543f@t-8ch.de>

On Mon, Feb 23, 2026 at 10:43:30PM +0100, Thomas Weiﬂschuh wrote:
> On 2026-02-23 19:41:52+0100, Nicolas Schier wrote:
> > On Mon, Feb 23, 2026 at 08:53:29AM +0100, Thomas Weiﬂschuh wrote:
> > > On 2026-02-21 22:38:29+0100, Nicolas Schier wrote:
> > > > On Tue, Jan 13, 2026 at 01:28:59PM +0100, Thomas Weiﬂschuh wrote:
[...]
> > > > [...]
> > > > > diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
> > > > > new file mode 100644
> > > > > index 000000000000..a6ec0e21213b
> > > > > --- /dev/null
> > > > > +++ b/scripts/modules-merkle-tree.c
> > > > > @@ -0,0 +1,467 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * Compute hashes for modules files and build a merkle tree.
> > > > > + *
> > > > > + * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
> > > > > + * Copyright (C) 2025 Thomas Weiﬂschuh <linux@weissschuh.net>
> > > > > + *
> > > > > + */
> > > > > +#define _GNU_SOURCE 1
> > > > > +#include <arpa/inet.h>
> > > > > +#include <err.h>
> > > > > +#include <unistd.h>
> > > > > +#include <fcntl.h>
> > > > > +#include <stdarg.h>
> > > > > +#include <stdio.h>
> > > > > +#include <string.h>
> > > > > +#include <stdbool.h>
> > > > > +#include <stdlib.h>
> > > > > +
> > > > > +#include <sys/stat.h>
> > > > > +#include <sys/mman.h>
> > > > > +
> > > > > +#include <openssl/evp.h>
> > > > > +#include <openssl/err.h>
> > > > > +
> > > > > +#include "ssl-common.h"
> > > > > +
> > > > > +static int hash_size;
> > > > > +static EVP_MD_CTX *ctx;
> > > > > +
> > > > > +struct module_signature {
> > > > > +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> > > > > +	uint8_t		hash;		/* Digest algorithm [0] */
> > > > > +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> > > > > +	uint8_t		signer_len;	/* Length of signer's name [0] */
> > > > > +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> > > > > +	uint8_t		__pad[3];
> > > > > +	uint32_t	sig_len;	/* Length of signature data */
> > > > > +};
> > > > > +
> > > > > +#define PKEY_ID_MERKLE 3
> > > > > +
> > > > > +static const char magic_number[] = "~Module signature appended~\n";
> > > > 
> > > > This here will be the forth definition of struct module_signature,
> > > > increasing the risk of unwanted diversion.  I second Petr's suggestion
> > > > to reuse a _common_ definition instead.
> > > 
> > > Ack.
> > > 
> > > > (Here, even include/linux/module_signature.h could be included itself.)
> > > 
> > > I'd like to avoid including internal headers from other components.
> > > We could move it to an UAPI header. Various other subsystems use those
> > > for not-really-UAPI but still ABI definitions.
> > 
> > Yeah, ack.
> 
> What exactly is the 'ack' for?
> * Avoiding to include internal headers?
> * Moving the definition to UAPI headers?

ah, sorry.  I think reduction of duplicated definitions is good; moving
these definitions to UAPI headers sounds like a valid compromise to me.


> (...)
> 
> > > > Can you verify if I get the mechanics roughly correct?
> > > > 
> > > >   * Modules are merkle tree leaves.  Modules are built and logically
> > > >     paired by the order from modules.order; a single left-over module is
> > > >     paired with itself.
> > > > 
> > > >   * Hashes of paired modules are hashed again (branch node hash);
> > > >     hashes of pairs of branch nodes' hashes are hashed again;
> > > >     repeat until we reach the single merkle tree root hash
> > > > 
> > > >   * The final merkle tree root hash (and the count of tree levels) is
> > > >     included in vmlinux
> > > 
> > > The merkle tree code was written by Sebastian so he will have the best
> > > knowledge about it. But this is also my understanding.
> > 
> > I'd like to see some (rough) description in Documentation or in a commit
> > message at least, otherwise future me will have to ask that again.
> 
> Ack in general. I'd prefer to document it in a source code comment,
> though. That feels like the best fit to me.

Great, thanks.

-- 
Nicolas

