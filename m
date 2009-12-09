Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id A1A5CB7BC3
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 10:00:17 +1100 (EST)
Date: Thu, 10 Dec 2009 02:00:15 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Dave Liu <daveliu@freescale.com>
Subject: Re: ucc_geth: Fix the wrong the Rx/Tx FIFO size
Message-ID: <20091209230015.GA13654@oksana.dev.rtsoft.ru>
References: <1259309803-5474-1-git-send-email-daveliu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1259309803-5474-1-git-send-email-daveliu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 27, 2009 at 04:16:43PM +0800, Dave Liu wrote:
> current the Rx/Tx FIFO size settings cause problem
> when four UEC ethernets work simultaneously.
> 
> eg: GETH1, UEM-J15, GETH2, UEC-J5 on 8569MDS board
> 
>  $ ifconfig eth0 10.193.20.166
>  $ ifconfig eth1 10.193.20.167
>  $ ifconfig eth2 10.193.20.168
>  then
>  $ ifconfig eth3 10.193.20.169
> 
> The fourth ethernet will cause all of interface broken,
> you cann't ping successfully any more.
> The patch fix this issue for MPC8569 Rev1.0 and Rev2.0
> 
> Signed-off-by: Dave Liu <daveliu@freescale.com>

Acked-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks Dave! I see that the new values actually match the QEIWRM
spec (except UTFS... spec recommends 2048, but it also says that
it might differ for different memory setups, though that's a
separate issue).

And FWIW, I did some quick netperf tests on MPC8360, and the
patch doesn't cause any problems.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
