Return-Path: <joel.stan@gmail.com>
Received: from mail-vc0-x231.google.com (mail-vc0-x231.google.com
 [IPv6:2607:f8b0:400c:c03::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0CCA3140098
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2014 09:53:18 +1100 (EST)
Received: by mail-vc0-f177.google.com with SMTP id if17so8764032vcb.36
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Mar 2014 15:53:15 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1396267178.11529.80.camel@pasglop>
References: <1395964240-8305-1-git-send-email-joel@jms.id.au>
 <1395964240-8305-2-git-send-email-joel@jms.id.au>
 <21604.1396238935@ale.ozlabs.ibm.com>
 <1396267178.11529.80.camel@pasglop>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 1 Apr 2014 09:22:54 +1030
Message-ID: <CACPK8Xfun6UHdHq_-308jGw5tmv53L-CPa=g-NWCya1WL_kVGw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/powernv: Add OPAL message log interface
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, michael@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>, shangw@linux.vnet.ibm.com,
 hegdevasant@linux.vnet.ibm.com, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 31, 2014 at 10:29 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>> > +   conbuf = phys_to_virt(be64_to_cpu(mc->obuf_phys));
>> > +   wrapped = be32_to_cpu(mc->out_pos) & MEMCONS_OUT_POS_WRAP;
>> > +   out_pos = be32_to_cpu(mc->out_pos) & MEMCONS_OUT_POS_MASK;
>> > +
>>
>> Are there ordering issues we need to think about here with reading
>> these?  Can the messages be written on another CPU at the same time as
>> these are being read?
>
> Good point. out_pos should probably be read only once into a local
> variable using the ACCESS_ONCE macro, and then only be broken up.

I've got a V2 that fixes this and the other issues Mikey pointed out.

I found that the log would get corrupted from Linux's point of view
once full. Dumping the memory suggests that the contents of the
circular buffer is fine, and it's just our pointer (out_pos) that is
incorrect. It's not clear why this is happening; I'll do some more
testing before sending out the updated patch.

Cheers,

Joel
