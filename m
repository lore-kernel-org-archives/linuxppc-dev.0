Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D97A9B7D1D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  4 May 2010 15:13:34 +1000 (EST)
Subject: Re: [PATCH] Fix DEBUG_PAGEALLOC on 603/e300
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Xianghua Xiao <xiaoxianghua@gmail.com>
In-Reply-To: <g2pe6bf505b1005030719r3194c665i61d0c5906e1d1254@mail.gmail.com>
References: <1272493790.24542.109.camel@pasglop>
	<832265.7605.qm@web63002.mail.re1.yahoo.com>
	<g2pe6bf505b1005030719r3194c665i61d0c5906e1d1254@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 04 May 2010 15:13:26 +1000
Message-ID: <1272950006.13814.19.camel@pasglop>
Mime-Version: 1.0
Cc: Maindoor <sanjeevfiles@yahoo.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-05-03 at 09:19 -0500, Xianghua Xiao wrote:

> Ok here is the test result I did this morning, in short with/without
> Ben's patch it will oops if you write to a freed page.

Probably lucky enough that the free_pages() is pushing the stuff out of
the TLB. At least my patch prevents writing to a non-existing hash table
though, thus avoiding memory corruption.

Cheers,
Ben.
