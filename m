Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2AC32DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 06:46:31 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: u-boot@lists.denx.de
Subject: Re: [U-Boot] ppc4xx: u-boot sees PCIe endpoint, linux does not.
Date: Mon, 1 Dec 2008 20:46:22 +0100
References: <c384c5ea0811280450t3e199da6s1fcdf903f63f9622@mail.gmail.com>
	<1228119152.7356.118.camel@pasglop>
	<c384c5ea0812011119o97adf68l1546c96d5a6696a8@mail.gmail.com>
In-Reply-To: <c384c5ea0812011119o97adf68l1546c96d5a6696a8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812012046.22247.sr@denx.de>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 01 December 2008, Leon Woestenberg wrote:
> >> Now, if I re-program the end-point FPGA during the u-boot boot
> >> time-out, Linux will recognize the end-point.
> >
> > It's possible that either the reset in between goes bonkers or something
> > else causes your FPGA to stop responding. It looks like a programming
> > problem with the FPGA to me.
>
> I have verified that the end point does not receive any kind of reset.
>
> Also, this problem only happens on the Canyonlands board; on x86 and
> powerpc MPC8315E it remains properly working after soft/hard resets,
> u-boot init etc.

This could be because only the 4xx Linux PCI(e) driver really resets the 
endpoint (PHY reset). But you seem to have analyzed this already.

> Could it be u-boot overwrites a too large payload into the config
> space or something similar, which makes subsequent accesses fail?

Not sure. I suggest that you disable the PCI(e) support in U-Boot to see if 
Linux behaves differently on a non-pre-initialized endpoint.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
