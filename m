Return-Path: <phillip.lougher@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.239])
	by ozlabs.org (Postfix) with ESMTP id BA8D8DDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 08:52:42 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1608900nzf
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 15:52:41 -0700 (PDT)
Message-ID: <bffbecbb0704161552p7f62c800kd774809a41f177f0@mail.gmail.com>
Date: Mon, 16 Apr 2007 23:52:41 +0100
From: "Phillip Lougher" <phillip.lougher@gmail.com>
To: "Siva Prasad" <sprasad@bivio.net>
Subject: Re: Variable "current" in Linux kernel...
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D75A76F1@corpexc01.corp.networkrobots.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
References: <D83235F0F3C86D4D889D8B9A0DA8C6D75A76F1@corpexc01.corp.networkrobots.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/16/07, Siva Prasad <sprasad@bivio.net> wrote:
>
> I would like to know where exactly the value of variable "current" gets
> changed.

current points to the task_struct structure of the currently running
process.  It, obviously, changes each time the scheduler schedules
another process.

>
>
> BTW=85 did any one tried before to run from a different location of memor=
y
> than the usual 0x00000000? What are the main problems you faced? I know t=
his
> is open ended question, but wanted to see if any one ever did that.
>

I changed the 2.4 PPC kernel to do this about 5 years ago (for
Zarlink).  Most of the issues relate to the PPC specific code, all
functions which map from a va->pa, from a pte->va, and vice-versa have
to be changed.  The early start up assembly code has to be aware the
kernel is not running at zero, specifically the code which creates the
initial TLB entries.  As far as I can recall, only one line of non-PPC
specific code needed to be changed.  It is, however, a difficult task
which requires careful auditing of the code, and obviously  knowledge
of the vm and memory allocator systems.

Phillip
