Message-ID: <001b01c389cd$c3f30310$0202a8c0@homevl9biy3v7e>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <20031002121733.A2E32C59E4@atlas.denx.de> <001101c3894c$38833ab0$2803050a@JackyLam> <3F7D3238.2090400@bluewin.ch> <00df01c38992$6d179b40$2803050a@JackyLam> <3F7D9F72.9020700@kegel.com>
Subject: Re: Queston about Walnut
Date: Sat, 4 Oct 2003 00:45:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


----- Original Message -----
From: "Dan Kegel" <dank@kegel.com>
To: "Jacky Lam" <jackylam@astri.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Saturday, October 04, 2003 12:10 AM
Subject: Re: Queston about Walnut



>  >     I use toolchain gcc 3.2.3, glibc 2.2.5 because I have some trouble
to
>  > compile to newest one (it requests my host gcc >=3.1). Is this related?
If
>  > yes, I would tried to reinstall my RedHat to newer version, but it
would be
>  > painful.....
>
> Why painful?  It's as easy as this:

    No. The story is like this....

    I upgrade my gcc to 3.3.1 on my host and start to compile my cross
toolchain. However, while it is compiling gcc, it has strange error that I
have never seen (seems gcc has made something that ld can't understand). So,
I guess gcc 3.3.1 may not work very well with my old glibc (provided in
RedHat 7.2). I don't know how to upgrade glibc safely and make it compatible
to existing applications. That's why I would like to upgrade the whole
Redhat.....and this is painful...

>
> ----------
> wget ftp://ftp.gnu.org/gnu/gcc/gcc-3.3.1.tar.gz
> tar -xzvf gcc-3.3.1.tar.gz
> mkdir build-gcc
> cd build-gcc
>
../gcc-3.3.1/configure --prefix=/usr/local/gcc-3.3.1 --enable-languages=c,c+
+
> make
> sudo make install
> ----------
>
> Then put /usr/local/gcc-3.3.1/bin in your PATH before anything else, and
you're done.
>
> BTW here's the (awful) script I used to grab the kernel.  (It reveals my
> total lack of knowledge of bitkeeper; I think 'bk export' is preferred
> to my clumsy removal of CVS directories.)
>
> #!/bin/sh
>
> if [ -z $1 ]; then
>          echo "Usage: `basename $0` TAG"
>          echo "Example: `basename $0` v2.4.18"
>          echo "Purpose: fetch a kernel source tarball from the
linuxppc_2_4_devel tree"
>          exit 1
> fi
> set -x -e
>
> rm -rf linux linuxppc_2_4_devel-$1 || /bin/true
>
> # Download bk from http://www.bitkeeper.com
> bk clone -r$1 bk://ppc.bkserver.net/linuxppc_2_4_devel
linuxppc_2_4_devel-$1
> cd linuxppc_2_4_devel-$1
> find . -type d -exec bk get {} \;
>
> # Hey!  nonxargs version fails with 'find: no such file foo/SCCS' after
deleting foo/SCCS!
> # Bug in gnu find 4.1.7?  Or in kernel 2.4.18?  Who knows...
> #find . -name SCCS -exec rm {} \;
> find . -name SCCS -print | xargs rm -rf
>
> rm -rf RESYNC/
> rm -rf PENDING/
> rm -rf BitKeeper/
> rm -f ChangeSet
> cd ..
> mv linuxppc_2_4_devel-$1 linux
>
>
>
> --
> Dan Kegel
> http://www.kegel.com
> http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045
>
>
>
        I use CVS to grab the linuxppc-2.4-devel module. Is it the same as
that? Thanks.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
