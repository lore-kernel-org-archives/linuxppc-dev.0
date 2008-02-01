Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5820DDDFE7
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 05:40:47 +1100 (EST)
Message-ID: <47A367A2.10706@pobox.com>
Date: Fri, 01 Feb 2008 13:40:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH for 2.6.25 1/2] [NET] ucc_geth: fix module removal
References: <20080201132248.GA1790@localhost.localdomain>
In-Reply-To: <20080201132248.GA1790@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> - uccf should be set to NULL to not double-free memory on
>   subsequent calls;
> - ind_hash_q and group_hash_q lists should be initialized in the
>   probe() function, instead of struct_init() (called by open()),
>   otherwise there will be an oops if ucc_geth_driver removed
>   prior 'ifconfig ethX up';
> - add unregister_netdev();
> - reorder geth_remove() steps.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Hi Li,
> 
> You kinda promised that these two patches would hit 2.6.25... ;-)
> 
> I've rebased the patches so they apply cleanly on the current tree.
> 
> Thanks,
> 
>  drivers/net/ucc_geth.c |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)

applied 1-2
