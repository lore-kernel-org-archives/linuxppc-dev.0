Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3FB38B6F70
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2011 18:29:12 +1100 (EST)
Subject: RE: [PATCH] mlx4_en: fix transmit of packages when blue frame
 isenabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE76@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AE76@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 09 Oct 2011 09:28:51 +0200
Message-ID: <1318145331.29415.372.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
 Eli Cohen <eli@mellanox.co.il>, Eli Cohen <eli@dev.mellanox.co.il>,
 linuxppc-dev@lists.ozlabs.org,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-10-06 at 15:10 +0100, David Laight wrote:
> horrid...
> 1) I'm not sure the caller expects the buffer to be corrupted.
> 2) It contains a lot of memory cycles.
> 3) It looked from the calls that this code is copying descriptors,
>    so the transfer length is probably 1 or 2 words - so the loop
>    is inefficient.
> 4) ppc doesn't have a fast byteswap instruction (very new gcc might
>    use the byteswapping memery access for the le32_to_cpu() though),
>    so it would be better getting the byteswap done inside
>    __iowrite64_copy() - since that is probably requesting a byteswap
>    anyway.
> OTOH I'm not at all clear about the 64bit xfers....

And it's just plain wrong anyway. You should never have to byteswap a
copy.

Ben.
