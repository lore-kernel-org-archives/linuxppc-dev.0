Date: Mon, 17 Nov 2003 21:38:32 -0500
Subject: Re: cache coherence problem
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Juergen Kienhoefer <juergen@kienhoefer.com>
From: "Michael R. Zucca" <mrz5149@acm.org>
In-Reply-To: <3FB972E8.5090701@kienhoefer.com>
Message-Id: <4CE8E7E9-1970-11D8-ADD5-003065D401D8@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday, November 17, 2003, at 08:16  PM, Juergen Kienhoefer wrote:

> Guys,
> Look at the folloging test program. It mmaps memory, puts some
> instructions in it and executes it.
> Sometimes it works, sometimes it crashes with illegal instruction.
> This smells like cache problems.
> Should the kernel clean the instruction cache for these addresses
> in mmap system call?
> Thanks for any thoughts!

I don't think this is the kernel's responsibility. I think this is just
life with PPCs. If you dump random instructions into random memory, you
have to make sure everything is flushed and the icache is invalidated
before executing the code. You have to do the same thing when you do
self-modifying code.

Why would you want to do this, anyway?

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
