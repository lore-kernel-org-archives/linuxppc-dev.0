Return-Path: <richard.rojfors@mocean-labs.com>
Received: from av9-2-sn2.hy.skanova.net (av9-2-sn2.hy.skanova.net
	[81.228.8.180]) by ozlabs.org (Postfix) with ESMTP id 8D361B7067
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 03:00:50 +1100 (EST)
Message-ID: <4AFAD02F.9080305@mocean-labs.com>
Date: Wed, 11 Nov 2009 15:54:39 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] xilinx_spi: Switch to iomem functions and support
	little endian.
References: <4AFACC6A.304@mocean-labs.com>
	<20091111144924.GG30489@zod.rchland.ibm.com>
In-Reply-To: <20091111144924.GG30489@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Josh Boyer wrote:
> On Wed, Nov 11, 2009 at 03:38:34PM +0100, Richard Röjfors wrote:
>> This patch changes the out_(be)(8|16|32) and in_(be)(8|16|32) calls to iowrite(8|16|32)
>> and ioread(8|16|32). This to be able to build on platforms not supporting the in/out calls
>> for instance x86.
>>
>> Support is also added for little endian writes. In some systems the registers should be
>> accessed little endian rather than big endian.
> 
> I wonder if you should make the endianness a config option.  Right now you
> have a conditional check for every read and write.  Does that impact
> performance at all?

It won't affect the performance noticeable.

In our case we need the possibility to run both endians using the same xilinx_spi module.

--Richard
