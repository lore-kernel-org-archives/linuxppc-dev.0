Message-ID: <3A6C9135.F542F0FA@mvista.com>
Date: Mon, 22 Jan 2001 14:59:49 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: Tom Gall <tgall@rochcivictheatre.org>, Troy Benjegerdes <hozer@drgw.net>,
        linuxppc_commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
References: <3A68F7A0.693639F1@mvista.com> <20010121222842.A27103@altus.drgw.net> <3A6BB971.7F128273@rochcivictheatre.org> <3A6C822F.7DB50A58@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


tom_gall@vnet.ibm.com wrote:

>   current->mm I believe is correct. active_mm for tasks in user space just point
> back to mm. kernel space tasks will have an mm of NULL yet their active_mm will
> point back to the last user space task they ran.


Not exactly.  Every task running on a CPU must have an active_mm, and
it represents the current context for the MMU.  This active_mm comes
from a single threaded application's 'mm', or in the case of a
thread without an 'mm' from the previous application that ran, or
from somewhere else depending upon VM_CLONE games.

The point you are missing is 'active_mm' represents the current
context for the MMU.  If you get a context overflow, you can't skip
getting and setting a context for an active task just because it
doesn't have a 'current->mm'.  Your modification to do this
results in a task running on a CPU with a "NO CONTEXT" mm, and worse
and incorrect VSID/ASID/PID/whatever for the task running on that MMU.


>   The reason for this patch is in the case where the idle task comes in on one
> processor and on another processor it has encountered a context overflow.


It's not just the idle task.  It could be any task that is supposed
to get an active_mm from someone else.

The patch is just logically incorrect.  There should be no
'if current->mm' and it should get/set context on current->active_mm.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
