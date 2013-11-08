Return-Path: <aijazbaig1.new@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0DC922C00E3
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Nov 2013 21:46:27 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <aijazbaig1.new@gmail.com>) id 1Veja4-00078b-8m
 for linuxppc-dev@ozlabs.org; Fri, 08 Nov 2013 02:46:24 -0800
Date: Fri, 8 Nov 2013 02:46:24 -0800 (PST)
From: pegasus <aijazbaig1.new@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1383907583944-77960.post@n7.nabble.com>
Subject: BookE "branch taken" behavior vis-a-vis updating the NIP register
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

I was reading the source code for the debug exception under powerpc. I saw
that BookE processors stop before (actually) taking a branch. Hence in order
to force it to take that branch and then stop, the source code for it had to
be "hacked'  to (temporarily) enable single step until the branch
instruction has been taken, thereby mimicing the BookS behavior. 

By doing this, I believe we would want the exception to be triggered after
the branch has been successfully taken. Hence I put a printk to print the
value of the instruction that actually caused the exception. I was assuming
that initially a debug breakpoint would be hit on the branch instruction
(assuming the branch is supposed to be taken). Now since at this point in
time, the branch instruction has NOT finished, the kernel, after merely
disabling the BT bit in DBCR0 and enabling IC bit in DBCR0, returns. At this
point I was assuming we will see another exception at the very same
instruction in userspace. However, when printing the NIP it becomes clear
that when it gets to the debug exception handler after being (temporarily)
set to single step, NIP points to the instruction after the branch
instruction. To me, it appears that, after disabling BT (branch taken) debug
event monitoring (and enabling single stepping), it does not catch an
exception at that very same branch instruction, instead it catches an
exception for the subsequent instruction. Sorry for the repetition but I
wanted to clarify what I am seeing here.

May be this IS the way it is supposed to behave (which means my thinking
about it is flawed). I am a bit confused here. 

Please let me know more..Im keen to hear from you folks.



--
View this message in context: http://linuxppc.10917.n7.nabble.com/BookE-branch-taken-behavior-vis-a-vis-updating-the-NIP-register-tp77960.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
