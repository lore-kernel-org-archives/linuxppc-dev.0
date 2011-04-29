Return-Path: <bigeasy@linutronix.de>
Message-ID: <4DBAE461.7000307@linutronix.de>
Date: Fri, 29 Apr 2011 18:16:33 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] General device tree irq domain infrastructure
References: <20110428192227.8979.49181.stgit@ponder>
In-Reply-To: <20110428192227.8979.49181.stgit@ponder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Michal Simek <monstr@monstr.eu>, devicetree-discuss@lists.ozlabs.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, hpa@zytor.com,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> I'd really like to get patches 1-4 merged into 2.6.40.  Please test.
> I'm also running through build testing here, and when it's complete
> I'll push it out to a 'devicetree/irq-domain' branch on
> git://git.secretlab.ca/git/linux-2.6

I pulled this, built and booted my x86-dt box and nothing exploded so far.

If you merge Linus' tree then you will get a conflict (sooner or later) in
ioapic_of_irq_map() in arch/x86/kernel/devicetree.c:

-       return io_apic_setup_irq_pin_once(*out_hwirq, cpu_to_node(0), &attr);
  -      if (io_apic_setup_irq_pin(hwirq, cpu_to_node(0), &attr))
++      if (io_apic_setup_irq_pin_once(hwirq, cpu_to_node(0), &attr))

Sebastian
