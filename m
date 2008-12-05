Return-Path: <jhsiao@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0A59EDDD01
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 10:24:12 +1100 (EST)
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v4]
From: James Hsiao <jhsiao@amcc.com>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20081204193256.12dbc306.kim.phillips@freescale.com>
References: <1228256232.4770.47.camel@jhsiao-usb>
	<20081204193256.12dbc306.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Fri, 05 Dec 2008 15:24:11 -0800
Message-Id: <1228519451.5444.59.camel@jhsiao-usb>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org
Reply-To: jhsiao@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kim,


I try to address some of the comments. I am not mentioning things that I
agree with you.


> + */
> +static int get_sg_count(struct scatterlist *sg_list, int nbytes)
> +{
> +     struct scatterlist *sg = sg_list;
> +     int sg_nents = 0;
> +
> +     while (nbytes) {
> +             sg_nents++;
> +             if (sg->length > nbytes)
> +                     break;

this is slightly different - this condition shouldn't need checking
here - see [1] below..

> +             nbytes -= sg->length;
> +             sg = sg_next(sg);
> +     }
> +
> +     return sg_nents;
> +}

Without the check, nbytes could become negative. The aead test case
with .np will crash(ie. gcm tests), those test  have sg->length >
nbytes.


About aad_len, we didn't release code that use aad yet. We did test this
function with aad_len none zero(the gcm tests).

About the irq_disable or spin_lock. 
The driver could be used by a kernel thread and esp4 at same time. As I
know process is preemptable. When the driver is used by a process it is
possible to be preempted. The hardware require scatter/gather descriptor
to be consecutive. So, if the process get a gather descriptor and then
it is preempted by another process or esp4 which get a gather descriptor
and return to the original process, the origianl process could get a non
consecutive gather descriptor.   
So, if spin_lock is recommended then I have to use spin_lock_irq_save,
which use irq_disable too. Do you think that is acceptable? 

Thanks and regards

James
