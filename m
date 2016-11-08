Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tD4xm3pdXzDvVM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 10:18:52 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so21122746pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Nov 2016 15:18:52 -0800 (PST)
Message-ID: <1478647124.2415.6.camel@gmail.com>
Subject: Re: [PATCH V3 1/2] powerpc: Define new ISA v3.00 logical PVR value
 and PCR register value
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 agraf@suse.com
Date: Wed, 09 Nov 2016 10:18:44 +1100
In-Reply-To: <87y40ujsam.fsf@concordia.ellerman.id.au>
References: <1477975263-29045-1-git-send-email-sjitindarsingh@gmail.com>
 <1477975263-29045-2-git-send-email-sjitindarsingh@gmail.com>
 <87y40ujsam.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-11-08 at 19:21 +1100, Michael Ellerman wrote:
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> 
> > 
> > ISA 3.00 adds the logical PVR value 0x0f000005, so add a definition
> > for
> > this.
> > 
> > Define PCR_ARCH_207 to reflect ISA 2.07 compatibility mode in the
> > processor
> > compatibility register (PCR). Also define a dummy ISA 3.00
> > compatibility
> > mode PCR_ARCH_300 to be used in the next patch to help with
> > determining the
> > PCR value.
> What's "dummy" about the PCR value?
Then next patch needs some PCR bit to specify that we want to emulate
v3.00 and/or that the host can emulate v3.00 to follow the pattern used
to determine that the host is capable of emulating the given compat
level and for determining which PCR bits to set. But no such bit is
defined for V3.00 compat mode yet so a "dummy" one is used to represent
this even though it's never defined in the ISA.
> 
> AFAICS that value is reserved in the ISA.
Yes it is a reserved bit in the PCR register but it will never actually
be set, it will always be cleared by "host_pcr_bit - guest_pcr_bit;"
> 
> Are we assuming/hoping that ISA 4.0 will use 0x10 to mean ISA 3.0 ?
Basically yes, and although I know nothing's given, it would follow the
current pattern for whatever the next ISA version is to use 0x10 to
mean V3.00 compat mode. Otherwise this will need to be updated at some
point when that's released... In fact if the compat bits are no longer
sequential this will need rewriting.
> 
> cheers
