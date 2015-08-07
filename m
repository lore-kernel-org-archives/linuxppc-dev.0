Return-Path: <xerofoify@gmail.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C2A71A001E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Aug 2015 00:00:58 +1000 (AEST)
Received: by igbij6 with SMTP id ij6so31526651igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2015 07:00:56 -0700 (PDT)
Message-ID: <55C4BA14.8020307@gmail.com>
Date: Fri, 07 Aug 2015 10:00:52 -0400
From: nick <xerofoify@gmail.com>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>, agraf@suse.com
CC: gleb@kernel.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm:powerpc:Fix error handling in the function
 mpic_set_default_irq_routing
References: <1438955228-30116-1-git-send-email-xerofoify@gmail.com>
 <55C4B9C0.5030102@redhat.com>
In-Reply-To: <55C4B9C0.5030102@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2015-08-07 09:59 AM, Paolo Bonzini wrote:
> 
> 
> On 07/08/2015 15:47, Nicholas Krause wrote:
>> -	kvm_set_irq_routing(opp->kvm, routing, 0, 0);
>> +	ret = kvm_set_irq_routing(opp->kvm, routing, 0, 0);
>> +	if (ret) {
>> +		kfree(routing);
>> +		return ret;
>> +	}
>>  
>>  	kfree(routing);
>>  	return 0;
> 
> You could just return ret here.  The new "if" is not necessary.
> 
> Paolo
> 

Ok sure that seems fine to be and much simpler then this.
Sorry about the wasting your time with this patch.
Nick 
