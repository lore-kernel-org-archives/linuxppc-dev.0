Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3C6D92C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 10:29:10 +1000 (EST)
Message-ID: <51EF1F97.3070409@asianux.com>
Date: Wed, 24 Jul 2013 08:28:07 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc: kernel: remove useless code which related
 with 'max_cpus'
References: <51ECCA10.7010709@asianux.com>
 <51ECCEA8.5040406@linux.vnet.ibm.com> <51ECD0BF.8080605@asianux.com>
 <51ECD3D4.9020405@asianux.com> <51ECD664.7040708@linux.vnet.ibm.com>
 <20130723134431.GF31944@concordia>
In-Reply-To: <20130723134431.GF31944@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Thomas Gleixner <tglx@linutronix.de>, "paulus@samba.org" <paulus@samba.org>,
 chenhui.zhao@freescale.com,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 09:44 PM, Michael Ellerman wrote:
> On Mon, Jul 22, 2013 at 12:21:16PM +0530, Srivatsa S. Bhat wrote:
>> On 07/22/2013 12:10 PM, Chen Gang wrote:
>>> Since not need 'max_cpus' after the related commit, the related code
>>> are useless too, need be removed.
>>>
>>> The related commit:
>>>
>>>   c1aa687 powerpc: Clean up obsolete code relating to decrementer and timebase
>>>
>>> The related warning:
>>>
>>>   arch/powerpc/kernel/smp.c:323:43: warning: parameter ‘max_cpus’ set but not used [-Wunused-but-set-parameter]
>>>
>>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>
>> This version looks good.
> 
> Agreed.
> 
> A good follow up patch, or actually series of patches, would be to
> change the prototype of smp_ops->probe() to return void, and fix all the
> implementations to no longer return anything.
> 

Hmm... normally, a function need have a return value, it will make it
more extensible (especially, it is an API which need be implemented in
various sub modules).

Even though the return value may be useless, now, if the performance is
not quite important in our case, I still suggest to have it (especially
each various original implementation already has it).


> cheers
> 
> 

Thanks.
-- 
Chen Gang
