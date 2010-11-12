Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2D24EB712D
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Nov 2010 07:24:32 +1100 (EST)
Date: Fri, 12 Nov 2010 12:24:54 -0800 (PST)
Message-Id: <20101112.122454.48521600.davem@davemloft.net>
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 1/2] ucc_geth: Do not bring the whole IF down when TX
	failure.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20101112140515.GA28223@oksana.dev.rtsoft.ru>
References: <1289570109-8160-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20101112140515.GA28223@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <cbouatmailru@gmail.com>
Date: Fri, 12 Nov 2010 17:05:15 +0300

> On Fri, Nov 12, 2010 at 02:55:08PM +0100, Joakim Tjernlund wrote:
>> ucc_geth_close lacks a cancel_work_sync(&ugeth->timeout_work)
>> to stop any outstanding processing of TX fail. However, one
>> can not call cancel_work_sync without fixing the timeout function
>> otherwise it will deadlock. This patch brings ucc_geth in line with
>> gianfar:
>> 
>> Don't bring the interface down and up, just reinit controller HW
>> and PHY.
>> 
>> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> 
> Looks sane, thanks!
> 
> Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>

Applied.
