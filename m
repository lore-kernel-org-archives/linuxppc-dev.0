Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 9C6BBB6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 19:38:59 +1000 (EST)
Message-ID: <4DD4E52F.6040408@suse.de>
Date: Thu, 19 May 2011 11:38:55 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/13] powerpc/e500: Save SPEFCSR in flush_spe_to_thread()
References: <20110517233551.GA3511@schlenkerla.am.freescale.net>
	<DC207279-54AC-41CC-BF21-25181D16A6AB@kernel.crashing.org>
In-Reply-To: <DC207279-54AC-41CC-BF21-25181D16A6AB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2011 08:04 AM, Kumar Gala wrote:
> On May 17, 2011, at 6:35 PM, Scott Wood wrote:
>
>> From: yu liu<yu.liu@freescale.com>
>>
>> giveup_spe() saves the SPE state which is protected by MSR[SPE].
>> However, modifying SPEFSCR does not trap when MSR[SPE]=0.
>> And since SPEFSCR is already saved/restored in _switch(),
>> not all the callers want to save SPEFSCR again.
>> Thus, saving SPEFSCR should not belong to giveup_spe().
>>
>> This patch moves SPEFSCR saving to flush_spe_to_thread(),
>> and cleans up the caller that needs to save SPEFSCR accordingly.
>>
>> Signed-off-by: Liu Yu<yu.liu@freescale.com>
>> Signed-off-by: Scott Wood<scottwood@freescale.com>
>> ---
>> This is a resending of http://patchwork.ozlabs.org/patch/88677/
>>
>> Kumar, please ack to go via kvm.  This is holding up the rest of the SPE
>> patches, which in turn are holding up the MMU patches due to both
>> touching the MSR update code.
>>
>> arch/powerpc/kernel/head_fsl_booke.S |    2 --
>> arch/powerpc/kernel/process.c        |    1 +
>> arch/powerpc/kernel/traps.c          |    5 +----
>> 3 files changed, 2 insertions(+), 6 deletions(-)
> Acked-by: Kumar Gala<galak@kernel.crashing.org>
>
> [ Alex, let me know if you want this via my powerpc.git tree or your kvm tree ]

I'll take them :). Thanks!

Alex
