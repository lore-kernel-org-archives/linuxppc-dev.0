Return-Path: <timur.tabi@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B8737B70B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 10:12:32 +1000 (EST)
Received: from mail-qy0-f188.google.com (mail-qy0-f188.google.com
	[209.85.221.188]) by ozlabs.org (Postfix) with ESMTP id 4A78DDDF58
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 01:02:52 +1000 (EST)
Received: by qyk26 with SMTP id 26so232820qyk.17
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 08:02:51 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <20090629234035.12475.58493.stgit@localhost.localdomain>
References: <20090629234035.12475.58493.stgit@localhost.localdomain>
Date: Tue, 30 Jun 2009 10:02:49 -0500
Message-ID: <ed82fe3e0906300802h2bcfb651q5f8a37423307e7ff@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix spin_event_timeout() to be robust over
	context switches
From: Timur Tabi <timur@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 29, 2009 at 6:40 PM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Current implementation of spin_event_timeout can be interrupted by an
> IRQ or context switch after testing the condition, but before checking
> the timeout. =A0This can cause the loop to report a timeout when the
> condition actually became true in the middle.
>
> This patch adds one final check of the condition upon exit of the loop
> if the last test of the condition was still false.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Timur Tabi <timur@freescale.com>

Ben, please pick this up for the next rc of 2.6.31.

--=20
Timur Tabi
Linux kernel developer at Freescale
