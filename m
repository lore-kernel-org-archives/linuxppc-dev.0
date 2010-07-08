Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 78E6BB6EEE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Jul 2010 15:38:34 +1000 (EST)
Received: by gyd10 with SMTP id 10so226938gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 07 Jul 2010 22:38:32 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1278565845.28659.75.camel@pasglop>
References: <181804936ABC2349BE503168465576460F272CA4@exchserver.basler.com>
	<1278565845.28659.75.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 7 Jul 2010 23:38:12 -0600
Message-ID: <AANLkTilNssNdEW3wBKfoUMbSQMFLywfFgGMb0F9XwKeG@mail.gmail.com>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 7, 2010 at 11:10 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2010-06-29 at 11:04 -0500, Steve Deiters wrote:
>> These processors will corrupt data if accessing the local bus with
>> unaligned
>> addresses. This version fixes the typical case of copying from Flash on
>> the
>> local bus by keeping the source address always aligned.
>
> Shouldn't this be solved by using memcpy_to/fromio ?

Maybe.  plain memcpy() access to anything localbus-attached on the
mpc5xxx is the wrong thing to do.  memcpy_to/fromio might do the right
thing; but the caller must understand the limitations of the localplus
bus.  The byte-wise alignment that memcpy_to/fromio() does may not
work (depending on configuration).

Steve, what code is doing a memcpy from flash?

g.
