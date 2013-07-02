Return-Path: <Vineet.Gupta1@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v2] of: Specify initrd location using 64-bit
Date: Tue, 2 Jul 2013 04:17:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075137087@IN01WEMBXA.internal.synopsys.com>
References: <1372702835-5333-1-git-send-email-santosh.shilimkar@ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 Aurelien Jacquiot <a-jacquiot@ti.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paul Mackerras <paulus@samba.org>, Jonas Bonn <jonas@southpole.se>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "x86@kernel.org" <x86@kernel.org>, "arm@kernel.org" <arm@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "robherring2@gmail.com" <robherring2@gmail.com>, Jean-Christophe
 PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 James Hogan <james.hogan@imgtec.com>,
 Vineet Gupta <Vineet.Gupta1@synopsys.com>,
 Rob Herring <rob.herring@calxeda.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Ralf Baechle <ralf@linux-mips.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2013 11:52 PM, Santosh Shilimkar wrote:=0A=
> On some PAE architectures, the entire range of physical memory could resi=
de=0A=
> outside the 32-bit limit.  These systems need the ability to specify the=
=0A=
> initrd location using 64-bit numbers.=0A=
>=0A=
> This patch globally modifies the early_init_dt_setup_initrd_arch() functi=
on to=0A=
> use 64-bit numbers instead of the current unsigned long.=0A=
>=0A=
> There has been quite a bit of debate about whether to use u64 or phys_add=
r_t.=0A=
> It was concluded to stick to u64 to be consistent with rest of the device=
=0A=
> tree code. As summarized by Geert, "The address to load the initrd is dec=
ided=0A=
> by the bootloader/user and set at that point later in time. The dtb shoul=
d not=0A=
> be tied to the kernel you are booting"=0A=
>=0A=
> More details on the discussion can be found here:=0A=
> https://lkml.org/lkml/2013/6/20/690=0A=
> https://lkml.org/lkml/2012/9/13/544=0A=
>=0A=
> Cc: Grant Likely <grant.likely@linaro.org>=0A=
> Cc: Rob Herring <rob.herring@calxeda.com>=0A=
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>=0A=
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>=0A=
> Cc: Vineet Gupta <vgupta@synopsys.com>=0A=
> Cc: Russell King <linux@arm.linux.org.uk>=0A=
> Cc: Catalin Marinas <catalin.marinas@arm.com>=0A=
> Cc: Will Deacon <will.deacon@arm.com>=0A=
> Cc: Mark Salter <msalter@redhat.com>=0A=
> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>=0A=
> Cc: James Hogan <james.hogan@imgtec.com>=0A=
> Cc: Michal Simek <monstr@monstr.eu>=0A=
> Cc: Ralf Baechle <ralf@linux-mips.org>=0A=
> Cc: Jonas Bonn <jonas@southpole.se>=0A=
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>=0A=
> Cc: Paul Mackerras <paulus@samba.org>=0A=
> Cc: x86@kernel.org=0A=
> Cc: arm@kernel.org=0A=
> Cc: Chris Zankel <chris@zankel.net>=0A=
> Cc: Max Filippov <jcmvbkbc@gmail.com>=0A=
> Cc: bigeasy@linutronix.de=0A=
> Cc: robherring2@gmail.com=0A=
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>=0A=
>=0A=
> Cc: linux-arm-kernel@lists.infradead.org=0A=
> Cc: linux-c6x-dev@linux-c6x.org=0A=
> Cc: linux-mips@linux-mips.org=0A=
> Cc: linuxppc-dev@lists.ozlabs.org=0A=
> Cc: linux-xtensa@linux-xtensa.org=0A=
> Cc: devicetree-discuss@lists.ozlabs.org=0A=
>=0A=
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>=0A=
> ---=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>  [For arch/arc bits]=0A=
=0A=
-Vineet=0A=
=0A=
