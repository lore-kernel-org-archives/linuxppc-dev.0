To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: BAT mapping exported to user-space
References: <1BFD6304-DFEB-11D8-8C13-003065F9B7DC@embeddededge.com>
From: "Dang, Linh [CAR:2X23:EXCH]" <linh@linhdang.home>
Date: Tue, 27 Jul 2004 13:34:05 -0400
In-Reply-To: <1BFD6304-DFEB-11D8-8C13-003065F9B7DC@embeddededge.com> (Dan
 Malek's message of "Tue, 27 Jul 2004 12:36:28 -0400")
Message-ID: <wn5oem1pd6a.fsf@linhd-2.ca.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@embeddededge.com> wrote:

>
> On Jul 26, 2004, at 10:27 PM, Linh Dang wrote:
>
>> What do you mean by the above sentence?
>
> Exactly what I said.  If you are concerned about the difference in
> performance between a BAT mapped space and page tables,
> there are many other kernel behaviors that are going to cause
> trouble for your software.
>
>> - 200MB would need 51200 ptes. that means doubling the current number
>> of ptes on my system.
>
> Doubling?  I don't think so.  How did you measure what you are


# cat /proc/ppc_htab
PTE Hash Table Information
Size            : 256Kb
Buckets         : 4096
Address         : c02c0000
Entries         : 32768
User ptes       : 326
Kernel ptes     : 989
Percent full    : 4%
Reloads         : 29288
Preloads        : 17175
Searches        : 1791
Overflows       : 0
Evicts          : 0
Non-error misses: 24468
Error misses    : 0


That's about 1315 PTEs (before the applications start.)


> currently using?  The 51200 PTEs really isn't a lot.  Mapping huge

just 38 times what currently on my system.

> linear spaces with PTEs is actually quite efficient.  Small VM spaces
> with holes are the killer.  Do you actually touch every byte within
> that 200 MB space?

When the system is working full-steam it's pretty close too that.

>
>> - If using block mapping doesn't help that much then why would X make
>> all the effort to grab MTRRs on X86?
>
> I dunno.  I've never done any performance or feature analysis of x86
> page
> tables to discuss this.
>
>> - why would the kernel use BATs to map its memory?
>
> It's convenient for some areas of memory.  Makes it trivial to write
> some forms of IO mapping functions.  We can set up some early static
> memory maps for kernel initialization.  Mainly, we don't pollute the
> TLBs
> during short interrupt or system calls, allowing the user applications
> to
> run without having to reload the TLB after such events.  Even though
> the kernel may use BATs, it still maps everything with page tables and
> makes extensive use of them for various memory mapping requirements.

I though the kernel (2.6) only use pages for vmalloc.

--
Linh Dang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
