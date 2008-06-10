Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18510.18338.20232.969001@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jun 2008 19:21:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] Prevent loss of interrupts in IB/ehca
In-Reply-To: <200806101021.28795.ossrosch@linux.vnet.ibm.com>
References: <200806091742.29421.ossrosch@linux.vnet.ibm.com>
	<18509.44672.668946.207110@cargo.ozlabs.ibm.com>
	<200806101021.28795.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	OF-EWG <ewg@lists.openfabrics.org>, LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roscher writes:

> The processing of events with a timer controlled polling is not the "typical"
> way how you should handle adapter events.

Do you mean it's not typical in Linux (I would have said it was), or
it's not the way that the firmware architects and implementers thought
the eHEA hcalls would be used?

> During corner case testing, we noticed that some versions of ehca 
> do not properly transition to interrupt done in special load situations.
> This can be resolved by periodically triggering EOI through H_EOI, 
> if eqes are pending.

So in other words, doing the extra EOIs is a workaround for a firmware
and/or hardware bug, then?  If that's the case then you needed to say
that in the commit message.

Given that the ehea driver does hcalls itself directly, and this is a
workaround for a firmware/hardware bug, it may actually be cleaner
just to have the ehea driver do the necessary H_EOI calls directly.

Paul.
