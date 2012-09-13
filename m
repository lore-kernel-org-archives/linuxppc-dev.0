Return-Path: <bigeasy@linutronix.de>
Message-ID: <5051816A.3050705@linutronix.de>
Date: Thu, 13 Sep 2012 08:47:06 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] of: specify initrd location using 64-bit
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
 <5050CE33.9060909@ti.com> <5050E965.5080405@linutronix.de>
 <505107DF.5020105@gmail.com>
In-Reply-To: <505107DF.5020105@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mips@linux-mips.org, a-jacquiot@ti.com, mahesh@linux.vnet.ibm.com,
 linux@openrisc.net, paul.gortmaker@windriver.com, paulus@samba.org,
 hpa@zytor.com, m.szyprowski@samsung.com, jonas@southpole.se,
 linux@arm.linux.org.uk, linux-c6x-dev@linux-c6x.org, nico@linaro.org,
 x86@kernel.org, mingo@redhat.com, suzuki@in.ibm.com,
 Cyril Chemparathy <cyril@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linus.walleij@linaro.org, arnd@arndb.de, microblaze-uclinux@itee.uq.edu.au,
 devicetree-discuss@lists.ozlabs.org, msalter@redhat.com,
 rob.herring@calxeda.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, blogic@openwrt.org, dhowells@redhat.com,
 monstr@monstr.eu, david.daney@cavium.com, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, tj@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/13/2012 12:08 AM, Rob Herring wrote:
>> Geert is right here. If it is a physical address, it should be
>> phys_addr_t.
>
> While generally true, for the DT specific code I think it should be a
> fixed u64. The size of the address is defined by the FDT, not the
> kernel. It is very likely we could have a FDT that specifies addresses
> in 64-bit values, but then we boot a kernel is compiled for !LPAE.
> phys_addr_t is currently sized based on LPAE setting.

If your kernel is 32bit without PAE and your DTB address is >32ibt than
you can't handle it. If you don't notice this in your dt code than you
remap the wrong memory ioremap().

>
> Rob
>

Sebastian
