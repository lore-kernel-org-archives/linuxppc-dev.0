Message-Id: <4.2.0.25.19990302191548.03a646a0@mail.lauterbach.com>
Date: Tue, 02 Mar 1999 19:19:49 +0100
To: Batmensch <hcaley@loomer.com>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: strdup and pre-R5
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <XFMail.990301222929.hcaley@loomer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 04:29 02.03.99 , Batmensch wrote:

>I'm having a problem building OpenLdap 1.2 on a pre-R5 installation; the error
>seems to be with strdup(); the make complains :
>
>"In file included from args.c:22:
>../../include/ac/string.h:49 macro `strdup' using without args"
>
>I've been able to build it without error on both LinuxPPC 4 and Linux X86.
>Also the build of 1.0.2 that is included with the R5 distribution seems to 
>work
>properly.
>
>Anything i can do about this?

This is a common problem with glibc-2.1, the str... functions are macros 
and so some silly sources break on "extern str...()" declarations.

Possible solutions:
- correct source
- compile with -D__NO_STRING_INLINES
- compile with -Os

Franz.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
