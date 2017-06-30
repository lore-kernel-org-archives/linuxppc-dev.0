Return-Path: <htejun@gmail.com>
Received: from mail-qk0-x231.google.com (mail-qk0-x231.google.com
 [IPv6:2607:f8b0:400d:c09::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wzZkz56q7zDrBg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 21:56:59 +1000 (AEST)
Received: by mail-qk0-x231.google.com with SMTP id d78so98377416qkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 04:56:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 30 Jun 2017 07:56:50 -0400
From: Tejun Heo <tj@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Eryu Guan <eguan@redhat.com>, Balbir Singh <bsingharora@gmail.com>,
 liwan@redhat.com, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1
 regression] mount ext4 fs results in kernel crash on PPC64le host)
Message-ID: <20170630115650.GA16820@htj.duckdns.org>
References: <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
 <878tkb9ewo.fsf@concordia.ellerman.id.au>
 <20170629135919.GU23360@eguan.usersys.redhat.com>
 <20170629142425.GB3531@htj.duckdns.org>
 <87k23uqo3d.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k23uqo3d.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Michael.

On Fri, Jun 30, 2017 at 11:08:22AM +1000, Michael Ellerman wrote:
> Tejun Heo <tj@kernel.org> writes:
> 
> > Could be the same problem as the one reported in the following thread.
> >
> >  http://lkml.kernel.org/r/1497266622.15415.39.camel@abdul.in.ibm.com
> >
> > The root cause there is ppc arch code not setting up possible cpu <->
> > numa mapping during boot.
> 
> Huh?
> 
> You changed the workqueue code to avoid that in 2186d9f940b6
> ("workqueue: move wq_numa_init() to workqueue_init()"), didn't you?

That was a different issue.  This one is cpu <-> numa node mapping not
being stable across cpu hotplug.

Thanks.

-- 
tejun
