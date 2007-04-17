Return-Path: <sprasad@bivio.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Variable "current" in Linux kernel...
Date: Tue, 17 Apr 2007 08:12:02 -0700
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D75A778E@corpexc01.corp.networkrobots.com>
In-Reply-To: <bffbecbb0704161552p7f62c800kd774809a41f177f0@mail.gmail.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D75A76F1@corpexc01.corp.networkrobots.com>
	<bffbecbb0704161552p7f62c800kd774809a41f177f0@mail.gmail.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: "Phillip Lougher" <phillip.lougher@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

One question for the community:
Why are we storing the physical address of a task. Why can't we store
the virtual address, and convert it as and when required by using
tophys(). By storing the physical address, are we not loosing this code
portability. May be I am wrong, but would like to understand.

Thanks Phillip.
Now even the bootmem code needs update, as that considers 0x00000000 as
default lower address and does the computations for free memory based on
that.

Thanks every one for the help.

Thanks
Siva



-----Original Message-----
From: Phillip Lougher [mailto:phillip.lougher@gmail.com]=20
Sent: Monday, April 16, 2007 3:53 PM
To: Siva Prasad
Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
Subject: Re: Variable "current" in Linux kernel...

On 4/16/07, Siva Prasad <sprasad@bivio.net> wrote:
>
> I would like to know where exactly the value of variable "current"
gets
> changed.

current points to the task_struct structure of the currently running
process.  It, obviously, changes each time the scheduler schedules
another process.

>
>
> BTW... did any one tried before to run from a different location of
memory
> than the usual 0x00000000? What are the main problems you faced? I
know this
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
