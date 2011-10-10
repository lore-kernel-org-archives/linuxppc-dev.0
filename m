Return-Path: <eli@dev.mellanox.co.il>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
 [209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 24A15B70B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 20:16:21 +1100 (EST)
Received: by bkbzu17 with SMTP id zu17so7560011bkb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2011 02:16:16 -0700 (PDT)
Date: Mon, 10 Oct 2011 11:16:11 +0200
From: Eli Cohen <eli@dev.mellanox.co.il>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mlx4_en: fix transmit of packages when blue frame is
 enabled
Message-ID: <20111010091611.GN2681@mtldesk30>
References: <1318145118.29415.371.camel@pasglop>
 <AE90C24D6B3A694183C094C60CF0A2F6D8AE78@saturn3.aculab.com>
 <20111010084726.GM2681@mtldesk30>
 <1318237284.29415.422.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318237284.29415.422.camel@pasglop>
Cc: netdev@vger.kernel.org, Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
 Eli Cohen <eli@mellanox.co.il>, David Laight <David.Laight@ACULAB.COM>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2011 at 11:01:24AM +0200, Benjamin Herrenschmidt wrote:
> 
> The case where things get a bit more nasty is when you try to use MMIO
> for low latency small-data type transfers instead of DMA, in which case
> you do want the ability for the chipset to write-combine and control the
> barriers more precisely.
> 
> However, this is hard and Linux doesn't provide very good accessors to
> do so, thus you need to be extra careful (see my example about wmb()
> 
> In the case of the iomap "copy" operations, my problem is that they
> don't properly advertise their lack of ordering since normal iomap does
> have full ordering.
> 
> I believe they should provide ordering with a barrier before & a barrier
> after, eventually with _relaxed variants or _raw variants for those who
> "know what they are doing".

Until then I think we need to have the logic working right on ppc and
measure if blue flame buys us any improvement in ppc. If that's not
the case (e.g because write combining is not working), then maybe we
should avoid using blueflame in ppc.
Could any of the guys from IBM check this and give us feedback?
> 
> Maybe it's time for us to revive those discussions about providing a
> good set of relaxed MMIO accessors with explicit barriers :-)
> 
> Cheers,
> Ben.
>  
