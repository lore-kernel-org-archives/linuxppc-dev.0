Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4CA6AB6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 07:46:10 +1000 (EST)
Message-ID: <4FEA2D93.3030002@freescale.com>
Date: Tue, 26 Jun 2012 16:45:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
 <AB6D43A9-FC54-40D2-A9B0-8B2E785124F9@kernel.crashing.org>
In-Reply-To: <AB6D43A9-FC54-40D2-A9B0-8B2E785124F9@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Zhao Chenhui <chenhui.zhao@freescale.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2012 09:03 AM, Kumar Gala wrote:
> 
> On Jun 26, 2012, at 5:25 AM, Zhao Chenhui wrote:
> 
>> Do hardware timebase sync. Firstly, stop all timebases, and transfer
>> the timebase value of the boot core to the other core. Finally,
>> start all timebases.
>>
>> Only apply to dual-core chips, such as MPC8572, P2020, etc.
>>
>> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> Changes for v6:
>> * added 85xx_TB_SYNC
>> * added isync() after set_tb()
>> * removed extra entries from mpc85xx_smp_guts_ids
> 
> Why only on dual-core chips?  Is this because of something related to
> 2 cores, or related to corenet vs non-corenet SoCs and how turning
> on/off the timebase works in the SOC?

Some parts are due to corenet versus non-corenet, such as the actual
register you write to to disable/enable the timebase.

There's also a two-core assumption in the synchronization code which
I've complained about multiple times -- although on closer inspection it
looks like this is done under cpu_add_remove_lock, and we can assume
that there's only one core at a time in take_timebase(), regardless of
how many cores are in the system.

-Scott
