Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411rn13QJhzF33Y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 02:37:41 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57GZnTq089011
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 12:37:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5pf09py-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 12:37:36 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 17:37:34 +0100
Date: Thu, 07 Jun 2018 22:07:26 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 18/27] powerpc/kprobes: Don't call the
 ->break_handler() in arm kprobes code
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "H . Peter Anvin"
 <hpa@zytor.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
 <152812783350.10068.4690566636762511152.stgit@devbox>
 <1528371112.vwnh1m0k39.naveen@linux.ibm.com>
 <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
In-Reply-To: <20180607232802.c5fcea960e94ef2f3cd4cde8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1528389409.62iyaqw9yn.naveen@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Masami Hiramatsu wrote:
> On Thu, 07 Jun 2018 17:07:00 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>=20
>> Masami Hiramatsu wrote:
>> > Don't call the ->break_handler() from the arm kprobes code,
>> 					    ^^^ powerpc
>>=20
>> > because it was only used by jprobes which got removed.
>> >=20
>> > This also makes skip_singlestep() a static function since
>> > only ftrace-kprobe.c is using this function.
>> >=20
>> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>> > Cc: linuxppc-dev@lists.ozlabs.org
>> > ---
>> >  arch/powerpc/include/asm/kprobes.h   |   10 ----------
>> >  arch/powerpc/kernel/kprobes-ftrace.c |   16 +++-------------
>> >  arch/powerpc/kernel/kprobes.c        |   31 +++++++++++--------------=
------
>> >  3 files changed, 14 insertions(+), 43 deletions(-)
>>=20
>> With 2 small comments...
>=20
> 2 ? or 1 ?

Two, with one in the commit log above :)

- Naveen

=
