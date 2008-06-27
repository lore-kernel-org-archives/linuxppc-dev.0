Return-Path: <nyet@nyet.org>
Received: from curtis.curtisfong.org (curtis.curtisfong.org [66.43.110.51])
	by ozlabs.org (Postfix) with ESMTP id D39BDDDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 08:07:53 +1000 (EST)
Date: Fri, 27 Jun 2008 15:07:49 -0700
From: Nye Liu <nyet@nyet.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] FS_ENET: Don't attempt to set mii_speed when fec_inf
	is null
Message-ID: <20080627220749.GA3046@curtisfong.org>
References: <20080627192651.GA28291@curtisfong.org>
	<48655BAC.8080800@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48655BAC.8080800@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sorry!

diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
index 8a311d1..7359068 100644
--- a/drivers/net/fs_enet/mac-fec.c
+++ b/drivers/net/fs_enet/mac-fec.c
@@ -328,7 +328,8 @@ static void restart(struct net_device *dev)
 	/*
 	 * Set MII speed.
 	 */
-	FW(fecp, mii_speed, fec_inf->mii_speed);
+	if (fec_inf)
+		FW(fecp, mii_speed, fec_inf->mii_speed);
 
 	/*
 	 * Clear any outstanding interrupt.

On Sat, Jun 28, 2008 at 01:29:16AM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Nye Liu wrote:
>> From: Nye Liu <nyet@mrv.com>
>>
>> When using CONFIG_FIXED_PHY, fec_inf (fep->phydev->bus->priv) is NULL in
>> fs_enet/mac-fec.c restart(). Dereferencing fec_inf when trying to set the
>> mii_speed causes a kernel oops.
>>
>> Signed-off-by: Nye Liu <nyet@mrv.com>
>>
>> ---
>>
>> diff --git a/drivers/net/fs_enet/mac-fec.c b/drivers/net/fs_enet/mac-fec.c
>> index 8a311d1..350bc73 100644
>> --- a/drivers/net/fs_enet/mac-fec.c
>> +++ b/drivers/net/fs_enet/mac-fec.c
>> @@ -328,7 +328,8 @@ static void restart(struct net_device *dev)
>>         /*
>>          * Set MII speed.
>>          */
>> -       FW(fecp, mii_speed, fec_inf->mii_speed);
>> +       if (fec_inf)
>> +           FW(fecp, mii_speed, fec_inf->mii_speed);
>>   
>
>   Alas, Your patch is whitespace damaged.
>
>
> WBR, Sergei
>
>
