From: rdiz@alumni.deec.uc.pt
Message-ID: <3321.62.48.238.11.1085671193.squirrel@alumni.deec.uc.pt>
Date: Thu, 27 May 2004 16:19:53 +0100 (WEST)
Subject: Compiling kernel 2.6.7-rc1 for 8xx
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I'm trying to compile kernel 2.6.7-rc1 for a Motorola 860T misc board. As
of now, I've also tried compiling 2.6.6, 2.6.5, the latest BenH 2.6
Development kernel and the latest Yellow Dog's latest kernel. All came
down to compile errors, and I'm now focusing on solving the problem for
2.6.7-rc1.

So, I'm getting errors when the compilation reaches file
arch/ppc/8xx_io/uart.c . Here is some of the output:

--------------------
arch/ppc/8xx_io/uart.c:86: warning: type defaults to `int' in declaration
of `DECLARE_TASK_QUEUE'
arch/ppc/8xx_io/uart.c:86: warning: parameter names (without types) in
function declaration
arch/ppc/8xx_io/uart.c: In function `serial_console_device':
arch/ppc/8xx_io/uart.c:149: storage class specified for parameter `rs_table'
arch/ppc/8xx_io/uart.c:149: parameter `rs_table' is initialized
arch/ppc/8xx_io/uart.c:151: warning: braces around scalar initializer
arch/ppc/8xx_io/uart.c:151: warning: (near initialization for `rs_table')
arch/ppc/8xx_io/uart.c:151: warning: excess elements in scalar initializer

...

arch/ppc/8xx_io/uart.c:185: field `tqueue' has incomplete type
arch/ppc/8xx_io/uart.c:186: field `tqueue_hangup' has incomplete type
arch/ppc/8xx_io/uart.c:202: warning: structure defined inside parms
arch/ppc/8xx_io/uart.c:202: storage class specified for parameter
`ser_info_t'
arch/ppc/8xx_io/uart.c:204: storage class specified for parameter `sercons'
arch/ppc/8xx_io/uart.c:204: parameter `sercons' is initialized
arch/ppc/8xx_io/uart.c:213: parse error before `*'
arch/ppc/8xx_io/uart.c:213: storage class specified for parameter
`change_speed'
arch/ppc/8xx_io/uart.c:213: warning: function declaration isn't a prototype
arch/ppc/8xx_io/uart.c:214: storage class specified for parameter
`rs_8xx_wait_until_sent'
arch/ppc/8xx_io/uart.c:216: parse error before `*'
arch/ppc/8xx_io/uart.c:218: storage class specified for parameter
`serial_paranoia_check'
--------------------

I subtracted some lines (...) that show warnings in the struct rs_table,
as there was one already declared (I didn't found it). When I compare the
uart.c file for 8xx with the one for 8260, I find that this structure is
the same, and no errors were found when compiling for it.

I'm trying to follow the errors, but I didn't found a link between the
structure rs_table and serial_console_device (where these warnings start).

Has anyone sucessfully compiled the kernel for 8xx PowerPC yet?

Any help would be apreciated,
Regards,
Ricardo Diz


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
