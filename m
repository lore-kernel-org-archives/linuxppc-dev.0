Date: Fri, 2 Apr 2004 08:42:05 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Insmod trouble
Message-ID: <20040402064205.GB22365@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DAAE@ismail.innsys.innovsys.com>
Mime-Version: 1.0
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DAAE@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> proc_sysinfo: Unknown symbol __fixsfsi
> proc_sysinfo: Unknown symbol __subsf3
> proc_sysinfo: Unknown symbol __extendsfdf2
> proc_sysinfo: Unknown symbol __floatsisf
> proc_sysinfo: Unknown symbol __muldf3
> proc_sysinfo: Unknown symbol __truncdfsf2
> proc_sysinfo: Unknown symbol __mulsf3
> proc_sysinfo: Unknown symbol __addsf3

I would assume that these functions are not compiled in the kernel.
While compiling them as modules, the compiler assumes (via the include
file) that they are external and will not complain about these.

Double check if the source files that contain this functionality are
compiled and linked in the code. You can try to quick-'fix' it by static
inlining these functions in you module.

Maybe these functions assume some architecture and are in a conditional
ifdef CONFIG_XXX flag.

  marc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
