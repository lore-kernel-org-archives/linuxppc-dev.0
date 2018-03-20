Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404tX72VHDzDr4t
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 11:06:46 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id p9-v6so8747360pls.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 17:06:46 -0700 (PDT)
Date: Tue, 20 Mar 2018 10:05:59 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Paul Mackerras <paulus@ozlabs.org>,
 linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Anton Blanchard <anton@samba.org>,
 sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] powerpc64/ftrace: Add a field in paca to disable
 ftrace in unsafe code paths
Message-ID: <20180320100559.6823c276@roar.ozlabs.ibm.com>
In-Reply-To: <87r2ofg0e4.fsf@concordia.ellerman.id.au>
References: <cover.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <cdbe15845a5da965878b6344f69b6ed6dbabb87b.1521449527.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180319204059.4c3a698e@roar.ozlabs.ibm.com>
 <87r2ofg0e4.fsf@concordia.ellerman.id.au>
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

On Tue, 20 Mar 2018 09:34:43 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Mon, 19 Mar 2018 14:43:00 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> >  
> >> We have some C code that we call into from real mode where we cannot
> >> take any exceptions. Though the C functions themselves are mostly safe,
> >> if these functions are traced, there is a possibility that we may take
> >> an exception. For instance, in certain conditions, the ftrace code uses
> >> WARN(), which uses a 'trap' to do its job.
> >> 
> >> For such scenarios, introduce a new field in paca 'ftrace_disabled',
> >> which is checked on ftrace entry before continuing. This field can then
> >> be set to a non-zero value to disable/pause ftrace, and reset to zero to
> >> resume ftrace.
> >> 
> >> Since KVM is the only user for this currently, we guard the
> >> ftrace/mcount checks within CONFIG_KVM. This can later be removed
> >> if/when there are other users.  
> >
> > Why not test HSTATE_IN_GUEST then? Add ftrace_disabled if non-KVM users
> > come along.  
> 
> We want to use it for the kexec down path, we've already had bugs there.
> 
> So please keep the separate flag and pull it out of #ifdef KVM.

Okay that's fine.

> If we're worried about space usage in the paca we can probably
> consolidate this and some other things into a flags word.

I'm not too concerned about some more u8 flags.

Thanks,
Nick
