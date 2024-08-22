Return-Path: <linuxppc-dev+bounces-343-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109C2C3DA4A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Aug 2024 10:01:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqJdD4NC4z2yQG;
	Thu, 22 Aug 2024 20:01:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=63.228.1.57
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WqJd90GWhz2yPM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2024 20:01:32 +1000 (AEST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47M9rgcZ003432;
	Thu, 22 Aug 2024 04:54:03 -0500
Message-ID: <8c7980d11a2141a90669b063ce8569736e4675ae.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>,
        LEROY Christophe
	 <christophe.leroy2@cs-soprasteria.com>
Cc: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
        Paul
 Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan
 Johnson <userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>
Date: Thu, 22 Aug 2024 19:53:42 +1000
In-Reply-To: <20240822071443.GA6395@lst.de>
References: 
	<2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
	 <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de>
	 <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com>
	 <20240822053238.GA2028@lst.de>
	 <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
	 <20240822071443.GA6395@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 09:14 +0200, Christoph Hellwig wrote:
>=20
> I'd suggest two things:
>=20
> =C2=A01) remove the warning.=C2=A0 The use case is perfectly valid and ev=
erything
> =C2=A0=C2=A0=C2=A0 using uncached memory is already slow, so people will =
just have to
> =C2=A0=C2=A0=C2=A0 deal with it.=C2=A0 Maybe offer a trace point instead =
if people care about
> =C2=A0=C2=A0=C2=A0 it.

Well... there's slow and extremely slow .. :-) dcbz() on uncached
memory will take an exception for every "cache line" of zeros which
will then need to be emulated. We are talking about hundreds to
thousands of cycle per cache line.=20

(Do we have an optimisation to detect memset in the emulation code and
force it to return to a non-dcbz'ing version ? If not, that's doable
and would at least limit it to one exception per memset() instead of
one per cache-line).=20

Cheers,
Ben.

