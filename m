From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sycall asm inline
Date: Wed, 19 Jun 2002 05:24:00 +0200
Message-Id: <20020619032400.8069@smtp.wanadoo.fr>
In-Reply-To: <20020616145129.GA11923@ibrium.se>
References: <20020616145129.GA11923@ibrium.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>where __syscall_clobbers is just r4-r12. At a later point, some syscalls
>are instantiated as inline functions:
>
>	static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)
>
>Of course, as long as the syscall reside in a separate function,
>the ABI guarantees that nothing bad will happen. But when the
>function is inlined the undeclared side effects could cause problems,
>or am I missing something?

Probably not missing anything. Now we have to figure the proper set
of clobbers, though I'm wondering if we could replace those inline
syscalls by direct calls to the proper sys_xxx function. The only
advantage I see in doing the syscall from the kernel is that you
can "patch" it from a module or whatever, but is this feature used at
all ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
