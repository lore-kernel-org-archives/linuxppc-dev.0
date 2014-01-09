Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1E3352C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 07:08:21 +1100 (EST)
Date: Thu, 9 Jan 2014 20:08:01 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH RFC 2/3] ARM: kernel: add support for cpu cache information
Message-ID: <20140109200801.GF27432@n2100.arm.linux.org.uk>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-3-git-send-email-sudeep.holla@arm.com>
 <20140108205754.GN27432@n2100.arm.linux.org.uk> <52CEF9E7.4070706@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52CEF9E7.4070706@arm.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Rob Herring <robh@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Jan 09, 2014 at 07:35:03PM +0000, Sudeep Holla wrote:
> I assume you referring to some particular CPUs which don't implement this.
> I could not find it as optional or IMPLEMENTATION defined in ARM ARM.
> I might be missing to find it or there may be exceptions.
> Can you please provide more information on that ?

This is where _not_ relying on the most up to date ARM architecture
reference manual, but instead referring back to the ARM architecture
manual revision appropriate to the architecture is a far better plan.

For example, DDI0100E, Part B, 2.3.2:

| 2.3.2 Cache Type register
| If present, the Cache Type register supplies the following details about
| the cache:

Note the "if present" - it's a fact that not all ARMv4 CPUs support this
register.  2.3 also tells you how to detect when these registers are
implemented:

| ID registers other than the main ID register are defined so that when
| implemented, their value cannot be equal to that of the main ID register.
| Software can therefore determine whether they exist by reading both
| the main ID register and the desired register and comparing their values.
| If the two values are not equal, the desired register exists.

I can go back further to one of the initial revisions of the ARM ARM,
but that's a paper copy.

I can also refer you to DDI0087E (ARM720T) section 4.3 - this is an
ARMv4T CPU, and it has no cache type register.  StrongARM is another
example where the CTR is not implemented.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
