Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <392EDED5.33749798@lucent.com>
Date: Fri, 26 May 2000 15:30:13 -0500
From: Tom Roberts <tjroberts@lucent.com>
MIME-Version: 1.0
Subject: Curious limitation in copy_from_user()
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


While porting Linux PPC to my hardware, I discovered a curious
limitation in copy_from_user() -- it cannot handle uncached memory.
I had mapped some main memory as uncached (using a BAT) because it
is a communication buffer to the host (this is an ISA peripheral
board with a PPC604 on it, and I'm trying to get Linux up on the 604;
this was inside my console driver).

Note that copy_to_user() does not have this limitation -- basically
copy_tofrom_user() is using dcbz-s to improve performance, so if the
destination is uncached you get an exception in the kernel. My first
workaround was simply to do a two-stage copy via a tmp[] buffer on
the stack. Then I did it right by writing a cache_flush() routine
and referencing the buffer via the usual (cached) kernel virtual
address. Of course I called cache_flush() before copy_to_user from
the host->board buffer, and called cache_flush() after copy_from_user
to the board->host buffer (because the host can only reference
physical memory, not the 604's cache).

	Note that in an SMP configuration you need to lock the buffer
	from other CPUs. In my case there is only one 604, and each
	buffer is dedicated to one-way traffic, so no locking is needed.

I still need the uncached address to reference the queue pointers,
but that is done using simple pointer dereferencing and is OK.


Tom Roberts	tjroberts@lucent.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
