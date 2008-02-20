Return-Path: <SRS0=9nXe=TJ=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A91DCDDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 00:17:48 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] 4xx: Fix Haleakala PCIe compatibility problem
	in dts
Date: Wed, 20 Feb 2008 14:16:53 +0100
References: <1203504358-21331-1-git-send-email-sr@denx.de>
	<20080220070119.27dc250d@zod.rchland.ibm.com>
In-Reply-To: <20080220070119.27dc250d@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802201416.54004.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 February 2008, Josh Boyer wrote:
> > Since the 4xx PCIe driver checks for 405ex compatibility, the
> > PCIe interface was not detected as it is currently defined as
> > "405exr" compatible. This patch changes it to "405ex".
> >
> > The 405EX and 405EXr are identical exept that the 2nd PCIe and the
> > 2nd EMAC interfaces are missing.
>
> Does ppc405ex_pciex_core_init need to grow some logic to detect 405ex
> from 405exr and return the correct number of ports then?  It
> unconditionally returns 2 today.

Yes, this could be done. Right now it works because the 405EXr board 
(Haleakala) only instantiates one PCIe device in the dts.

A simple solution would be to just do a PVR check. Would this be acceptable?

Best regards,
Stefan
