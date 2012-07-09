Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 39E7C2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 06:22:47 +1000 (EST)
Message-ID: <4FFB3D88.6030106@freescale.com>
Date: Mon, 9 Jul 2012 15:22:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3 v2] powerpc/mpic: FSL MPIC error interrupt support.
References: <1341823643-15737-1-git-send-email-Varun.Sethi@freescale.com>
 <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
In-Reply-To: <62D13F27-5E39-450E-953D-102DCA32AA9D@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Cc: Bogdan Hamciuc <bogdan.hamciuc@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2012 02:03 PM, Kumar Gala wrote:
> 
> On Jul 9, 2012, at 3:47 AM, Varun Sethi wrote:
> 
>> +int mpic_err_int_init(struct mpic *mpic, irq_hw_number_t irqnum)
>> +{
> 
> Why can't we do this during mpic_init() time?

Are you willing to hardcode that IRQ 16 is the error interrupt, without
waiting to see an intspec?

>> +	ret = request_irq(virq, fsl_error_int_handler, IRQF_NO_THREAD,
>> +		    "mpic-error-int", mpic);
> 
> Hmm, should we be using irq_set_chained_handler() instead of request_irq

As I said last time, "that's how Varun initially did it and I asked him
to change it, because it gets a lot trickier to get things right, and I
didn't see what it was buying us."  That original patch had locking
problems as a result.

Using the chained handler mechanism puts the responsibility on us to do
a lot of the generic stuff that's already perfectly well implemented in
generic code.  We're implementing a cascade, not a new flow.

-Scott
