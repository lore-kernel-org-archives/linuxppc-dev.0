Return-Path: <paulus@ozlabs.org>
Date: Sat, 16 Nov 2013 17:55:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <qemulist@gmail.com>
Subject: Re: [PATCH v4] powerpc: kvm: fix rare but potential deadlock scene
Message-ID: <20131116065517.GA18339@iris.ozlabs.ibm.com>
References: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 15, 2013 at 04:35:00PM +0800, Liu Ping Fan wrote:
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
>   On cpuM, bitlockX is hold, on cpuN, Y is hold.
>   vcpu_B_2 try to lock Y on cpuM in realmode
>   vcpu_A_2 try to lock X on cpuN in realmode
> 
> Oops! deadlock happens
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Reviewed-by: Paul Mackerras <paulus@samba.org>
