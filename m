Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 005C3B70B0
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 01:49:42 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id nABEiOr0024451
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 07:44:24 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	nABEna76244102
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 07:49:36 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id nABEnWJG007191
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2009 07:49:33 -0700
Date: Wed, 11 Nov 2009 09:49:24 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Richard =?iso-8859-1?Q?R=F6jfors?= <richard.rojfors@mocean-labs.com>
Subject: Re: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
Message-ID: <20091111144924.GG30489@zod.rchland.ibm.com>
References: <4AFACC6A.304@mocean-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4AFACC6A.304@mocean-labs.com>
Cc: spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>, dbrownell@users.sourceforge.net,
	John Linn <John.Linn@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 03:38:34PM +0100, Richard Röjfors wrote:
>This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to iowrite(8|16|32)
>and ioread(8|16|32). This to be able to build on platforms not supporting the in/out calls
>for instance x86.
>
>Support is also added for little endian writes. In some systems the registers should be
>accessed little endian rather than big endian.

I wonder if you should make the endianness a config option.  Right now you
have a conditional check for every read and write.  Does that impact
performance at all?

josh
