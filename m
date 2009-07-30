Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3A75AB7B86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 14:17:05 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7BD03DDDA0
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jul 2009 14:17:04 +1000 (EST)
Message-Id: <C6080F55-7EEE-4178-97D5-B5D8D25755B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <cbouatmailru@gmail.com>
In-Reply-To: <20090701173925.GA22134@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: Don't scan for TBI PHY addresses on
	MPC8569E-MDS boards
Date: Wed, 29 Jul 2009 23:16:56 -0500
References: <20090701173925.GA22134@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 1, 2009, at 12:39 PM, Anton Vorontsov wrote:

> Sometimes (e.g. when there are no UEMs attached to a board)
> fsl_pq_mdio_find_free() fails to find a spare address for a TBI PHY,
> this is because get_phy_id() returns bogus 0x0000ffff values
> (0xffffffff is expected), and therefore mdio bus probing fails with
> the following message:
>
>  fsl-pq_mdio: probe of e0082120.mdio failed with error -16
>
> And obviously ethernet doesn't work after this.
>
> This patch solves the problem by adding tbi-phy node into mdio node,
> so that we won't scan for spare addresses, we'll just use a fixed one.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

applied to merge

- k
