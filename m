Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzssg0pRPzDqPQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 04:18:15 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b22so4323697pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 09:18:14 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 12 Jan 2017 22:48:02 +0530
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 mark.rutland@arm.com
Subject: Re: [PATCH v5 4/5] powernv: Pass PSSCR value and mask to
 power9_idle_stop
Message-ID: <20170112171802.GB7027@localhost.localdomain>
References: <1484039224-5630-1-git-send-email-ego@linux.vnet.ibm.com>
 <1484039224-5630-5-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484039224-5630-5-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 10, 2017 at 02:37:03PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The arch300_idle_stop method currently takes only the requested stop
      power9_idle_stop (see subject :) and second paragraph)
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
> TR). For the new firmware, the patch will validate that the invariants
> required by the ISA for the psscr values are maintained by the
> firmware.
> 
> This skiboot patch that exports fully populated PSSCR values and the
> mask for all the stop states can be found here:
> https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html
> 
> [Optimize the number of instructions before entering STOP with
> ESL=EC=0, validate the PSSCR values provided by the firimware
> maintains the invariants required as per the ISA suggested by Balbir
> Singh]
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
