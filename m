Return-Path: <benh@kernel.crashing.org>
Subject: Re: MACE DMA problem on Powermac 7300
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Risto Suominen <risto.suominen@gmail.com>
In-Reply-To: <46e1c7760912061436l76b895ebvf27407a08d41aa45@mail.gmail.com>
References: <46e1c7760912061436l76b895ebvf27407a08d41aa45@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Dec 2009 13:03:44 +1100
Message-ID: <1260151424.2249.1.camel@pasglop>
Mime-Version: 1.0
Cc: LinuxPPC-dev <LinuxPPC-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-12-07 at 00:36 +0200, Risto Suominen wrote:
> I post this in hope that somebody could shed some light on how should
> the DMA work in conjunction with the MACE ethernet controller. I find
> difficult to understand why it does not work in my case:
> 
> What happens? First two bytes of a received frame are not what they
> should be in more than 50% of frames. This can be avoided by receiving
> the frame on a word boundary, but with the usual skb_reserve(..., 2)
> (to make the IP header land on word boundary), it won't work.
> 
> So, I can make the driver work by receiving at 0 offset, and then
> moving the data 2 bytes up, before handing it over to upper layers.
> 
> This used to work with a 2.4.27 kernel, obviously the Grand Central
> DBDMA controller can receive on non-word boundaries. Now I have
> 2.6.15.7.
> 
> Any ideas, what could cause this kind of behaviour (and regression)?

Cache coherency bugs in the chipset or HW bugs in DBDMA, we've been
seeing those on/off on those old apple chipsets...

Try forcing a 32 bytes alignment ?

Cheers,
Ben.
