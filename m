Date: Sun, 5 Aug 2001 23:49:45 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: Modules and CONFIG_ALTIVEC
Message-ID: <20010805234945.A837@ibrium.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On ppc, the size of thread_struct depends on the CONFIG_ALTIVEC setting.
Thus, the offset of various task_struct fields are dependent upon this
config option.

This makes it difficult to distribute precompiled module binaries
(in a safe manner). It really shouldn't be necessary to bundle:

	module-2.4.X
	module-2.4.X-smp
	module-2.4.X-altivec
	module-2.4.X-altivec-smp

To avoid this problem, one could do something like:

        unsigned long   fpscr;          /* Floating point status */
-#ifdef CONFIG_ALTIVEC
-       vector128       vr[32];         /* Complete AltiVec set */
-       vector128       vscr;           /* AltiVec status */
-       unsigned long   vrsave;
-#endif /* CONFIG_ALTIVEC */
+	altivec_t	*vregs;

I'm not sure the affected task_struct fields are
ever referenced by a typical kernel module. But this is
difficult to check and besides, new fields might be added
to the end of the struct.

Thoughts?

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 790nnnn
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
