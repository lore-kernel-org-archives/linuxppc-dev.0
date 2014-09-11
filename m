Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 218691A003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 00:50:22 +1000 (EST)
Date: Thu, 11 Sep 2014 15:47:38 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Chuck Ebbert <cebbert.lkml@gmail.com>
Subject: Re: [PATCH v2 1/3] init/main.c: Give init_task a canary
Message-ID: <20140911144738.GE12612@atomlin.usersys.redhat.com>
References: <20140904161124.GD1436@atomlin.usersys.redhat.com>
 <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410255749-2956-2-git-send-email-atomlin@redhat.com>
 <20140910022654.29abc9f3@as>
 <20140910132933.GG1436@atomlin.usersys.redhat.com>
 <20140911072345.012f4ef3@as>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140911072345.012f4ef3@as>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, x86@kernel.org,
 akpm@linux-foundation.org, peterz@infradead.org, bmr@redhat.com,
 prarit@redhat.com, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, minchan@kernel.org, mingo@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, akpm@google.com, hannes@cmpxchg.org,
 jgh@redhat.com, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de,
 pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 11, 2014 at 07:23:45AM -0500, Chuck Ebbert wrote:
> On Wed, 10 Sep 2014 14:29:33 +0100
> Aaron Tomlin <atomlin@redhat.com> wrote:
> 
> > On Wed, Sep 10, 2014 at 02:26:54AM -0500, Chuck Ebbert wrote:
> > > And has this been tested on parisc and metag, which use STACK_GROWSUP ?
> > > I can't see how end_of_stack() as it's defined now could work on those archs.
> > 
> > AFAIU, dup_task_struct() has always done this explicitly.
> > I see no reason why init_task requires special attention.
> > 
> 
> I guess what I'm saying is, I can't see how the stack canary could have ever
> detected any problems on parisc and metag. How did you test your patches on x86?

Yes - under x86 only.

> Maybe someone could run tests on those other archs.

As I said, I can't see why it wouldn't work given
dup_task_struct()'s behaviour.

-- 
Aaron Tomlin
