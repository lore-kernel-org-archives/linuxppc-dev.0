Mime-Version: 1.0
Message-Id: <v0420550bb42a7373f2ac@[206.163.71.146]>
In-Reply-To: <Pine.LNX.4.10.9910102158200.793-100000@idd-01.imbc.gr>
References: <Pine.LNX.4.10.9910102158200.793-100000@idd-01.imbc.gr>
Date: Wed, 13 Oct 1999 10:49:25 -0700
To: Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: MySQL at Linux/PPC
Cc: debian-powerpc@lists.debian.org, mysql@lists.mysql.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 09:19 +0300 1999-10-13, Kostas Gewrgiou wrote:
>After looking at Bug#: 5732 in RedHat's bugzilla,
>(http://developer.redhat.com/bugzilla/show_bug.cgi?id=5732)
>i found out why enabling LFS makes a bad mysql binary, quoting from the
>description of the patch bug:
>
>   The configure scripts of patch-2.5 detect the LFS support in
>   glibc-2.1, but due to the lack of a definition of
>   _GNU_SOURCE, no prototypes for fseeko are declared. That way
>   the compiler thinks fseeko is taking a 32bit argument for
>   the offset, when in reality it takes a 64bit offset.
>
>After compiling MySQL with -D_GNU_SOURCE (with LFS enabled) the problems
>went away, i am not sure if defining _LARGEFILE_SOURCE is supposed to give
>the fseeko declarations but if it is then its a bug in the glibc headers.

The glibc documentation says that _LARGEFILE_SOURCE is supposed to 
give the fseeko declaration.

  - Macro: _LARGEFILE_SOURCE
      If this macro is defined some extra functions are available which
      rectify a few shortcomings in all previous standards.  More
      concrete the functions `fseeko' and `ftello' are available.
      Without these functions the difference between the ISO C interface
      (`fseek', `ftell') and the low-level POSIX interface (`lseek')
      would lead to problems.

      This macro was introduced as part of the Large File Support
      extension (LFS).
-- 
Joel Klecker (aka Espy)                    Debian GNU/Linux Developer
<URL:mailto:jk@espy.org>                 <URL:mailto:espy@debian.org>
<URL:http://web.espy.org/>               <URL:http://www.debian.org/>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
