In-Reply-To: <wn5zn5mqj5e.fsf@linhd-2.ca.nortel.com>
References: <E86979D8-DF6A-11D8-9BE7-003065F9B7DC@embeddededge.com> <wn5zn5mqj5e.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1BFD6304-DFEB-11D8-8C13-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: BAT mapping exported to user-space
Date: Tue, 27 Jul 2004 12:36:28 -0400
To: "Linh Dang" <linh@linhdang.home>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 26, 2004, at 10:27 PM, Linh Dang wrote:

> What do you mean by the above sentence?

Exactly what I said.  If you are concerned about the difference in
performance between a BAT mapped space and page tables,
there are many other kernel behaviors that are going to cause
trouble for your software.

> - 200MB would need 51200 ptes. that means doubling the current number
>   of ptes on my system.

Doubling?  I don't think so.  How did you measure what you are
currently using?  The 51200 PTEs really isn't a lot.  Mapping huge
linear spaces with PTEs is actually quite efficient.  Small VM spaces
with holes are the killer.  Do you actually touch every byte within
that 200 MB space?

> - If using block mapping doesn't help that much then why would X make
>   all the effort to grab MTRRs on X86?

I dunno.  I've never done any performance or feature analysis of x86
page
tables to discuss this.

> - why would the kernel use BATs to map its memory?

It's convenient for some areas of memory.  Makes it trivial to write
some forms of IO mapping functions.  We can set up some early static
memory maps for kernel initialization.  Mainly, we don't pollute the
TLBs
during short interrupt or system calls, allowing the user applications
to
run without having to reload the TLB after such events.  Even though
the kernel may use BATs, it still maps everything with page tables and
makes extensive use of them for various memory mapping requirements.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
