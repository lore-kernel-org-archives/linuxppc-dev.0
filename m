Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2wtC66dQzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 20:43:47 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id x72so54395820pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 03:43:47 -0700 (PDT)
Date: Mon, 1 Aug 2016 20:43:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au,
 anton@samba.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 10/11] powerpc: Support to replay PMIs
Message-ID: <20160801204337.7c9fbfb6@roar.ozlabs.ibm.com>
In-Reply-To: <1768c5de-fe51-8b59-ca4e-9c34b1251a49@linux.vnet.ibm.com>
References: <1469991989-28409-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469991989-28409-11-git-send-email-maddy@linux.vnet.ibm.com>
 <20160801180716.5d0a47de@roar.ozlabs.ibm.com>
 <1470041496.5978.364.camel@kernel.crashing.org>
 <1768c5de-fe51-8b59-ca4e-9c34b1251a49@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 1 Aug 2016 15:52:28 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> On Monday 01 August 2016 02:21 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2016-08-01 at 18:07 +1000, Nicholas Piggin wrote:  
> >> This will replay hardware_interrupt_common in the case we got a PMI
> >> interrupt but no EE.
> >>
> >> Should we just follow the normal pattern here, return 0xf00 for PMI,
> >> and replay the same as the other cases?  
> > Agreed.  
> 
> OK. But can we handle that in the C itself.
> With an additional check to see whether EE happended or not?
> Because if PMI landed first, there will be no EE anyway?

I just don't know if it's worth making a special case for
it rather than handle it the same as the others?
