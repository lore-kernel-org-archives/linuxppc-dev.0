Message-ID: <XFMail.990215114908.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.04.9902150025360.432-100000@narn.local.drgw.net>
Date: Mon, 15 Feb 1999 11:49:08 -0000 (GMT)
From: Gary Thomas <gdt@linuxppc.org>
To: Troy Benjegerdes <hozer@drgw.net>
Subject: Re: Why is -msoft-float used in Kernel compilation?
Cc: linuxppc-dev@lists.linuxppc.org, u497w7n9@umail.furryterror.org,
        Michel Lanners <mlan@cpu.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 15-Feb-99 Troy Benjegerdes wrote:
> 
> On Sun, 14 Feb 1999, Michel Lanners wrote:
> 
>> 
>> On  13 Feb, this message from Gavriel State echoed through cyberspace:
>> > 
>> > I can understand using -msoft-float if CONFIG__8xx is on,
>> > but why use it when compiling for 60x or 7x0 CPUs?
>> 
>> I've heard something about a 'no floiting point in kernel' rule, and
>> I've tried compiling without -msoft-float.... it does boot, but it's an
>> ugly sight... fp warning messages all over!
>> 
>> I have, however, never seen a clear explanation of why that rule
>> exists...
> 
> I'm not sure, but I believe it's an optimization to allow the kernel to
> not have to save floating point registers on every context switch.
> 

More importantly it is to keep GCC from trying to use FP registers to
do structure copies.  Without this option, GCC will try to use the FP
registers to perform high[er] performance copying of structures.  This
would mean that the kernel would have to save/restore some number of
FP registers on every context change, not just the switch from user
to kernel mode, because these registers are considered totally volatile
by the compiler.

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
