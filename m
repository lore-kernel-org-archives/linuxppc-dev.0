Date: Mon, 2 Aug 1999 09:54:55 -0600 (MDT)
From: Brad Midgley <brad@pht.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: test & set ppc assembly (libgcj vs. threads) 
Message-ID: <Pine.LNX.3.95.990802095050.20647A-100000@pacific.pht.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi...

i would like to see libgcj work on ppc. i guess there isn't anyone working
on it because there is missing stuff even in the cvs version. 

could one of you ppc assembly gurus put forward the code to do a test &
set? the header here hopefully provides all the necessary context with
the x86 and alpha implementations... 

brad

#  ifdef LINUX_THREADS
#    include <pthread.h>
#    ifdef __i386__
       inline static int GC_test_and_set(volatile unsigned int *addr) {
          int oldval;
          /* Note: the "xchg" instruction does not need a "lock" prefix */
          __asm__ __volatile__("xchgl %0, %1"
                : "=r"(oldval), "=m"(*(addr))
                : "0"(1), "m"(*(addr)));
          return oldval;
       }
       inline static void GC_clear(volatile unsigned int *addr) {
          *(addr) = 0;
       }
#    elif defined(__alpha__)
       inline static int GC_test_and_set(volatile unsigned int *addr) {
        long oldval, temp;

        __asm__ __volatile__(
              "1:\tldl_l %0,%3\n"
              "\tbne %0,2f\n"
              "\tor $31,1,%1\n"
              "\tstl_c %1,%2\n"
              "\tbeq %1,1b\n"
              "2:\tmb\n"
              : "=&r"(oldval), "=&r"(temp), "=m"(*(addr))
              : "m"(*(addr))
              : "memory");
        return (int)oldval;
       }
       inline static void GC_clear(volatile unsigned int *addr) {
          __asm__ __volatile__("mb": : :"memory");
          *(addr) = 0;
       }
#    else
       -- > Need implementation of GC_test_and_set()
#    endif

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
