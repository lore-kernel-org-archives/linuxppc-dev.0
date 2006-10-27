Return-Path: <jmwoo2@yahoo.com>
Received: from web50315.mail.yahoo.com (web50315.mail.yahoo.com
	[206.190.39.228]) by ozlabs.org (Postfix) with SMTP id 1A0AE67DDD
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 04:27:55 +1000 (EST)
Message-ID: <20061027182114.24662.qmail@web50315.mail.yahoo.com>
Date: Fri, 27 Oct 2006 11:21:14 -0700 (PDT)
From: John W <jmwoo2@yahoo.com>
Subject: Building ELDK 3.0/3.1 from SRPMS
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello-

I having trouble rebuilding ELDK 3.0 & ELDK 3.1 from
the source RPMS.  I have spent a great deal of time on
this, and I have a feeling that maybe I’m just not
doing something correctly (setting up the build
environment, retrieving source/specs from CVS..
etc..).  My build machine is Red Hat 9.0 without any
updates (Kernel 2.4.20-8, the Shrike release).

The following is the process I’m using to setup my
development environment for ELDK 3.0

#Make build directory
mkdir /opt/eldkv3.0

#checkout tarballs & build.  One caveat is that I’m
behind a proxy server, and I’m having to check these
files out on remote computer, and tar -czvf the
directories up, and copying the files to the build
computer. I would imagine that this is functionally
equivalent.

cd /opt/eldkv3.0
cvs -d :pserver:anonymous@www.denx.de:/cvsroot login
cvs -z6 -d :pserver:anonymous@www.denx.de:/cvsroot co
-rELDK_3_0 -P eldk_tarballs
cvs -z6 -d :pserver:anonymous@www.denx.de:/cvsroot co
-rELDK_3_0 -P eldk_build

#get yellowdog 3.0 prestine SRPMS
cd /opt/eldkv3.0
mkdir SRPMS
cd /opt/eldkv3.0/SRPMS
wget -r -nd -np -l1 -A ‘*.rpm’
http://ydl.osuosl.org/releases/yellowdog-3.0/en/os/SRPMS/
wget -r -nd -np -l1 -A ‘*.rpm’
http://ydl.osuosl.org/updates/yellowdog-3.0/SRPMS/

#export the prefix & target architecture
export ELDK_PREFIX=/opt/eldkv3.0
export TARGET_CPU_FAMILY_LIST=”4xx”

#execute build process
cd /opt/eldkv3.0/build
./ELDK_BUILD

Executing ELDK_BUILD seems to build almost everything,
but there seems to be a lot of packages missing,
namely libstdc++.so.  When checking the logs, I see
something suspicious while build the make RPM in that
it shows the following failure:
/opt/eldkv3.0/build/ppc-2006-10-27/logs/build_make.log:
….
checking for waitpid... yes
checking for wait3... yes
checking for union wait... no
checking for sys_siglist declaration in signal.h or
unistd.h... yes
checking for library containing getpwnam... none
required
checking for location of SCCS get command... get
checking if system libc has GNU glob... yes
updating cache ./config.cache
creating ./config.status
creating build.sh
creating Makefile
creating glob/Makefile
creating i18n/Makefile
creating config.h
+ make
cd . && aclocal
cd . && automake --gnu --include-deps Makefile
Makefile.am: required file `./depcomp' not found
make: *** [Makefile.in] Error 1
error: Bad exit status from
/opt/eldkv3.0/build/ppc-2006-10-27/work/var/tmp/rpm-tmp.54649
(%build)


RPM build errors:
    Bad exit status from
/opt/eldkv3.0/build/ppc-2006-10-27/work/var/tmp/rpm-tmp.54649
(%build)

I’m not exactly sure that by fixing this problem will
install libstdc++ correctly, infact, I’m not exactly
sure why ELDK is not completely building everything. 
In trying to remedy this problem, I have upgraded my
system to use autoconf 2.60, automake 1.9 and m4
1.4.7, but none of those seems to help.  The only
other thing I can think of is upgrading my version of
bison.

I have also tried the same type of method to build
ELDK 3.1 from SRPMS, and have received the same error
from the build_make.log file.

Any help would be greatly appreciated!

John M. Woo
jmwoo2 <at> yahoo.com


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
