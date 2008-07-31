Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40807310951l48e2af8ep11ef83480397669a@mail.gmail.com>
Date: Thu, 31 Jul 2008 10:51:30 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
In-Reply-To: <4891A744.6060005@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 5:51 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Grant Likely wrote:
>>
>> On Fri, Jul 25, 2008 at 11:19:41AM -0500, Timur Tabi wrote:
>>>
>>> Wolfgang Grandegger wrote:
>>>
>>>> I know but we still need an algorithm for MPC52xx and MPC82xx as well.
>>>
>>> That's true, but I still think hard-coding values of DFSR and FDR in the
>>> device
>>> tree is not a good way to do this.
>>
>> I agree, it should encode real frequencies, not raw register values.
>
> Digging deeper I'm frightened by plenty of platform specific code. We would
> need:
>
> - one table of divider,fdr,dfsr values for the MPC82/3/5/6xx processors
>  (already available from Timur's U-Boot implementation)
>
> - one table of divider,fdr values for the MPC5200 rev A.
>
> - one table of divider,fdr values for the MPC5200 rev B.
>  (the Rev. B has two more pre-scaler bits).
>
> - furthermore, there are various mpc-specific I2C clock sources:
>
>  MPC82xx                     : fsl_get_sys_freq()
>  MPC5200                     : IPB
>  MPC83xx                     : fsl_get_sys_freq()
>  MPC8540/41/60/55,MPC8610    : fsl_get_sys_freq()
>  MPC8543/45/47/48/68, MPC8641: fsl_get_sys_freq()/2
>  MPC8544                     : fsl_get_sys_freq()/2 or /3
>
>  It would make sense to hand-over the I2C frequency from U-Boot to
>  Linux.

U-Boot isn't always available and there are plenty of 5200 and 8xxx
boards out there which will never have U-Boot reflashed to provide
this data.  Also, there are boards that don't even use U-Boot.  I
don't want to go down this path.  It is the drivers *job* to
understand how to set these registers.

If you're careful, the table doesn't need to be huge.  It can be
marked as initdata and conditionally compiled depending on which
architectures are compiled in.  You should use .data in the driver's
of_device_id table to provide machine specific ops for setting
clocking to avoid a maze of if/else statements.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
