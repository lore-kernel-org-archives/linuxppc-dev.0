Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFD1C1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 08:57:38 +1100 (EST)
Message-ID: <4F3ECD49.4080803@freescale.com>
Date: Fri, 17 Feb 2012 15:57:29 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 16/30] KVM: PPC: e500mc: Add doorbell emulation support
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-17-git-send-email-agraf@suse.de>
 <4F3ECCE6.2010503@freescale.com>
In-Reply-To: <4F3ECCE6.2010503@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 03:55 PM, Scott Wood wrote:
> Should this be a kvm_make_request instead (with a separate
> pending_doorbell bool in vcpu that msgclr can act on), considering
> earlier discussion of phasing out atomics on pending_exceptions, in
> favor of requests?

Ignore the bit about msgclr -- it acts on the local vcpu, so no need for
pending_doorbell.  It can just be a plain request.

-Scott
