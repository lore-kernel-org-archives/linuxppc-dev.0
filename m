Message-ID: <373AD987.2E933AEF@wanadoo.fr>
Date: Thu, 13 May 1999 15:54:15 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Scilab compiling problem
References: <373A192B.F6940925@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nothing like being able to answer your own questions :)

I spent some time with the maximum-rpm book and got it running now.
The bugs were in the scilab.spec script and in the find-requires script
from rpm-3.0.1-4.

Martin Costabel wrote:
> 
> Since I had scilab running on linuxppc-R5 a long time ago, I wanted to
> give the src.rpm from the redhat powertools directory a try. After a
> little tweaking, it compiles OK and goes almost all the way through the
> process of building the binary rpm.
> 
> Right at the end, it stops after the following lines
> 
[..]
> Finding provides...
> Finding requires...
> BFD: /var/tmp/scilab-root/usr/lib/scilab-2.4.1/bin/SEpsf: invalid string
> offset 2147554304 >= 256 for section `'
[..]

These last messages were due to some braindamage in the spec file. It
tried to change binary files (instead of only shell scripts) using perl.
Here is the code from scilab.spec:

# Nuke attempts to setenv SCI from build directory.
( cd $RPM_BUILD_ROOT/usr/lib/scilab-*
  for F in `grep -l ${RPM_BUILD_DIR} ./util/* ./bin/*`
  do
    perl -pi -e "s+${RPM_BUILD_DIR}+/usr/lib+" ${F}
  done
)

These binaries are then seriously damaged. Restricting the search to
shell scripts eliminates the problem and allows rpm to successfully
build a binary rpm. 

Unfortunately, the latter then complains about unsatisfied dependencies
named "SCIDIR=../../.." and "SHELL". 

This comes from a bug in the /usr/lib/rpm/find-requires script from rpm
version rpm-3.0.1-4: This script searches not only the dependencies
given by ldd, but also the first lines of shell scripts. Unfortunately
it takes also the first lines of Makefiles, which is a bug. Here is a
patch:

--- /usr/lib/rpm/find-requires.ori      Thu May 13 15:18:08 1999
+++ /usr/lib/rpm/find-requires  Thu May 13 15:22:47 1999
@@ -7,7 +7,7 @@
 
 filelist=`sed "s/['\"]/\\\&/g"`
 exelist=`echo $filelist | xargs -r file | fgrep executable | cut -d:
-f1 `
-scriptlist=`echo $filelist | xargs -r file | egrep ":.*
(commands|script) " | cut -d: -f1 `
+scriptlist=`echo $filelist | xargs -r file | egrep ":.* (perl|script) "
| cut -d: -f1 `
 liblist=`echo $filelist | xargs -r file | grep "shared object" | cut -d
: -f1 `
 
 for f in $exelist; do

With these changes (and the replacement of the supplied glibc21 patch by
one I had found long ago), rpm now creates a working
scilab-2.4.1-1.ppc.rpm.

--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
