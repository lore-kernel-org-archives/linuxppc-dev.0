Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15B20B7D30
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 29 Apr 2010 08:29:57 +1000 (EST)
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Xianghua Xiao <xiaoxianghua@gmail.com>
In-Reply-To: <y2te6bf505b1004281215n9dcc6190j9915aa27ae91f75d@mail.gmail.com>
References: <1272439375.24542.94.camel@pasglop>
	<y2te6bf505b1004281215n9dcc6190j9915aa27ae91f75d@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 08:29:50 +1000
Message-ID: <1272493790.24542.109.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-04-28 at 14:15 -0500, Xianghua Xiao wrote:
> This change works me on a 834x(e300) platform, tested with lmbench and
> a production-ready application with 2.6.33.3.

But have you tested that DEBUG_PAGEALLOC actually works ? :-)

A way to do that is to

	- get_free_pages a page
	- read from it
	- free it
	- write to it

It should oops on the write, and I suspect that without my patch it
doesn't.

Cheers,
Ben.
