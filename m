Message-Id: <5.1.0.14.2.20011107081736.00bb5550@falcon.si.com>
Date: Wed, 07 Nov 2001 08:56:12 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: Compiling kernel with -g option.
In-Reply-To: <200111070012.QAA23022@shell9.ba.best.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Relocation truncated to fit errors are typically caused by your executable
exceeding 16Mbytes (24 bits) in size (assuming it isn't caused by missing
modules and thus unresolved references).  It looks to me like more
aggressive optimizing (O2) is sufficient to get you below the 16Mbyte
mark.  Can you leave some things (less necessary or already debugged
things) out of your kernel or modularize them so that they don't have to be
linked in?

You might try making the code not relocatable to avoid the 24 bit address
limitation on position independent code, but I don't have any experience
with that option and it may cause all sorts of things to break.

 From the gcc manual, "IBM RS/6000 and PowerPC Options"
-mno-relocatable

On embedded PowerPC systems generate code that allows (does not allow) the
program to be relocated to a different address at runtime. If you use
`-mrelocatable' on any module, all objects linked together must be compiled
with `-mrelocatable' or `-mrelocatable-lib'.

gvb


At 04:12 PM 11/6/01 -0800, Subodh Nijsure wrote:

>Sorry if this is "basic" question but I looked through mailing and couldn't
>find a solution.
>
>When I compile kernel and some of my own modules together I get tons
>of error like --
>
>relocation truncated to fit: R_PPC_REL24 copy_to_user
>..
>..
>
>However if I compile everything with -O2 options everything works fine,
>any way I can fix this so I can debug things....
>
>Thanks.
>
>/Subodh
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
