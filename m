Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1ACFCDE644
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:37:12 +1000 (EST)
Message-ID: <47137B89.6070308@genesi-usa.com>
Date: Mon, 15 Oct 2007 15:39:05 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>	<C2B03958-38CC-4B5C-96C1-E8B5366C4D49@kernel.crashing.org>
	<fa686aa40710150720x6c0ab76hf45d434740d5718f@mail.gmail.com>
In-Reply-To: <fa686aa40710150720x6c0ab76hf45d434740d5718f@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> On 10/15/07, Kumar Gala <galak@kernel.crashing.org> wrote:
>> (Comments just on SRAM code)
>>
>> I think this should be made generic and be utility functionality to
>> rheap.
>>
>> CPM, CPM2, QE, L2 SRAM, etc can all use this.  I'd rather we didn't
>> have 3 ways to do the exact same functionality.  (cpm_dpalloc,
>> cpm_dpfree, qe_muram_alloc, qe_muram_free)
> 
> Fair enough; but not in this patch set.  This series is working
> support for bestcomm.  To go to the more generic level of being used
> by multiple parts should be done in a separate series.

I suggested this a couple months ago and a couple people here said a
generic SRAM driver would be a bad idea.. (even the tsi1xx and Marvell
chips could use a generic SRAM driver)?

Module probe order comes into play, which is why it was a bad idea; how
do you make sure that SRAM and all it's finer points (which may not be
handled by a generic rheap library - after all, the address, size,
alignment needs to be *passed* to rheap init) is there and probed before
bestcomm, qe ethernet units or cryptography, axe on the 5121e, gigabit
on the marvell, deep sleep code on the 5200b (just listing users atm)
or something or other, without turning the drivers into a hard
dependency of the sram subsystem?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
