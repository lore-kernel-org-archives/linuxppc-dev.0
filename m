Message-ID: <3F574958.4090402@acm.org>
Date: Thu, 04 Sep 2003 09:16:56 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
References: <3F4FB0F3.9090906@acm.org> <20030829131824.B18608@home.com>
In-Reply-To: <20030829131824.B18608@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Actually, using the SE bit may not be the best way to handle this to
cover all the PPC variants.

Would it be better to have a special bit field someplace that is used to
communicate between the signal handler and the kernel?  Some
possibilities are:

    * The top 16 bits of the trap field
    * The currently unused mq field (except on APUS?)
    * A new field in the signal frame

I'm thinking that reserving the top 16 bits of the trap field may be the
best.  It would always come in as zero (so existing software won't be
broken) and it will be available for all processors and will not be used
for anything else by the processor.

Any thoughts?

-Corey

Matt Porter wrote:

>On Fri, Aug 29, 2003 at 03:00:51PM -0500, Corey Minyard wrote:
>
>
>>I have a debugger that runs in an application that requires access to
>>the SE and BE bits.  The following patch adds that capability to
>>2.4.21-ben1.  I have tested this, and gdb still seems to correctly step
>>out of signal handlers, and it seems to work for 4xx.  Does this look ok?
>>
>>
>
>Please change MSR_SE->MSR_DWE in the 4xx-specific sections.  Also,
>a comment should be added to each generic section use of MSR_SE to
>make it clear that this is the BookE/4xx MSR_DWE.
>
>-Matt
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
