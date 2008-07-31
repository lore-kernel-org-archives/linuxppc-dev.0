Return-Path: <wg@grandegger.com>
Message-ID: <4891A744.6060005@grandegger.com>
Date: Thu, 31 Jul 2008 13:51:32 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable	via
	FDT
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
	<ed82fe3e0807250721n115d28c7ha1f641c9175c473d@mail.gmail.com>
	<4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
In-Reply-To: <20080727012722.GH12191@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Grant Likely wrote:
> On Fri, Jul 25, 2008 at 11:19:41AM -0500, Timur Tabi wrote:
>> Wolfgang Grandegger wrote:
>>
>>> I know but we still need an algorithm for MPC52xx and MPC82xx as well.
>> That's true, but I still think hard-coding values of DFSR and FDR in the device
>> tree is not a good way to do this.
> 
> I agree, it should encode real frequencies, not raw register values.

Digging deeper I'm frightened by plenty of platform specific code. We 
would need:

- one table of divider,fdr,dfsr values for the MPC82/3/5/6xx processors
   (already available from Timur's U-Boot implementation)

- one table of divider,fdr values for the MPC5200 rev A.

- one table of divider,fdr values for the MPC5200 rev B.
   (the Rev. B has two more pre-scaler bits).

- furthermore, there are various mpc-specific I2C clock sources:

   MPC82xx                     : fsl_get_sys_freq()
   MPC5200                     : IPB
   MPC83xx                     : fsl_get_sys_freq()
   MPC8540/41/60/55,MPC8610    : fsl_get_sys_freq()
   MPC8543/45/47/48/68, MPC8641: fsl_get_sys_freq()/2
   MPC8544                     : fsl_get_sys_freq()/2 or /3

   It would make sense to hand-over the I2C frequency from U-Boot to
   Linux.

Wolfgang.
