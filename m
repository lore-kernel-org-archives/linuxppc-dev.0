Return-Path: <vgoyal@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3F321A025F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 01:40:42 +1000 (AEST)
Date: Tue, 14 Jul 2015 11:40:40 -0400
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
Message-ID: <20150714154040.GA3912@redhat.com>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
 <87h9p7r0we.fsf@x220.int.ebiederm.org>
 <20150714135919.GA18333@fifo99.com>
 <20150714150208.GD10792@redhat.com>
 <20150714153430.GA18766@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150714153430.GA18766@fifo99.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 14, 2015 at 03:34:30PM +0000, dwalker@fifo99.com wrote:
> On Tue, Jul 14, 2015 at 11:02:08AM -0400, Vivek Goyal wrote:
> > On Tue, Jul 14, 2015 at 01:59:19PM +0000, dwalker@fifo99.com wrote:
> > > On Mon, Jul 13, 2015 at 08:19:45PM -0500, Eric W. Biederman wrote:
> > > > dwalker@fifo99.com writes:
> > > > 
> > > > > On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
> > > > >> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
> > > > >> 
> > > > >> > You can call panic notifiers and kmsg dumpers before kdump by
> > > > >> > specifying "crash_kexec_post_notifiers" as a boot parameter.
> > > > >> > However, it doesn't make sense if kdump is not available.  In that
> > > > >> > case, disable "crash_kexec_post_notifiers" boot parameter so that
> > > > >> > you can't change the value of the parameter.
> > > > >> 
> > > > >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > > > >
> > > > > I think it would make sense if he just replaced "kdump" with "kexec".
> > > > 
> > > > It would be less insane, however it still makes no sense as without
> > > > kexec on panic support crash_kexec is a noop.  So the value of the
> > > > seeting makes no difference.
> > > 
> > > Can you explain more, I don't really understand what you mean. Are you suggesting
> > > the whole "crash_kexec_post_notifiers" feature has no value ?
> > 
> > Daniel,
> > 
> > BTW, why are you using crash_kexec_post_notifiers commandline? Why not
> > without it?
> 
> It was explained in the prior thread but to rehash, the notifiers are used to do a switch
> over from the crashed machine to another redundant machine.

So why not detect failure using polling or issue notifications from second
kernel.

IOW, expecting that a crashed machine will be able to deliver notification
reliably is falwed to begin with, IMHO.

If a machine is failing, there are high chance it can't deliver you the
notification. Detecting that failure suing some kind of polling mechanism
might be more reliable. And it will make even kdump mechanism more
reliable so that it does not have to run panic notifiers after the crash.

Thanks
Vivek
