Message-Id: <200203251001.TAA12917@mail.highway.ne.jp>
Date: Mon, 25 Mar 2002 18:58:22 +0900 (JST)
From: Kaoru Fukui <k_fukui@highway.ne.jp>
Subject: linux-2.5.7 problem
To: linuxppc-dev@lists.linuxppc.org
Cc: k_fukui@highway.ne.jp
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I got this problem.
sched.h of linux-2.5.7 doesn't has p_pptr. but sched.h of linux-2.4 has it.

Should I use parent instead of p_pptr ?

Kaoru
-------

gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -I/usr/src/redhat/BUILD/linux/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring   -DKBUILD_BASENAME=signal  -c -o signal.o signal.c
signal.c: In function `do_signal':
signal.c:597: structure has no member named `p_pptr'
signal.c:598: structure has no member named `p_pptr'
signal.c:637: structure has no member named `p_pptr'
make[1]: *** [signal.o]  1
make[1]:   `/usr/src/redhat/BUILD/linux/arch/ppc/kernel'

---linux-2.4 sched.h
	/*
	 * pointers to (original) parent process, youngest child, younger sibling,
	 * older sibling, respectively.  (p->father can be replaced with
	 * p->p_pptr->pid)
	 */
	struct task_struct *p_opptr, *p_pptr, *p_cptr, *p_ysptr, *p_osptr;
	struct list_head thread_group;


---linux-2.5.7 sched.h
	/*
	 * pointers to (original) parent process, youngest child, younger sibling,
	 * older sibling, respectively.  (p->father can be replaced with
	 * p->parent->pid)
	 */
	struct task_struct *real_parent; /* real parent process (when being debugged) */
	struct task_struct *parent;	/* parent process */
	struct list_head children;	/* list of my children */
	struct list_head sibling;	/* linkage in my parent's children list */
	struct list_head thread_group;

	/* PID hash table linkage. */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
