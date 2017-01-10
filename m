Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyR8H3LxPzDqwQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:10:55 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0A99IiY137319
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:10:53 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27vmqyyf16-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 04:10:53 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 19:10:50 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A25DD357805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:10:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0A9AmhE53215312
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:10:48 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0A9AlZm023817
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 20:10:48 +1100
Subject: Re: [PATCH v3 08/15] livepatch: separate enabled and patched states
To: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <de700cbd87b4157b0152c7293558a27deaf0a37b.1481220077.git.jpoimboe@redhat.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>,
 Chris J Arges <chris.j.arges@canonical.com>,
 Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Tue, 10 Jan 2017 14:40:41 +0530
MIME-Version: 1.0
In-Reply-To: <de700cbd87b4157b0152c7293558a27deaf0a37b.1481220077.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3f6e85b4-dcd1-ee45-1cd6-144b6db7d51b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 08 December 2016 11:38 PM, Josh Poimboeuf wrote:
> Once we have a consistency model, patches and their objects will be
> enabled and disabled at different times.  For example, when a patch is
> disabled, its loaded objects' funcs can remain registered with ftrace
> indefinitely until the unpatching operation is complete and they're no
> longer in use.
>
> It's less confusing if we give them different names: patches can be
> enabled or disabled; objects (and their funcs) can be patched or
> unpatched:
>
> - Enabled means that a patch is logically enabled (but not necessarily
>   fully applied).
>
> - Patched means that an object's funcs are registered with ftrace and
>   added to the klp_ops func stack.
>
> Also, since these states are binary, represent them with booleans
> instead of ints.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

-- 
cheers,
Kamalesh.
