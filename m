To: linuxppc-dev@lists.linuxppc.org
Subject: sigaltstack and SA_ONSTACK for linuxppc (patch)
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 22 Feb 1999 15:20:52 -0600
Message-ID: <m2aey6p22z.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just read that the SheepSaver people were a little stuck because
LinuxPPC didn't have  a working sigaltstack.

The following patch implements SA_ONSTACK in 2.2, in case nobody has
done that yet.  I hope it is correct, it seems to work well for me.

-- 
Corey Minyard                   Internet:  minyard@acm.org
  Work: minyard@nortelnetworks.com  UUCP:  minyard@wf-rch.cirr.com

--- linux-2.2p4.orig/arch/ppc/kernel/signal.c   Sun Nov 15 12:51:44 1998
+++ linux-2.2p4/arch/ppc/kernel/signal.c        Thu Jan 14 15:12:22 1999
@@ -144,6 +144,7 @@
 
        if (act) {
                old_sigset_t mask;
+
                if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
                    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
                    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
@@ -258,7 +259,7 @@
 badframe:
        lock_kernel();
        do_exit(SIGSEGV);
-}
+}
 
 /*
  * Set up a signal frame.
@@ -374,7 +375,7 @@
        if (!oldset)
                oldset = &current->blocked;
 
-       newsp = frame = regs->gpr[1] - sizeof(struct sigregs);
+       newsp = frame = 0;
 
        for (;;) {
                unsigned long signr;
@@ -470,6 +471,15 @@
                                /* NOTREACHED */
                        }
                }
+
+               if (    (ka->sa.sa_flags & SA_ONSTACK)
+                    && (! on_sig_stack(regs->gpr[1]))) {
+                               newsp = (current->sas_ss_sp
+                                        + current->sas_ss_size);
+               } else {
+                       newsp = regs->gpr[1];
+               }
+               newsp = frame = newsp - sizeof(struct sigregs);
 
                /* Whee!  Actually deliver the signal.  */
                handle_signal(signr, ka, &info, oldset, regs, &newsp, frame);

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
