Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F47C2C030A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 23:13:13 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id y10so7523009pdj.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 06:13:11 -0700 (PDT)
Message-ID: <51DEAF60.2000902@ozlabs.ru>
Date: Thu, 11 Jul 2013 23:13:04 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 6/8] KVM: PPC: Add support for multiple-TCE hcalls
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-7-git-send-email-aik@ozlabs.ru> <51DC4228.7010607@suse.de>
 <51DCEA76.9070808@ozlabs.ru> <D10E7B99-3A7C-4275-9A49-3CB15598E705@suse.de>
 <51DE3ECB.7080803@ozlabs.ru> <43E93931-F213-47CC-ADCF-D3A6D6BC4372@suse.de>
 <51DE8EE9.2000508@ozlabs.ru> <C6BC1E27-4C9C-4A18-A64A-052202DA64B5@suse.de>
 <1373546368.19894.87.camel@pasglop>
 <4133424D-B105-4CB1-A72A-4F47A6184DC7@suse.de>
 <1373547480.19894.102.camel@pasglop>
In-Reply-To: <1373547480.19894.102.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 10:58 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-07-11 at 14:51 +0200, Alexander Graf wrote:
>> I don't like bloat usually. But Alexey even had an #ifdef DEBUG in
>> there to selectively disable in-kernel handling of multi-TCE. Not
>> calling ENABLE_CAP would give him exactly that without ugly #ifdefs in
>> the kernel.
> 
> I don't see much point in disabling it... but ok, if that's a valuable
> feature, then shoot some VM level ENABLE_CAP (please don't iterate all
> VCPUs, that's gross).

No use for me whatsoever as I only want to disable real more handlers and
keep virtual mode handlers enabled (sometime, for debug only) and this
capability is not about that - I can easily just not enable it in QEMU with
the exactly the same effect.

So please, fellas, decide whether I should iterate vcpu's or add ENABLE_CAP
per KVM. Thanks.


-- 
Alexey
