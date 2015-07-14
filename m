Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62DC41A025F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 00:20:07 +1000 (AEST)
Date: Tue, 14 Jul 2015 10:20:04 -0400
From: Vivek Goyal <vgoyal@redhat.com>
To: dwalker@fifo99.com
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mips@linux-mips.org,
 Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org,
 linux-s390@vger.kernel.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
Message-ID: <20150714142004.GB10792@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714135919.GA18333@fifo99.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
> On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > dwalker@fifo99.com writes:
> > 
> > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > >> 
> > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > >> > However, it doesn't make sense if kdump is not available.  In that
> > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > >> > you can't change the value of the parameter.
> > >> 
> > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > >
> > > I think it would make sense if he just replaced "kdump" with "kexec".
> > 
> > It would be less insane, however it still makes no sense as without
> > kexec on panic support crash_kexec is a noop.  So the value of the
> > seeting makes no difference.
> 
> Can you explain more, I don't really understand what you mean. Are you suggesting
> the whole "crash_kexec_post_notifiers" feature has no value ?

If CONFIG_KEXEC=n, then crash_kexec() is a nop. So it does not matter
whether crash_kexec() is called before panic notifiers or after.

IOW, what do you gain by disabling crash_kexec_post_notifiers, in 
case of CONFIG_KEXEC=n?

Thanks
Vivek
