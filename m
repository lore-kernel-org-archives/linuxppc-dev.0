Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 72B10B6FA2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 20:18:10 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 03687-04 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 11:17:59 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] fs_enet: fix freescale FCC ethernet dp buffer alignment
Date: Fri, 17 Jun 2011 11:16:24 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8ADA6@saturn3.aculab.com>
In-Reply-To: <007701cc2cce$42342320$2804000a@yangyong>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <yangyong@neusoft.com>, "Holger Brunck" <holger.brunck@keymile.com>,
	<linuxppc-dev@lists.ozlabs.org>
Cc: netdev@vger.kernel.org, Clive Stubbings <clive.stubbings@xentech.co.uk>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Hello,
> Motioned to the memory aligned, now there is such requirement:
> When the driver send an packet to hardware, the skb's address passed
by
> stack do a dma map into hardware, the skb's dma address must=20
> be 64-byte aligned.

Does the hardware support buffer chaining?
In which case you only need to copy the data upto the first
64 byte boundary into another buffer.

Actually, given that you are likely to have to fixup every
fragment of the frame being transmitted, if might be worth
allocating a fixed transmnit buffer area and copying the
frames into it prior to sending.
Certainly you need to allow for transmits made up of a
significant number of small buffers linked together.

Really you should beat up the hardware designers!

Copying the data to even a 4 byte boundary is almost
always a misaligned copy. Typically this only applies
to the receive dma - when writing a 2 byte pad before
the frame data would be much better.

	David
