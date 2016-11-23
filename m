Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Oliver O'Halloran <oohall@gmail.com>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, skiboot@lists.ozlabs.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/3] powernv: Pass PSSCR value and mask to
 power9_idle_stop
In-Reply-To: <f3853e81d3b3a1cf51a920acbbddc8f64238d7b6.1478760806.git.ego@linux.vnet.ibm.com>
References: <cover.1478760806.git.ego@linux.vnet.ibm.com>
 <f3853e81d3b3a1cf51a920acbbddc8f64238d7b6.1478760806.git.ego@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2016 20:51:10 +1100
Message-ID: <87shqittgx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The power9_idle_stop method currently takes only the requested stop
> level as a parameter and picks up the rest of the PSSCR bits from a
> hand-coded macro. This is not a very flexible design, especially when
> the firmware has the capability to communicate the psscr value and the
> mask associated with a particular stop state via device tree.
>
> This patch modifies the power9_idle_stop API to take as parameters the
> PSSCR value and the PSSCR mask corresponding to the stop state that
> needs to be set. These PSSCR value and mask are respectively obtained
> by parsing the "ibm,cpu-idle-state-psscr" and
> "ibm,cpu-idle-state-psscr-mask" fields from the device tree.
>
> In addition to this, the patch adds support for handling stop states
> for which ESL and EC bits in the PSSCR are zero. As per the
> architecture, a wakeup from these stop states resumes execution from
> the subsequent instruction as opposed to waking up at the System
> Vector.
>
> The older firmware sets only the Requested Level (RL) field in the
> psscr and psscr-mask exposed in the device tree. For older firmware
> where psscr-mask=0xf, this patch will set the default sane values that
> the set for for remaining PSSCR fields (i.e PSLL, MTL, ESL, EC, and
> TR).

So we're using psscr-mas=0xf as a signal that we're running on old
firmware.

That's OK I think, but please send a patch to document it in the device
tree binding.

And call it out below in the code.

cheers
