Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404Xfl0V9PzF0wd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 21:41:18 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id i9so634641pgq.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 03:41:18 -0700 (PDT)
Date: Mon, 19 Mar 2018 20:40:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Message-ID: <20180319204059.4c3a698e@roar.ozlabs.ibm.com>
In-Reply-To: <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Mon, 19 Mar 2018 14:43:00 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> We have some C code that we call into from real mode where we cannot
> take any exceptions. Though the C functions themselves are mostly safe,
> if these functions are traced, there is a possibility that we may take
> an exception. For instance, in certain conditions, the ftrace code uses
> WARN(), which uses a 'trap' to do its job.
> 
> For such scenarios, introduce a new field in paca 'ftrace_disabled',
> which is checked on ftrace entry before continuing. This field can then
> be set to a non-zero value to disable/pause ftrace, and reset to zero to
> resume ftrace.
> 
> Since KVM is the only user for this currently, we guard the
> ftrace/mcount checks within CONFIG_KVM. This can later be removed
> if/when there are other users.

Why not test HSTATE_IN_GUEST then? Add ftrace_disabled if non-KVM users
come along.

Thanks,
Nick
