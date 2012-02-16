Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F48C1007D3
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 03:58:13 +1100 (EST)
Message-ID: <4F3D359E.6030209@freescale.com>
Date: Thu, 16 Feb 2012 10:58:06 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v4 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-3-git-send-email-yu.liu@freescale.com>
 <EAC043A1-A04F-4A27-8488-3C42D99D175E@suse.de>
In-Reply-To: <EAC043A1-A04F-4A27-8488-3C42D99D175E@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 Liu Yu <yu.liu@freescale.com>, "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "<B07421@freescale.com>" <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/16/2012 04:24 AM, Alexander Graf wrote:
> On 16.02.2012, at 10:26, Liu Yu <yu.liu@freescale.com> wrote:
>> +_GLOBAL(epapr_ev_idle)
>> +epapr_ev_idle:
>> +    rlwinm    r3,r1,0,0,31-THREAD_SHIFT    /* current thread_info */
>> +    lwz    r4,TI_LOCAL_FLAGS(r3)    /* set napping bit */
>> +    ori    r4,r4,_TLF_NAPPING    /* so when we take an exception */
>> +    stw    r4,TI_LOCAL_FLAGS(r3)    /* it will return to our caller */
>> +
>> +    wrteei    1
>> +
>> +idle_loop:
>> +    LOAD_REG_IMMEDIATE(r11, HC_VENDOR_EPAPR | HC_EV_IDLE)
>> +
>> +.global epapr_ev_idle_start
>> +epapr_ev_idle_start:
>> +    li    r3, -1
>> +    nop
>> +    nop
>> +    nop
> 
> Can't you just bl into epapr_hypercall_start? You don't even have to save the old lr. because we never return anyways :)

The interrupt will branch to LR, so no, we can't trash it or put it
anywhere else.

-scott
