Date: Wed, 12 Mar 2003 13:29:39 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Memory Leak
Message-ID: <20030312132939.C28769@home.com>
References: <001701c2e8d0$a017ef80$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001701c2e8d0$a017ef80$370da8c0@aman>; from aman@mistralsoftware.com on Thu, Mar 13, 2003 at 01:20:25AM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 13, 2003 at 01:20:25AM +0530, Aman wrote:
>  Hi All
>  I am using consistent_alloc () to allocate consistent memory for DMA.  When
> I free the buffers using consistent_free(), the /proc/meminfo shows a
> memory leak of the buffer size allocated.
>
>  I have attached a  module code to allocate memory when inserted and free
>  when removed. The memory leak can be found using the command cat
> /proc/meminfo.

This was fixed three months ago in the development trees.

>  Also the consistent_alloc call gives an error something like "Kernel bug at
> cachemap.." if we try to allocate more than 2MB.

Of course, MAX_ORDER is 10 (in 2.4) and consistent_alloc() is based on
__get_free_pages().

I suggest reading "Understanding the Linux Kernel", "Linux Device
Drivers", and Documentation/* as a starting point for kernel
development.

If you simply must have more consistent memory then you can use
mem= on the command line to reduce the memory available to the
kernel and then use __ioremap/consistent_sync to map the massive
buffer and make it consistent.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
