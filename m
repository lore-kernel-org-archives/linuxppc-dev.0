Message-ID: <406C4BE6.1050807@nortelnetworks.com>
Date: Thu, 01 Apr 2004 12:05:42 -0500
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.6 ppc assembly conventions documented anywhere?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, hoping you can help me out...

I'm working on some low-level stuff, and I'm having a bit of a problem
figuring out things like register conventions, call graphs, etc.  Are
there any documents around describing this stuff for 2.6 ppc (32-bit)?

My most immediate issues are:

1) what are the possible return paths from kernelspace to userspace?  I
have some code that I want to run on every return to userspace.  I put
it in entry.S just after "restore_user" and before the CONFIG_PREEMPT
stuff, but I seem to have made it back to userspace somehow without
hitting the code.

2) how do I call panic() from entry.S?  I tried the following but it
didn't seem to work:

     lis    r3,hrt_ps@h
     ori    r3,r3,hrt_ps@l
     lis    r4,panic@h
     ori    r4,r4,panic@l
     li    r5,MSR_KERNEL
     mtspr    SRR0,r4
     mtspr    SRR1,r5
     mtlr    r4
     SYNC
     RFI

/* panic text */
hrt_ps:    .string    "Nested HRT_ACCT entry\n"
hrt_pe:    .string    "Nested HRT_ACCT exit\n"
     .align    4,0

Thanks, and please cc me on replies.

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
