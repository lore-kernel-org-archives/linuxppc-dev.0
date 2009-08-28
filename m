Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 644B2B8080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 15:46:12 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B060ADDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 15:46:11 +1000 (EST)
Message-Id: <4B4F10E3-C09C-4C26-9D42-4CC297021F0F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090818220415.GB25090@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/8] powerpc/qe&cpm2: Avoid redefinitions in CPM2 and QE
	headers
Date: Fri, 28 Aug 2009 00:45:45 -0500
References: <20090818220304.GA23640@oksana.dev.rtsoft.ru>
	<20090818220415.GB25090@oksana.dev.rtsoft.ru>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 18, 2009, at 5:04 PM, Anton Vorontsov wrote:

> struct mcc defined in both immap_qe.h and immap_cpm2.h, so they will
> conflic when included in a single file. The mcc struct is easy to deal
> with, since it isn't used in any driver (yet), so let's just rename QE
> version to qe_mcc.
>
> The ucb_ctlr is a bit trickier, since it is used by fsl_qe_udc driver,
> and the driver supports both CPM and QE UDCs, plus the QE version is
> used to form a bigger immap struct.
>
> I don't want to touch too much of USB code in this series, so for now
> let's just copy most generic version into the common cpm.h header,
> later we'll create cpm_usb.h where we'll place common USB structs that
> are used by QE/CPM UDC and QE Host drivers (FHCI).
>
> And as for the structs in qe.h and cpm2.h, just prefix them with qe_
> and cpm_.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/cpm.h        |   22 ++++++++++++++++++++++
> arch/powerpc/include/asm/immap_cpm2.h |    2 +-
> arch/powerpc/include/asm/immap_qe.h   |    8 ++++----
> 3 files changed, 27 insertions(+), 5 deletions(-)


applied to next

- k
