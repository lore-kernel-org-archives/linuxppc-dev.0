Message-Id: <200103071915.OAA22062@mal-ach.watson.ibm.com>
To: Alexandre.Nikolaev@matrox.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: who loads argc in elf binary??????? 
In-Reply-To: Message from Daniel Jacobowitz <dmj+@andrew.cmu.edu>
   of "Wed, 07 Mar 2001 14:10:14 EST." <20010307141014.A28040@nevyn.them.org>
Date: Wed, 07 Mar 2001 14:15:06 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	I believe that glibc (including the ld.so dynamic linker) extract
the arguments and place them into registers before calling main().

	For instance, glibc sysdeps/unix/sysv/linux/powerpc/dl-sysdep.c
defines a macro called

DL_FIND_ARG_COMPONENTS(cookie, argc, argv, envp, auxp)

which is used by glibc to extract argc/argv/envp from the auxilliary
argument block.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
