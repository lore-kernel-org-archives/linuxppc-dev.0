Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3612F1A0088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 08:43:56 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 22 May 2014 18:43:54 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A5738C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:43:46 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22035.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4MMhpVi64028922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 22:43:51 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4MMhoVm013640
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 18:43:51 -0400
Message-ID: <537E7DA3.6030705@linux.vnet.ibm.com>
Date: Thu, 22 May 2014 15:43:47 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/perf/hv-24x7: use kmem_cache instead of aligned
 stack allocations
References: <537E78AD.1040409@linux.vnet.ibm.com>
 <1400797756-6057-1-git-send-email-cody@linux.vnet.ibm.com>
 <20140523083847.4e039ddb@canb.auug.org.au>
In-Reply-To: <20140523083847.4e039ddb@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, michael@ellerman.id.au,
 mingo@redhat.com, paulus@samba.org, imunsie@au1.ibm.com,
 acme@ghostprotocols.net, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/22/2014 03:38 PM, Stephen Rothwell wrote:
> Hi Cody,
>
> On Thu, 22 May 2014 15:29:08 -0700 Cody P Schafer <cody@linux.vnet.ibm.com> wrote:
>>
>> -	*res = be64_to_cpu(result_buffer.result);
>> +	*res = be64_to_cpu(result_buffer->result);
>> +	kfree(result_buffer);
>> +	kfree(request_buffer);
>> +	return ret;
>
> Why not just fall through here by removing the above 3 lines?

No reason except me not noticing it.

>> +
>> +out_hcall:
>> +	kfree(result_buffer);
>> +out_resb:
>> +	kfree(request_buffer);
>> +out_reqb:
>>   	return ret;
>>   }
>
