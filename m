Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E50D42C02A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:31:13 +1000 (EST)
Message-ID: <1368685863.9603.45.camel@pasglop>
Subject: Re: SATA FSL and upstreaming
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Xie Shaohui-B21989 <B21989@freescale.com>
Date: Thu, 16 May 2013 16:31:03 +1000
In-Reply-To: <ED492CCEAF882048BC2237DE806547C90B1B1801@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <ED492CCEAF882048BC2237DE806547C90B1B1801@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-16 at 06:24 +0000, Xie Shaohui-B21989 wrote:
> Hi, Ben,
> 
> Since the p5020ds you tested is a rev1 chip, I think the most possibility that SATA not work
> is due to a SATA erratum, which is fixed in rev1.1, we have a policy that patches for errata that 
> are present only on early silicon revisions, typically only rev1 silicon will not send upstream.
> You can find the patch at below link:
> http://git.freescale.com/git/cgit.cgi/ppc/sdk/linux.git/commit/?id=b79a8a0528b8a0008cb76f339806b1200b5d8f63

Well, the chip I have is rev1... since I'm the maintainer I might pull a
"Linus" and just apply the damn patch to make it work for me :-) Though
I'm being told that a rev2 chip is on its way to me ... I'll wait a few
more days see if that arrives.

Cheers,
Ben.

> Since it is not sent to upstream, it may need to be rebased if apply it to latest tree.
> 
> Also there might be another issue(SATA & USB) if you test 64 bit kernel on p5020ds with DRR > 4G, we have a patch
> Sent to upstream, but not accepted yet. Link as below:
> http://patchwork.ozlabs.org/patch/179828/
> 
> There are online documents of SDK, for the p5020ds hardware please see the link:
> http://www.freescale.com/infocenter/index.jsp?topic=%2FQORIQSDK%2F2989554.html
> 
> 
> Best Regards, 
> Shaohui Xie
> > -----Original Message-----
> > From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> > Sent: Thursday, May 16, 2013 12:48 PM
> > To: Liu Qiang-B32616; Xie Shaohui-B21989; Fleming Andy-AFLEMING
> > Cc: linuxppc-dev@lists.ozlabs.org; Kumar Gala
> > Subject: SATA FSL and upstreaming
> > 
> > Hi folks !
> > 
> > So I was trying to use my 5020ds to test some stuff today. Since I hadn't
> > used it in a while, I decided to "upgrade" it to the latest NOR etc...
> > 
> > Interestingly I discovered that the SATA (which was supposedly dead on
> > the rev1 chip) was actually working with the SDK kernel, while it's still
> > completely busted upstream.
> > 
> > A quick git compare shows about 5 or 6 commits in the SDK tree, some as
> > old as 2011, fixing various erratas in that chip, that never made their
> > way upstream.
> > 
> > Any reason for that ? Being GPL, I can submit them to Tejun myself but it
> > would be better form if you guys did :-)
> > 
> > BTW. Also what's the status with getting the network working upstream ?
> > Even if sub-standard the code could at least go into staging...
> > 
> > Cheers,
> > Ben.
> > 
> > 
> 
