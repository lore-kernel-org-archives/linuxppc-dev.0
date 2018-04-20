Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40S5c0755szF24P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 16:31:44 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3K6VXOh130224
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 02:31:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hf84k6h6s-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 02:31:41 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 20 Apr 2018 07:31:39 +0100
Date: Fri, 20 Apr 2018 12:01:32 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 06/10] powerpc64/ftrace: Disable ftrace during kvm
 entry/exit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Satheesh Rajendran
 <sathnaga@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
 <62b77045b205b008946b793fe31effb155b335be.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180419112216.173f8fd6@gandalf.local.home>
In-Reply-To: <20180419112216.173f8fd6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1524205479.jsi67f85uy.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Steven Rostedt wrote:
> On Thu, 19 Apr 2018 12:34:05 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> 2. If we are a secondary thread in Power8, then we would be in nap due
>> to SMT being disabled. We are woken up by an IPI to enter the guest. In
>> this scenario, we enter the guest through kvm_start_guest(). We disable
>> ftrace at this point. In this scenario, ftrace would only get re-enabled
>> on the secondary thread when SMT is re-enabled (via start_secondary()).
>>=20
> 	trace_hardirqs_off();
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/=
book3s_hv_rmhandlers.S
>> index bd63fa8a08b5..2c3cbe0067b2 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -342,6 +342,9 @@ kvm_start_guest:
>> =20
>>  	ld	r2,PACATOC(r13)
>> =20
>=20
> You may want to add a comment here about where ftrace gets re-enabled.

Sure. That would be:

/*
 * If this is the primary thread, ftrace will get re-enabled when we
 * go back to the hypervisor in kvmppc_run_core(). For secondary threads=20
 * on Power8, ftrace will get enabled when SMT is re-enabled through the=20
 * start_secondary() cpu bringup path.
 */

- Naveen

=
