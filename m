Return-Path: <tnt@246tNt.com>
Message-ID: <45468775.8040108@246tNt.com>
Date: Tue, 31 Oct 2006 00:15:01 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support
	for	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
In-Reply-To: <7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Oct 29, 2006, at 5:10 PM, Nicolas DET wrote:
>
>   
>> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>>
>> It includes the main code in arch/powerpc/sysdev/ ad well as an  
>> header file in
>> include/asm-powerpc.
>>
>> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
>>     
>
> Can you see if you can figure out how to inline patches with your  
> mailer, its really difficult to comment on issues w/an attachment.
>   
.There are also scripts to post patches ... So you're sure it's not mangled
or anything.

> +/* MBAR position */
> +#define MPC52xx_MBAR		0xf0000000	/* Phys address */
> +#define MPC52xx_MBAR_VIRT	0xf0000000	/* Virt address */
> +#define MPC52xx_MBAR_SIZE	0x00010000
> +
> +#define MPC52xx_PA(x)		((phys_addr_t)(MPC52xx_MBAR + (x)))
> +#define MPC52xx_VA(x)		((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
>
> This should be handled dynamically (pulled from the device tree), I  
> doubt MBAR will be at the same location for all boards.
>   
Agreed.

A little explanation on why they were used before :

the _VA was used for very early access (mostly boot debug) before
anything is setup.
the _PA was used for addresses used at several places. Like, a lot of
driver / code
needs to access XLB and there was not much way to distribute that
address around.

Now with the device tree that should be doable.
Having a nice function/helper
 void *find_and_map_my_good_old_register_set(char *)
that would find and ioremap it for you would be nice ;) like
 struct mpc52xx_xlb __iomem *xlb_regs =
find_and_map_my_good_old_register_set("xlb");


> * lets drop all the other struct defn in mpc52xx.h.  This is a hold  
> over from arch/ppc and we really should only put defn that we  
> actually need closer to the code that uses them (ie, drivers, etc.)
>   
Most of the struct that were in mpc52xx.h are the ones used in more than
one driver.
(or don't really belong to a driver)
That's why they've been left there and not in the driver header, so I
would leave those
there.

(e.g. the IDE struct is not there, neither is the FEC. But sdma is used
at several place
for example, so is rtc, xlb and cdm, ...)


Personnal note to Nicolas : It may seem a long process to just post a
patch but
since it imports a new platform to the arch/powerpc, it kinda requires
to make all
the due cleanups ;)



Sylvain
