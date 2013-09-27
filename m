Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp13.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E84F2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:14:26 +1000 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 27 Sep 2013 09:14:21 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 98361219006A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 09:14:18 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8R8E6kg58785832
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 08:14:06 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8R8EH8t023140
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 02:14:18 -0600
Message-ID: <52453E57.3000304@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 10:14:15 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/kvmbook3s_hv: propagate H_SET_MODE to the host
References: <1379901913-5945-37-git-send-email-anton@samba.org>
 <20130925121027.29504.19269.stgit@nimbus>
 <20130925223118.GA2844@iris.ozlabs.ibm.com>
In-Reply-To: <20130925223118.GA2844@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26/09/2013 00:31, Paul Mackerras wrote:
> On Wed, Sep 25, 2013 at 02:10:27PM +0200, Laurent Dufour wrote:
>> Follow-up to Anton's H_SET_MODE patch, the host should be taken aware of
>> guest endianess change.
>>
>> The hcall H_SET_MODE is processed in kvm then in the host.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kvm/book3s_hv.c |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>> index 998cad3..4a47c74 100644
>> --- a/arch/powerpc/kvm/book3s_hv.c
>> +++ b/arch/powerpc/kvm/book3s_hv.c
>> @@ -599,6 +599,14 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>>  					kvmppc_get_gpr(vcpu, 5),
>>  					kvmppc_get_gpr(vcpu, 6),
>>  					kvmppc_get_gpr(vcpu, 7));
>> +		/*
>> +		 * If the hcall succeeded, we propagate it to the host.
>> +		 * This way, it will be aware of the endianess's change too.
>> +		 * The assumption is made that the hcall will succeed in the
>> +		 * host.
>> +		 */
>> +		if (ret == H_SUCCESS)
>> +			return RESUME_HOST;
>>  		break;
> 
> The problem with this is that H_SET_MODE isn't just used for setting
> endianness; it also does breakpoint setting (DAWR/X and CIABR), which
> might happen very frequently, so we don't want them being punted up to
> userspace.
> 
> Paul.

Hi Paul,

My mistake, the patch was based on a too old kernel missing yours and
Michael's latest patches on H_SET_MODE handling.

I'll propose a new one asap.

Thanks,
Laurent.
