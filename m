Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id D47352C010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 21:39:37 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH RESEND v4] powerpc: kvm: fix rare but potential deadlock
 scene
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1384841568-20986-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Tue, 19 Nov 2013 11:39:27 +0100
Message-Id: <C03A0DFC-4883-43CA-8EBB-0F80821C31BE@suse.de>
References: <1384841568-20986-1-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Gleb Natapov <gleb@redhat.com>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 19.11.2013, at 07:12, Liu Ping Fan <kernelfans@gmail.com> wrote:

> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
> realmode, so it can trigger the deadlock.
> 
> Suppose the following scene:
> 
> Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of
> vcpus.
> 
> If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched
> out, and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be
> caught in realmode for a long time.
> 
> What makes things even worse if the following happens,
>  On cpuM, bitlockX is hold, on cpuN, Y is hold.
>  vcpu_B_2 try to lock Y on cpuM in realmode
>  vcpu_A_2 try to lock X on cpuN in realmode
> 
> Oops! deadlock happens
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Any particular reason for the resend? The patch is already applied, no?


Alex
