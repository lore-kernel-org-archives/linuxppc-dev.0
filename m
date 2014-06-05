Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39B571A00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jun 2014 21:56:18 +1000 (EST)
Message-ID: <53905ADB.8000100@suse.de>
Date: Thu, 05 Jun 2014 13:56:11 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 3/3] PPC: KVM: Add support for 64bit TCE windows
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>	
 <1401953144-19186-4-git-send-email-aik@ozlabs.ru>	
 <1401953908.3247.121.camel@pasglop> <539037DB.5080706@ozlabs.ru>
 <1401964037.3247.129.camel@pasglop>
In-Reply-To: <1401964037.3247.129.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.06.14 12:27, Benjamin Herrenschmidt wrote:
> On Thu, 2014-06-05 at 19:26 +1000, Alexey Kardashevskiy wrote:
>> No trees yet. For 64GB window we need (64<<30)/(16<<20)*8 = 32K TCE table.
>> Do we really need trees?
> The above is assuming hugetlbfs backed guests. These are the least of my worry
> indeed. But we need to deal with 4k and 64k guests.

What if we ask user space to give us a pointer to user space allocated 
memory along with the TCE registration? We would still ask user space to 
only use the returned fd for TCE modifications, but would have some 
nicely swappable memory we can store the TCE entries in.

In fact, the code as is today can allocate an arbitrary amount of pinned 
kernel memory from within user space without any checks.


Alex
