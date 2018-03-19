Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404lZb1yNMzF0xH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 05:53:26 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2JIo8cE177855
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 14:53:24 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gth4vcja9-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 14:53:24 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 19 Mar 2018 18:53:22 -0000
Date: Tue, 20 Mar 2018 00:23:17 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>, Steven Rostedt
 <rostedt@goodmis.org>, sathnaga@linux.vnet.ibm.com
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180319204059.4c3a698e@roar.ozlabs.ibm.com>
In-Reply-To: <20180319204059.4c3a698e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1521485554.xdqk4zmukv.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin wrote:
> On Mon, 19 Mar 2018 14:43:00 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> We have some C code that we call into from real mode where we cannot
>> take any exceptions. Though the C functions themselves are mostly safe,
>> if these functions are traced, there is a possibility that we may take
>> an exception. For instance, in certain conditions, the ftrace code uses
>> WARN(), which uses a 'trap' to do its job.
>>=20
>> For such scenarios, introduce a new field in paca 'ftrace_disabled',
>> which is checked on ftrace entry before continuing. This field can then
>> be set to a non-zero value to disable/pause ftrace, and reset to zero to
>> resume ftrace.
>>=20
>> Since KVM is the only user for this currently, we guard the
>> ftrace/mcount checks within CONFIG_KVM. This can later be removed
>> if/when there are other users.
>=20
> Why not test HSTATE_IN_GUEST then? Add ftrace_disabled if non-KVM users
> come along.

That's indeed simpler -- thanks for the suggestion!

- Naveen
=
