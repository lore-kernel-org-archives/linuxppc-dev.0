Subject: Re: Booting Procedure
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Aman <aman@mistralsoftware.com>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <000f01c28300$2704a650$370da8c0@aman>
References: <000f01c28300$2704a650$370da8c0@aman>
Date: 04 Nov 2002 10:46:44 -0600
Message-Id: <1036428405.1045.44.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 2002-11-03 at 00:13, Aman wrote:
>
> Now I want to debug the kernel. For that I wanted to know the flow. I
> got the flow upto certain extent, however I couldn't get the starting
> point. Below I have given the flow what I understand. Can you please
> tell me if I am right , if not can you please correct me

This question would be perfectly suited for the mailing list (cc'ed),
where not only would more people have a chance to answer your question,
the question and answers would also be recorded in the list archives to
help people in the future. It would also allow anyone with free time to
answer it, instead of one person who may or may not be busy, and then
you'd get the benefit of people correcting each other as needed.

> 1. relocate.S [ I am not very sure how the controls come here , can
> you please tell me]

You must be referring to boot/simple/relocate.S. Control reaches the
"relocate" routine from boot/simple/head.S . (I found this using grep.)

> 2. From relocate.S , it calls decompress_kernel
> 3. it calls _start in [head_440.S] [ I am not very sure how the
> controls come here , can you please tell me]

Follow the code flow after decompress_kernel; you have less than 10
lines to read! This is the final branch from the bootloader into the
kernel (you can tell because the code is no longer under boot/ and
instead is under kernel/ ).

> 4. _start calls start_kernel and then the kernel comes up.
>
> I am not getting these files in the source level debugging. Is it
> possible to add these files for source level debugging.

Most of this is assembly, which RISCWatch does not display. In general
though, debuggers are invaluable tools but they do not replace tracing
the call flow by hand in small yet complicated codebases like
bootloaders. Bootloaders don't need to follow ABI rules about things
like stack frames, which a debugger would rely upon to determine
backtraces (which I assume is how you were planning on determining the
call flow in the first place).

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
