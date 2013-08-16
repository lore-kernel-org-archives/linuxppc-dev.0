Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E5DA2C0275
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 22:33:27 +1000 (EST)
Message-ID: <1376656351.25016.2.camel@pasglop>
Subject: Re: [RFC PATCH 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Fri, 16 Aug 2013 22:32:31 +1000
In-Reply-To: <520DE753.8090601@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376586580-5409-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376628563.4255.137.camel@pasglop> <520DE753.8090601@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jonas Bonn <jonas@southpole.se>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michal Simek <monstr@monstr.eu>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
 "linux@openrisc.net" <linux@openrisc.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-16 at 09:48 +0100, Sudeep KarkadaNagesha wrote:

> > Naming is a bit gross. You might want to make it clearer that
> > we are talking about CPU IDs in the device-tree here.
> > 
> Any particular preference to the name or just a note is sufficient.
> Also unlike PPC, in ARM we don't set hard processor id value based
> values read from device tree. DT must contain the values matching to the
> hardware ID registers.

This is exactly the same on ppc. We don't "set" HW values. The
device-tree content matches the HW internals. Some processors have a
"PIR" register as well which contains the HW value, in this case the
device-tree must contain the same value as the PIR on that processor.

> >> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
> >> +			const char *prop_name, int cpu, unsigned int *thread)
> >> +{
> >> +	const __be32 *cell;
> >> +	int ac, prop_len, tid;
> >> +	u64 hwid;
> >> +
> >> +	ac = of_n_addr_cells(cpun);
> >> +	cell = of_get_property(cpun, prop_name, &prop_len);
> >> +	if (!cell)
> >> +		return false;
> >> +	prop_len /= sizeof(*cell);
> >> +	for (tid = 0; tid < prop_len; tid++) {
> >> +		hwid = of_read_number(cell, ac);
> >> +		if (arch_match_cpu_phys_id(cpu, hwid)) {
> >> +			if (thread)
> >> +				*thread = tid;
> >> +			return true;
> >> +		}
> > 
> > Missing:          cell += ac;
> Ah, missed it while refactoring, will fix it. Thanks

Ben.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
