Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E2A3B6F98
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Feb 2012 05:28:55 +1100 (EST)
Message-ID: <4F4533DB.7000505@freescale.com>
Date: Wed, 22 Feb 2012 12:28:43 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu-B13201 <B13201@freescale.com>
Subject: Re: [PATCH v5 1/4] KVM: PPC: epapr: Factor out the epapr init
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <4F44130B.5020300@freescale.com>
 <4CA99838F21AB847ACC344051E23170905749AD7@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <4CA99838F21AB847ACC344051E23170905749AD7@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/21/2012 08:33 PM, Liu Yu-B13201 wrote:
>>> +bool epapr_para_enabled = false;
>>
>> No need to explicitly initialize to false.
> 
> Why not make code more readable?

It's common kernel style to not explicitly initialize global data to
zero or equivalent.  Historically this was due to toolchain issues that
are no longer relevant, but people still seem to prefer it that way.
It's subjective whether readability is enhanced by being explicit or by
being concise.

>> Do not warn just because there's no hypervisor or hcall-instructions.
>> There's nothing wrong with that.  Only warn if they are present but wrong.
>>
> 
> I see that it's not proper to warn in host.
> But if user forget to add hypervisor node or inst, how can he know something is wrong?

Print a message when paravirt is enabled (I think KVM already does
this).  This is no different than a user forgetting to add a certain
device to the device tree -- you'll silently just not get that device.

Ideally the hypervisor would take care of adding this stuff to the
device tree anyway, no user action required.

-Scott
