Date: Wed, 26 Sep 2001 12:57:56 -0700
From: Matt Porter <mporter@mvista.com>
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtmsr...
Message-ID: <20010926125756.A28204@cx258813-a.chnd1.az.home.com>
References: <35C119252057D511BB9F0003476BF8A208E5C4@freexc01.smartm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35C119252057D511BB9F0003476BF8A208E5C4@freexc01.smartm.com>; from Siva.Prasad@smartm.com on Wed, Sep 26, 2001 at 03:46:55PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 26, 2001 at 03:46:55PM -0700, Prasad, Siva wrote:
>
> 'PowerBoot' is the firmware I am using.
>
> I preferred to use 2.2.14 because, it has PowerCore option, where I can use
> 750  with minimal changes.
>
> I am not making any calls to firmware after that. This 'mtmsr' instruction
> is third instruction and it hangs with out finishing. What might be the
> problem that I have to fix to get this working.

Force's PowerBoot doesn't properly clean up caches before handing
control over to an external program.  You are probably having
cache problems that we have run into on some COTS Force boards.
I had to disable, flush, reenable L1 icache on the 680/G4, for
example.  linuxppc_2_4_devel's simple bootloader has a specific
CONFIG_PCORE option for this, in fact.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
