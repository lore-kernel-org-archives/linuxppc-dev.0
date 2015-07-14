Return-Path: <ebiederm@xmission.com>
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2581A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 11:26:14 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: dwalker@fifo99.com
Cc: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org>
 <20150713202611.GA16525@fifo99.com>
Date: Mon, 13 Jul 2015 20:19:45 -0500
In-Reply-To: <20150713202611.GA16525@fifo99.com> (dwalker@fifo99.com's message
 of "Mon, 13 Jul 2015 20:26:11 +0000")
Message-ID: <87h9p7r0we.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump is
 not available
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

dwalker@fifo99.com writes:

> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>> 
>> > You can call panic notifiers and kmsg dumpers before kdump by
>> > specifying "crash_kexec_post_notifiers" as a boot parameter.
>> > However, it doesn't make sense if kdump is not available.  In that
>> > case, disable "crash_kexec_post_notifiers" boot parameter so that
>> > you can't change the value of the parameter.
>> 
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> I think it would make sense if he just replaced "kdump" with "kexec".

It would be less insane, however it still makes no sense as without
kexec on panic support crash_kexec is a noop.  So the value of the
seeting makes no difference.

Eric
