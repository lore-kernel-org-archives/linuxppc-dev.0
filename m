Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C083E2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 08:33:05 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH v4] powerpc: kvm: fix rare but potential deadlock scene
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20131116065517.GA18339@iris.ozlabs.ibm.com>
Date: Mon, 18 Nov 2013 16:32:56 -0500
Message-Id: <6E84B29F-6921-4309-9A73-3AD8D8C6872A@suse.de>
References: <1384504501-19348-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131116065517.GA18339@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, Liu Ping Fan <qemulist@gmail.com>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 16.11.2013, at 01:55, Paul Mackerras <paulus@samba.org> wrote:

> On Fri, Nov 15, 2013 at 04:35:00PM +0800, Liu Ping Fan wrote:
>> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
>> realmode, so it can trigger the deadlock.
>> 
>> Suppose the following scene:
>> 
>> Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of
>> vcpus.
>> 
>> If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched
>> out, and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be
>> caught in realmode for a long time.
>> 
>> What makes things even worse if the following happens,
>>  On cpuM, bitlockX is hold, on cpuN, Y is hold.
>>  vcpu_B_2 try to lock Y on cpuM in realmode
>>  vcpu_A_2 try to lock X on cpuN in realmode
>> 
>> Oops! deadlock happens
>> 
>> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> 
> Reviewed-by: Paul Mackerras <paulus@samba.org>

Thanks, applied to kvm-ppc-queue.


Alex
