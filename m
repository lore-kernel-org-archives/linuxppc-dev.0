Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE1102C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 07:38:17 +1000 (EST)
Message-ID: <505100BD.6020304@freescale.com>
Date: Wed, 12 Sep 2012 16:38:05 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
References: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
 <F4E2A678-6697-4207-8CEE-2CFB3629F554@suse.de>
In-Reply-To: <F4E2A678-6697-4207-8CEE-2CFB3629F554@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Mihai Caraman <mihai.caraman@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2012 01:56 PM, Alexander Graf wrote:
> 
> 
> On 12.09.2012, at 15:18, Mihai Caraman <mihai.caraman@freescale.com> wrote:
> 
>> The current form of DO_KVM macro restricts its use to one call per input
>> parameter set. This is caused by kvmppc_resume_\intno\()_\srr1 symbol
>> definition.
>> Duplicate calls of DO_KVM are required by distinct implementations of
>> exeption handlers which are delegated at runtime.
> 
> Not sure I understand what you're trying to achieve here. Please elaborate ;)

On 64-bit book3e we compile multiple versions of the TLB miss handlers,
and choose from them at runtime.  Without this patch, we get duplicate
label errors if more than one variant of the same exception uses DO_KVM.

-Scott
