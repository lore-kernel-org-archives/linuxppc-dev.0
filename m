Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A042E1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 15:24:10 +1000 (EST)
Date: Tue, 19 Aug 2014 15:24:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: Cleanup kvmppc_load/save_fp
Message-ID: <20140819052407.GA30652@drongo>
References: <1408424370-16960-1-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408424370-16960-1-git-send-email-mikey@neuling.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 02:59:29PM +1000, Michael Neuling wrote:
> This cleans up kvmppc_load/save_fp.  It removes unnecessary isyncs.

NAK - they are necessary on PPC970, which we (still) support.  You
could put them in a feature section if they are really annoying you.

>  It also
> removes the unnecessary resetting of the MSR bits on exit of kvmppc_save_fp.

... except it doesn't. :)  That got folded into e4e38121507a ("KVM:
PPC: Book3S HV: Add transactional memory support").

Paul.
