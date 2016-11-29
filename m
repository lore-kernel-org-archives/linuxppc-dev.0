Return-Path: <bsingharora@gmail.com>
Subject: Re: [PATCH v3 0/3] powernv:stop: Use psscr_val,mask provided by
 firmware
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
Cc: "\"linuxppc-dev"@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "skiboot\""@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <9bde9678-56cf-a718-7f00-98f0eca45f22@gmail.com>
Date: Tue, 29 Nov 2016 17:34:03 +1100
MIME-Version: 1.0
In-Reply-To: <cover.1478760806.git.ego@linux.vnet.ibm.com>
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
> This is the third iteration of the patchset to use the psscr_val and
> psscr_mask provided by the firmware for each of the stop states.
> 
> The previous version can be found here:
> 
> [v2]: https://lkml.org/lkml/2016/10/27/143
> [v1]: https://lkml.org/lkml/2016/9/29/45
> 
> This version fixes a couple of bugs pertaining to strncpy and
> initialization of the target-residency values of nap and sleep
> which were pointed out by Paul and Oliver in the earlier version.
> 
> Synopsis
> ==========
> In the current implementation, the code for ISA
> v3.0 stop implementation has a couple of shortcomings.
> 
> a) The code hand-codes the values for ESL,EC,TR,MTL bits of PSSCR and
>    uses only the RL field from the firmware. While this is not
>    incorrect, since the hand-coded values are legitimate, it is not a
>    very flexible design since the firmware has the capability to
>    communicate these values via the "ibm,cpu-idle-state-psscr" and
>    "ibm,cpu-idle-state-psscr-mask" properties. In case where the
>    firmware provides values for these fields that is different from
>    the hand-coded values, the current code will not work as intended.
> 
> b) Due to issue a), the current code assumes that ESL=EC=1 for all the
>    stop states and hence the wakeup from the stop instruction will
>    happen at 0x100, the system-reset vector. However, the ISA v3.0
>    allows the ESL=EC=0 behaviour where the corresponding stop-state
>    loses no state and wakes up from the subsequent instruction. The
>    current code doesn't handle this case.
>    

Sounds reasonable

Balbir Singh.
