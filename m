Return-Path: <tmorrison@empirix.com>
Received: from empbedexfe.empirix.com (empbedexfe.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 3AD0FDDD1C
	for <linuxppc-dev@ozlabs.org>; Wed,  6 May 2009 18:31:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: MSR_SPE - being turned off... 
Date: Wed, 6 May 2009 04:31:58 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010EEBF67D@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90110C30B99@EMPBEDEX.empirix.com>
	<D54110FD-25F0-4A58-9C73-F08D4AE43751@kernel.crashing.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C30D34@EMPBEDEX.empirix.com>
	<13221.1241568099@neuling.org>
	<BD261180E6D35F4D9D32F3E44FD3D90110C94528@EMPBEDEX.empirix.com>
	<B5440F25-74DB-46BB-9374-837441826097@kernel.crashing.org>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,
=20
What about the case of a context switch (i.e.: when things are setup
in registers for the SPE, but then a context switch happens before
the SPE is executed)?=20
=20
As to load_up_spe & give_up_spe, it was pointed out to me tonight by a =
co-worker
to look at how things are saved in those routines, I definitely will =
look at this again,=20
and see how it is done...
=20
This is happening for us on an 8572 SMP. We are trying to get it to =
happen=20
on 8548 (and single core 8572), but we haven't been able to push this =
part=20
of the application as hard as it is being pushed on 8572...but we will =
keep trying....
=20
thank you for your patience and suggestions on this...and I will keep =
working it
=20
Tom=20

________________________________

From: Kumar Gala [mailto:galak@kernel.crashing.org]
Sent: Wed 5/6/2009 12:23 AM
To: Morrison, Tom
Cc: Michael Neuling; linuxppc-dev@ozlabs.org
Subject: Re: MSR_SPE - being turned off...=20




On May 5, 2009, at 7:42 PM, Morrison, Tom wrote:

> The test case we found is under 'extreme' duress
> (intense loading on an MPC8572)...with many applications....
> using A LOT of SPE instructions...
>
> ----
>
> If you look at the context switch code (in latest code entry_32.S),
> I believe the context switch performs a SAVE_NVGPR() - which in our
> interpretation (in ppc_asm.h) - only saves the lower 32 bits of
> the GPR (stw/lwz)...
>
> This is only a guess of where the problem lies - based upon the single
> SPE instruction that seemingly got misinterpreted, and shifts the data
> By '1 byte' (and this code gets executed successfully MANY more times
> at lower bandwidths - than failures seen at higher bandwidths)...
>
> ----
>
> I am not sure how to proceed...we know how to recreate with our
> application, but we would love to know how to change (safely)
> the pt_regs to "long long" for the GPRs and then safely move
> all 64bits of each GPR into these doubles...
>
> We could then re-test and see if this helps?
>
> Tom

If you use SPE in an application the full 64-bits are saved and=20
restored it just split into two locations (one for the lower 32-bits=20
and one for the upper 32-bits).

Look at load_up_spe and giveup_spe in arch/powerpc/kernel/
head_fsl_booke.S

On the 8572 are you running w/SMP?  What kernel version are you using=20
if so?  Do you see the same issue on the MPC8548?

- k
