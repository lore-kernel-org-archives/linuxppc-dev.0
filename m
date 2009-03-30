Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 8C2CBDDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 07:37:01 +1100 (EST)
Date: Mon, 30 Mar 2009 13:36:48 -0700 (PDT)
Message-Id: <20090330.133648.202747210.davem@davemloft.net>
To: Joakim.Tjernlund@transmode.se
Subject: Re: [PATCH] ucc_geth: Move freeing of TX packets to NAPI context.
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF42785A57.F2F3AFE4-ONC1257589.0035B462-C1257589.003712D0@transmode.se>
References: <OF6D5FFE1D.1843C7FE-ONC1257589.00328D91-C1257589.00336B8B@transmode.se>
	<2a27d3730903300236j79cc3035raef2bf5e895fe429@mail.gmail.com>
	<OF42785A57.F2F3AFE4-ONC1257589.0035B462-C1257589.003712D0@transmode.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, pku.leo@gmail.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Mon, 30 Mar 2009 12:01:33 +0200

> I don't know. But the question you should ask is: Does the networking
> code promise this now and for the future? If not, you should
> fix the driver not to relay on netif_queue_stopped() here.

Stop this nonsense talk.

If the driver can't be the one and only controller of the TX queue
state, everything would essentially explode.

The fact is, it does.
