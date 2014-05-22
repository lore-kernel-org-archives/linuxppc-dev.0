Return-Path: <cody@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 58B751A058E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 09:54:19 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 22 May 2014 17:54:16 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 9A2336E8041
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 19:54:04 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4MNsCo165798160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 23:54:12 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4MNsA6p010499
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 19:54:12 -0400
Message-ID: <537E8E1F.9020303@linux.vnet.ibm.com>
Date: Thu, 22 May 2014 16:54:07 -0700
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] powerpc/perf/hv-24x7: use kmem_cache instead of aligned
 stack allocations
References: <537E78AD.1040409@linux.vnet.ibm.com>
 <1400798673-27522-1-git-send-email-cody@linux.vnet.ibm.com>
 <20140523094929.15f4613c@canb.auug.org.au>
In-Reply-To: <20140523094929.15f4613c@canb.auug.org.au>
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

On 05/22/2014 04:49 PM, Stephen Rothwell wrote:
> Hi Cody,
>
> On Thu, 22 May 2014 15:44:25 -0700 Cody P Schafer <cody@linux.vnet.ibm.com> wrote:
>>
>>   	if (ret) {
>>   		if (success_expected)
>>   			pr_err_ratelimited("hcall failed: %d %#x %#x %d => 0x%lx (%ld) detail=0x%x failing ix=%x\n",
>>   					domain, offset, ix, lpar,
>>   					ret, ret,
>> -					result_buffer.buf.detailed_rc,
>> -					result_buffer.buf.failing_request_ix);
>> -		return ret;
>> +					result_buffer->buf.detailed_rc,
>> +					result_buffer->buf.failing_request_ix);
>> +		goto out_hcall;
>>   	}
>>
>> -	*res = be64_to_cpu(result_buffer.result);
>> +	*res = be64_to_cpu(result_buffer->result);
>
> not a biggie, but this last bit could be (remove the goto out_hcall and
> teh label and then)
>
> 	} else {
> 		*res = be64_to_cpu(result_buffer->result);
> 	}
>

I've got a slight preference toward keeping it as is, which lets all of 
the non-error path code stay outside of if/else blocks (and the error 
handling is kept ever so slightly more consistent).

>> +out_hcall:
>> +	kfree(result_buffer);
>> +out_resb:
>> +	kfree(request_buffer);
>> +out_reqb:
>>   	return ret;
>>   }
>>
>
> otherwise looks good to me.
>
