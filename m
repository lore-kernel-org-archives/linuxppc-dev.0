Message-ID: <3FE70E73.3090309@gcctech.com>
Date: Mon, 22 Dec 2003 10:32:03 -0500
From: "Christopher R. Johnson" <cjohnson@gcctech.com>
Reply-To: cjohnson@gcctech.com
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: powerpc gdb and gdbserver
References: <3FE0977B.7020504@gcctech.com> <20031218171010.GA16791@nevyn.them.org> <3FE20DAE.6010708@gcctech.com> <20031218203501.GA22392@nevyn.them.org> <3FE2101D.6000005@gcctech.com> <20031222035217.GA7378@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Good news.  All I needed to do was setup Kegel's crosstool.sh by adding
the following to my powerpc-405.dat file:
GLIBC_EXTRA_CONFIG="--without-fp"

to

GLIBC_EXTRA_CONFIG="--without-fp --enable-add-ons=linuxthreads_db"

And used crosstool to rebuild the tool chain.  That resulted in the
library gdbserver needed to run.  I need some instruction from Dan on
how to rebuild just a component, after this type of config change, so I
don't go through the 2 hour crosstool run.

Daniel Jacobowitz wrote:

>On Thu, Dec 18, 2003 at 03:37:49PM -0500, Christopher R. Johnson wrote:
>
>>As I mentioned, the library doesn't exist.  I need to build it, but I'm
>>not sure where it comes from (glibc I think) or how to get it built.
>>Its a target library, so I have to build it for ppc and deliver it to
>>my target box.  That part I know how to do, its creating the library to
>>begin with that I don't know how to do.
>>
>
>Wherever you got glibc from you should have gotten libthread_db.so.1
>also; maybe it just wasn't installed?
>

--
Christopher R. Johnson
Principal Software Engineer
GCC Printers
(781)276-8763


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
