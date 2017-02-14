Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN0mS2vzJzDqsN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:38:32 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EBXesi003374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 06:38:30 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kfdu1dyc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 06:38:29 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 04:38:29 -0700
Subject: Re: [PATCH v3 2/2] powerpc: emulate_step tests for load/store
 instructions
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1487063803-10848-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1487063803-10848-3-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <877f4tm4n2.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org,
 lsorense@csclub.uwaterloo.ca, oohall@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, ast@kernel.org, chris@distroguy.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 anton@samba.org, paul.gortmaker@windriver.com,
 bauerman@linux.vnet.ibm.com, viro@zeniv.linux.org.uk,
 christophe.leroy@c-s.fr, duwe@lst.de, oss@buserror.net,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 17:08:10 +0530
MIME-Version: 1.0
In-Reply-To: <877f4tm4n2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <58A2EC22.8080209@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 14 February 2017 04:16 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 0e649d7..ddc879d 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -33,3 +33,7 @@ obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
>>  CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
>>  
>>  obj-$(CONFIG_PPC64) += $(obj64-y)
>> +
>> +ifeq ($(CONFIG_PPC64), y)
>> +obj-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
>> +endif
> FYI, the right way to do that is:
>
>   obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
>   obj-$(CONFIG_PPC64) += $(obj64-y)
>
> And in this Makefile you don't need to add the second line because it's
> already there.

Thanks for this. Will change accordingly and send next version.

Ravi

>
> cheers
>
