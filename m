Message-ID: <3A68F7A0.693639F1@mvista.com>
Date: Fri, 19 Jan 2001 21:27:44 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: context overflow
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just heard about the bug Tom Gall fixed in "context_overflow"
by testing for current->mm == NULL.

I believe the proper solution is to use 'current->active_mm'
instead of 'current->mm' (and you never get a null pointer).
This way, the proper 'active' context is updated with a new
context even though a kernel thread has stolen it from somewhere
else to use.  I think skipping the selection of a new context
in this case could be logically incorrect for some PowerPC cores.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
