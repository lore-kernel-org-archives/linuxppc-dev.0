Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 17BB72C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 08:13:53 +1000 (EST)
Message-ID: <1376691186.25016.4.camel@pasglop>
Subject: Re: [RFC PATCH v2 3/4] powerpc: refactor of_get_cpu_node to support
 other architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Date: Sat, 17 Aug 2013 08:13:06 +1000
In-Reply-To: <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1376586580-5409-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376674791-28244-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Jonas Bonn <jonas@southpole.se>, devicetree@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-16 at 18:39 +0100, Sudeep KarkadaNagesha wrote:
> +static bool __of_find_n_match_cpu_property(struct device_node *cpun,
> +                       const char *prop_name, int cpu, unsigned int
> *thread)
> +{
> +       const __be32 *cell;
> +       int ac, prop_len, tid;
> +       u64 hwid;
> +
> +       ac = of_n_addr_cells(cpun);
> +       cell = of_get_property(cpun, prop_name, &prop_len);
> +       if (!cell)
> +               return false;
> +       prop_len /= sizeof(*cell);
> +       for (tid = 0; tid < prop_len; tid++) {
> +               hwid = of_read_number(cell, ac);
> +               if (arch_match_cpu_phys_id(cpu, hwid)) {
> +                       if (thread)
> +                               *thread = tid;
> +                       return true;
> +               }
> +               cell += ac;
> +       }
> +       return false;
> +}

The only problem I can see here is if "ac" is not 1, that will not work
for the ibm,ppc-interrupt-server#s case. IE. The latter is always 1 cell
per entry, only "reg" depends on #address-cells.

However that's only a theorical problem since on ppc #address-cells of
/cpus is always 1...

Cheers,
Ben.
