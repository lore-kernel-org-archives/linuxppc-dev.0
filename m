Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xNV14PgbzDrYj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 20:09:13 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4VA4REE118036
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 06:09:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jae3tjgx9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 06:09:10 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 May 2018 11:09:08 +0100
Date: Thu, 31 May 2018 15:39:03 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] error-injection: Simplify arch specific helpers
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Josef Bacik <jbacik@fb.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <8f4883f08feaf6e040255015af2da7bbc7741e41.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180530174156.cb1799687fb834f26fe570a9@kernel.org>
In-Reply-To: <20180530174156.cb1799687fb834f26fe570a9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1527761241.kc7z6i13ny.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Masami Hiramatsu wrote:
> On Tue, 29 May 2018 18:06:02 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> We already have an arch-independent way to set the instruction pointer
>> with instruction_pointer_set(). Using this allows us to get rid of the
>> need for override_function_with_return() that each architecture has to
>> implement.
>>=20
>> Furthermore, just_return_func() only has to encode arch-specific
>> assembly instructions to return from a function. Introduce a macro
>> ARCH_FUNC_RET to provide the arch-specific instruction and move over
>> just_return_func() to generic code.
>>=20
>> With these changes, architectures that already support kprobes, only
>> just need to ensure they provide regs_set_return_value(), GET_IP() (for
>> instruction_pointer_set()), and ARCH_FUNC_RET to support error
>> injection.
>=20
> Nice! the code basically good to me. Just one comment, ARCH_FUNC_RET soun=
ds
> like a function. Maybe ARCH_RETURN_INSTRUCTION will be better name, isn't=
 it? :)

Sure -- I thought of writing ARCH_FUNCTION_RETURN, but felt that was too=20
verbose. How about ARCH_FUNC_RET_INST?

Thanks for the review,
Naveen

=
