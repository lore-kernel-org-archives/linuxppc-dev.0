Date: Sun, 16 Jun 2002 16:51:29 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: sycall asm inline
Message-ID: <20020616145129.GA11923@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I noticed that neither "memory" nor "cc" is listed in the clobber
list of the _syscallN asm inline in asm/unistd.h. Is this safe?
The macro looks like this:

#define _syscall1(type,name,type1,arg1)                                 \
type name(type1 arg1)                                                   \
{                                                                       \
        unsigned long __sc_ret, __sc_err;                               \
        {                                                               \
                register unsigned long __sc_0 __asm__ ("r0");           \
                register unsigned long __sc_3 __asm__ ("r3");           \
                                                                        \
                __sc_3 = (unsigned long) (arg1);                        \
                __sc_0 = __NR_##name;                                   \
                __asm__ __volatile__                                    \
                        ("sc           \n\t"                            \
                         "mfcr %1      "                                \
                        : "=&r" (__sc_3), "=&r" (__sc_0)                \
                        : "0"   (__sc_3), "1"   (__sc_0)                \
                        : __syscall_clobbers);                          \
                __sc_ret = __sc_3;                                      \
                __sc_err = __sc_0;                                      \
        }                                                               \
        __syscall_return (type);                                        \
}

where __syscall_clobbers is just r4-r12. At a later point, some syscalls
are instantiated as inline functions:

	static inline _syscall3(int,read,int,fd,char *,buf,off_t,count)

Of course, as long as the syscall reside in a separate function,
the ABI guarantees that nothing bad will happen. But when the
function is inlined the undeclared side effects could cause problems,
or am I missing something?

Cheers,

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
