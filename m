Message-ID: <388292FB.4401C930@mvista.com>
Date: Sun, 16 Jan 2000 21:56:43 -0600
From: Jim Lewis <jlewis@mvista.com>
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>
CC: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile Applications for 860 on x86
References: <200001141101.MAA30605@denx.local.net> <387F0D81.48F7CABE@iname.com> <38827CD5.D7A44261@huawei.com.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

> Hi,
>
> I download a older version of sash and now it works. It can run any built-in commands , but it fails to run
> external programs , such as my test program "mytest". I put it both on / and /bin.
> "-printenv" shows "PATH=/bin:/usr/bin:/etc". When I type "mytest" or "/bin/mytest" on the command prompt ">" , it
> says "No such file or directory". And I cannot find some lines
> about  "SASH"  in init/main.c.
> Do you know why?

Sounds like it  cannot find shared objects such as libc.so. You have two choices:
1) when you link the program, add the "-static" option
2) put the necessary libraries in /lib

If you have access to a linux-ppc machine, the command ldd with tell you what libraries will be loaded when the
command executes.

>
> Thank you very much.
>
> Jim Chapman wrote:
>
> > > In message <387EDEF5.DBD612FA@huawei.com.cn> you write:
> > > >
> > > >      When I compile the SASH  with "-static" options and then replace /bin/sh with sash.
> > > > When reseting my MPC860 based board, the kernel boot normally and can show the boot messages. But at last it
> > > > cannot show the "bash#" prompt. If I input "ls" or such commands,
> > >
> > > "sash" is the standalone shell, not bash; it  will  display  a  ">  "
> > > prompt - not "bash# ".
> > >
> > > > It justs shows :
> > > >
> > > >     ls
> > > >     pid 8: killed (signal 11)
> > >
> > > Maybe you have a problem  with  you  shared  libraries.  Try  running
> > > statically  link  versions  of  some  programs first. Does this work?
> > > [Well, it should when you be able to run a shell...]
> > >
> >
> > Do "-ls" at the prompt, not "ls". Prepending "-" runs sash's builtin
> > versions, otherwise it will try to find a ls on your ramdisk like any
> > other shell. See sash's man page about all available builtin commands.
> > BTW, don't expect all standard command switches to work on those
> > builtins, since sash's versions are _very_ minimized.
> >
> > -Jim

-Jim Lewis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
