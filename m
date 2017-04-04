Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxzNK0PYbzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 16:20:01 +1000 (AEST)
Date: Tue, 4 Apr 2017 16:19:56 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Do not always inject facility
 unavailable exceptions
Message-ID: <20170404061956.wj4j5tb6ax44fgvz@oak.ozlabs.ibm.com>
References: <1491218914-10992-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491218914-10992-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 03, 2017 at 01:28:34PM +0200, Thomas Huth wrote:
> KVM should not inject a facility unavailable exception into the guest
> when it tries to execute a mtspr/mfspr instruction for an SPR that
> is unavailable, and the vCPU is *not* running in PRoblem state.
> 
> It's right that we inject an exception when the vCPU is in PR mode, since
> chapter "6.2.10 Facility Status and Control Register" of the PowerISA
> v2.07 says that "When the FSCR makes a facility unavailable, attempted
> usage of the facility in *problem state* is treated as follows: [...]
> Access of an SPR using mfspr/mtspr causes a Facility Unavailable
> interrupt". But if the guest vCPU is not in PR mode, we should follow
> the behavior that is described in chapter "4.4.4 Move To/From System
> Register Instructions" instead and treat the instruction as a NOP.

This doesn't seem quite right.  My reading of the ISA is that the FSCR
bit for a facility being 0 doesn't prevent privileged code from
accessing the facility, so we shouldn't be treating mfspr/mtspr as
NOP.  Instead we should be set the facility's bit in the shadow
FSCR and re-execute the instruction (remembering of course to clear
the FSCR bit when we go back to emulated problem state).

For TM it's a bit different as the MSR[TM] bit does prevent privileged
code from accessing TM registers and instructions, so for TM we should
be delivering a facility unavailable interrupt even when the guest is
in emulated privileged state.

So I don't see any case where mfspr/mtspr should be treated as a NOP
in response to a facility unavailable interrupt.

Paul.
