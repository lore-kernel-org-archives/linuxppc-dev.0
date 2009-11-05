Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 639C6B7DD1
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:46:46 +1100 (EST)
Subject: Re: [PATCH 2/8] powerpc/qe&cpm2: Avoid redefinitions in CPM2 and QE
	headers
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091012164916.GB4578@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:46:33 -0600
Message-Id: <DFC8D182-2FAD-4207-8FE0-C25DA04F2432@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164916.GB4578@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
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


On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:

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
