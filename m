Return-Path: <hidehiro.kawai.ez@hitachi.com>
Received: from mail9.hitachi.co.jp (mail9.hitachi.co.jp [133.145.228.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 7D7BB1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 11:56:18 +1000 (AEST)
Message-ID: <55A46C3D.7000208@hitachi.com>
Date: Tue, 14 Jul 2015 10:56:13 +0900
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
MIME-Version: 1.0
To: dwalker@fifo99.com, "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>,
 linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>,
 linux-sh@vger.kernel.org, linux-s390@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 linuxppc-dev@lists.ozlabs.org, linux-metag@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] panic: Disable crash_kexec_post_notifiers if kdump
 is not available
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.63745.stgit@softrs>
 <87wpy82kqf.fsf@x220.int.ebiederm.org> <20150713202611.GA16525@fifo99.com>
In-Reply-To: <20150713202611.GA16525@fifo99.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Eric and Daniel,

(2015/07/14 5:26), dwalker@fifo99.com wrote:
> On Fri, Jul 10, 2015 at 08:41:28AM -0500, Eric W. Biederman wrote:
>> Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com> writes:
>>
>>> You can call panic notifiers and kmsg dumpers before kdump by
>>> specifying "crash_kexec_post_notifiers" as a boot parameter.
>>> However, it doesn't make sense if kdump is not available.  In that
>>> case, disable "crash_kexec_post_notifiers" boot parameter so that
>>> you can't change the value of the parameter.
>>
>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> You are confusing kexec on panic and CONFIG_CRASH_DUMP
>> which is about the tools for reading the state of the previous kernel.

You are right.  I mistook the meaning of CONFIG_CRASH_DUMP.

> I think it would make sense if he just replaced "kdump" with "kexec".

If a user specified crash_kexec_post_notifiers option with kexec
being totally disabled, it just disables notifier and kmsg dumper calls
(please see PATCH 3/3). So as Daniel said, I also think it makes sense
to hide crash_kexec_post_notifiers option if kexec is disabled.

Regards,

-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group
