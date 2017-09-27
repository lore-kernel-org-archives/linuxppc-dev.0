Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2J2H4Zm8zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 23:04:55 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id j16so9151747pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 06:04:55 -0700 (PDT)
Date: Wed, 27 Sep 2017 23:04:36 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi
 Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon
 <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew
 Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski
 <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linuxppc-dev@lists.ozlabs.org, gromer <gromer@google.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20170927230436.4af88a62@roar.ozlabs.ibm.com>
In-Reply-To: <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Sep 2017 20:43:28 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Sep 26, 2017, at 1:51 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > Provide a new command allowing processes to register their intent to use
> > the private expedited command.
> >   
> 
> I missed a few maintainers that should have been CC'd. Adding them now.
> This patch is aimed to go through Paul E. McKenney's tree.

Honestly this is pretty ugly new user API and fairly large amount of
complexity just to avoid the powerpc barrier. And you end up with arch
specific hooks anyway!

So my plan was to add an arch-overridable loop primitive that iterates
over all running threads for an mm. powerpc will use its mm_cpumask for
iterating and use runqueue locks to avoid the barrier. x86 will most
likely want to use its mm_cpumask to iterate.

For the powerpc approach, yes there is some controversy about using
runqueue locks even for cpus that we already can interfere with, but I
think we have a lot of options we could look at *after* it ever shows
up as a problem.

Thanks,
Nick
