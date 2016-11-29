Return-Path: <bsingharora@gmail.com>
Subject: Re: [PATCH v3 1/3] powernv:idle: Add IDLE_STATE_ENTER_SEQ_NORET macro
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <e3af60739710139801505562b4f09d59a1786f65.1478760806.git.ego@linux.vnet.ibm.com>
Cc: "\"linuxppc-dev"@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "skiboot\""@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <de9bf0bb-d188-86f5-86b1-b5931e587b63@gmail.com>
Date: Tue, 29 Nov 2016 21:42:20 +1100
MIME-Version: 1.0
In-Reply-To: <e3af60739710139801505562b4f09d59a1786f65.1478760806.git.ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/11/16 18:54, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently all the low-power idle states are expected to wake up
> at reset vector 0x100. Which is why the macro IDLE_STATE_ENTER_SEQ
> that puts the CPU to an idle state and never returns.
> 
> On ISA_300, when the ESL and EC bits in the PSSCR are zero, the
> CPU is expected to wake up at the next instruction of the idle
> instruction.
> 
> This patch adds a new macro named IDLE_STATE_ENTER_SEQ_NORET for the

I think something like IDLE_STATE_ENTER_SEQ_LOSE_CTX would be better?

> no-return variant and reuses the name IDLE_STATE_ENTER_SEQ
> for a variant that allows resuming operation at the instruction next
> to the idle-instruction.
> 
<snip>
> +
> +#define	IDLE_STATE_ENTER_SEQ_NORET(IDLE_INST)			\
> +	IDLE_STATE_ENTER_SEQ(IDLE_INST)                         \

So we start off with both as the same?

>  	b	.
>  #endif /* CONFIG_PPC_P7_NAP */
<snip>
Balbir
