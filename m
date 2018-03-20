Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40595Q07hJzF1Tg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:03:05 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2KB1x1Y113597
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 07:03:03 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gtyr5kqqg-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 07:03:03 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 20 Mar 2018 11:02:59 -0000
Date: Tue, 20 Mar 2018 16:32:52 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Paul Mackerras
 <paulus@ozlabs.org>,
 Steven Rostedt <rostedt@goodmis.org>, sathnaga@linux.vnet.ibm.com
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180319204059.4c3a698e@roar.ozlabs.ibm.com>
 <87r2ofg0e4.fsf@concordia.ellerman.id.au>
In-Reply-To: <87r2ofg0e4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521543600.b3r4g46t3z.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> On Mon, 19 Mar 2018 14:43:00 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>
>>> We have some C code that we call into from real mode where we cannot
>>> take any exceptions. Though the C functions themselves are mostly safe,
>>> if these functions are traced, there is a possibility that we may take
>>> an exception. For instance, in certain conditions, the ftrace code uses
>>> WARN(), which uses a 'trap' to do its job.
>>>=20
>>> For such scenarios, introduce a new field in paca 'ftrace_disabled',
>>> which is checked on ftrace entry before continuing. This field can then
>>> be set to a non-zero value to disable/pause ftrace, and reset to zero t=
o
>>> resume ftrace.
>>>=20
>>> Since KVM is the only user for this currently, we guard the
>>> ftrace/mcount checks within CONFIG_KVM. This can later be removed
>>> if/when there are other users.
>>
>> Why not test HSTATE_IN_GUEST then? Add ftrace_disabled if non-KVM users
>> come along.
>=20
> We want to use it for the kexec down path, we've already had bugs there.

I had looked at kexec and we seem to be disabling ftrace in=20
machine_kexec(). Has that been problematic?

I didn't actually realize that you wanted to use this in kexec path as=20
well.

>=20
> So please keep the separate flag and pull it out of #ifdef KVM.

Sure.

- Naveen

=
