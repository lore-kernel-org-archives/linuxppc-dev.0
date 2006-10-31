Return-Path: <nd@bplan-gmbh.de>
Date: Tue, 31 Oct 2006 08:14:41 +0100 (MET)
Message-ID: <4546F7DE.6070104@bplan-gmbh.de>
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add MPC52xx Interrupt controller support for
	ARCH=powerpc
References: <200610292310.k9TNAHXZ013852@post.webmailer.de>
	<7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
In-Reply-To: <7BDB728E-0CC2-4940-9856-B496022F3482@kernel.crashing.org>
Content-Type: multipart/mixed; boundary="------------030205080006020303030409"
Cc: linuxppc-dev@ozlabs.org, sl@bplan-gmbh.de, sha@pengutronix.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030205080006020303030409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kumar Gala wrote:
> 
> On Oct 29, 2006, at 5:10 PM, Nicolas DET wrote:
> 
>> This patch add MPC52xx Interrupt controller for ARCH=powerpc.
>>
>> It includes the main code in arch/powerpc/sysdev/ ad well as an header 
>> file in
>> include/asm-powerpc.
>>
>> Signed-off-by: Nicolas DET <nd@bplan-gmbh.de>
> 
> Can you see if you can figure out how to inline patches with your 
> mailer, its really difficult to comment on issues w/an attachment.
> 

OT:
Well, on a personal point of view, the only usable mailer I know does 
not run on my 'work' OS. I'll copy/paste from an editor ;-)

> +/* MBAR position */
> +#define MPC52xx_MBAR        0xf0000000    /* Phys address */
> +#define MPC52xx_MBAR_VIRT    0xf0000000    /* Virt address */
> +#define MPC52xx_MBAR_SIZE    0x00010000
> +
> +#define MPC52xx_PA(x)        ((phys_addr_t)(MPC52xx_MBAR + (x)))
> +#define MPC52xx_VA(x)        ((void __iomem *)(MPC52xx_MBAR_VIRT + (x)))
> 
> This should be handled dynamically (pulled from the device tree), I 
> doubt MBAR will be at the same location for all boards.

Well, 0xf000000 seems some kind of 'standart' value. we could have a 
global variable 'mpc52xx_mbar' which would be default 0xf0000000 and 
modified by each platform.

> * can you split out the interrupt controller header info into a 
> mpc52xx_pic.h [mpc52xx_intr, MPC52xx_IRQ_...]

Well, I dod personally have the whole structure/define in a single 
header rather than splitting in xxx files.


--------------030205080006020303030409
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------030205080006020303030409--
