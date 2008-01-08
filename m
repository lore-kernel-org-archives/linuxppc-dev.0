Return-Path: <jeff.parent@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 4846ADE075
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 08:39:09 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so3922133fgg.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 08 Jan 2008 13:39:08 -0800 (PST)
Message-ID: <464e946e0801081339o2585362ci5b209154a8526089@mail.gmail.com>
Date: Tue, 8 Jan 2008 15:39:07 -0600
From: "Jeff Parent" <jeff.parent@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: PowerPC Cross Compiler's Arch doesnt match
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_19757_29496859.1199828348011"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_19757_29496859.1199828348011
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm building a linux distro for work, that runs on embedded systems with
either and ARM 9 or a PowerPC 603.  I've had great luck building a cross
compiler w/ crosstools and using them in the compiler jail created by
Scratchbox.  Now I am working on porting all my work to the PowerPC.  When I
build the cross compilers I have selected GCC-4.0.1 and GLIBC-2.3.5 for both
setups.  I create my jail in Scratchbox for the PowerPC and try compiling
any of the GNU applications and when running the configure script I get:

<./configure for sed-4.1.5>
checking build system type... config/config.guess: unable to guess system
type

This script, last modified 2008-01-08, has failed to recognize
the operating system you are using. It is advised that you
download the most up to date version of the config scripts from


http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess
and

http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub

If the version you run (./config.guess.old) is already up to date, please
send the following data and any information you think might be
pertinent to <config-patches@gnu.org> in order to provide the needed
information to handle your system.

config.guess timestamp = 2008-01-08

uname -m = powerpc
uname -r = 2.6.18-5-686
uname -s = Linux
uname -v = #1 SMP Fri Jun 1 00:47:00 UTC 2007

/usr/bin/uname -p =
/bin/uname -X     =

hostinfo               =
/bin/universe          =
/usr/bin/arch -k       = powerpc
/bin/arch              = powerpc
/usr/bin/oslevel       =
/usr/convex/getsysinfo =

UNAME_MACHINE = powerpc
UNAME_RELEASE = 2.6.18-5-686
UNAME_SYSTEM  = Linux
UNAME_VERSION = #1 SMP Fri Jun 1 00:47:00 UTC 2007
configure: error: cannot guess build type; you must specify one
[sbox-PPC: ~/devel/packages/sed/sed-4.1.5] >


So I looked into configure.guess and I find:

UNAME_MACHINE=`(uname -m) 2>/dev/null` || UNAME_MACHINE=unknown
UNAME_RELEASE=`(uname -r) 2>/dev/null` || UNAME_RELEASE=unknown
UNAME_SYSTEM=`(uname -s) 2>/dev/null`  || UNAME_SYSTEM=unknown
UNAME_VERSION=`(uname -v) 2>/dev/null` || UNAME_VERSION=unknown

# Note: order is significant - the case branches are not exclusive.
case "${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}" in
<A bunch of Case Statements>
ppc:Linux:*:*)
	echo powerpc-unknown-linux-gnu
	exit ;;
<More Case Statements.>

However I do not see a case where the UNAME_MACHINE is set to powerpc, other
than for the Machten.  Is there something I did wrong when creating my
cross-compiler?


-- 
------------------------------------------------------------------
Jeff Parent
Computer Engineer

------=_Part_19757_29496859.1199828348011
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I&#39;m building a linux distro for work, that runs on embedded systems
with either and ARM 9 or a PowerPC 603.&nbsp; I&#39;ve had great luck building a
cross compiler w/ crosstools and using them in the compiler jail
created by Scratchbox.&nbsp; Now I am working on porting all my work to the
PowerPC.&nbsp; When I build the cross compilers I have selected GCC-4.0.1
and GLIBC-2.3.5 for both setups.&nbsp; I create my jail in Scratchbox for
the PowerPC and try compiling any of the GNU applications and when
running the configure script I get:<br><br>&lt;./configure for sed-4.1.5&gt;
<br>checking build system type... config/config.guess: unable to guess system type<br><br>This script, last modified 2008-01-08, has failed to recognize<br>the operating system you are using. It is advised that you<br>download the most up to date version of the config scripts from
<br><br>&nbsp; <a href="http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess" target="_blank">http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.guess</a><br>and<br>&nbsp; <a href="http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub" target="_blank">

http://savannah.gnu.org/cgi-bin/viewcvs/*checkout*/config/config/config.sub</a><br><br>If the version you run (./config.guess.old) is already up to date, please<br>send the following data and any information you think might be
<br>pertinent to &lt;<a href="mailto:config-patches@gnu.org" target="_blank">config-patches@gnu.org</a>&gt; in order to provide the needed<br>information to handle your system.<br><br>config.guess timestamp = 2008-01-08<br>
<br>uname -m = powerpc
<br>uname -r = 2.6.18-5-686<br>uname -s = Linux<br>uname -v = #1 SMP Fri Jun 1 00:47:00 UTC 2007<br><br>/usr/bin/uname -p =<br>/bin/uname -X&nbsp;&nbsp;&nbsp;&nbsp; =<br><br>hostinfo&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =<br>/bin/universe&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =<br>/usr/bin/arch -k&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = powerpc
<br>/bin/arch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = powerpc<br>/usr/bin/oslevel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =<br>/usr/convex/getsysinfo =<br><br>UNAME_MACHINE = powerpc<br>UNAME_RELEASE = 2.6.18-5-686<br>UNAME_SYSTEM&nbsp; = Linux<br>UNAME_VERSION = #1 SMP Fri Jun 1 00:47:00 UTC 2007
<br>configure: error: cannot guess build type; you must specify one<br>[sbox-PPC: ~/devel/packages/sed/sed-4.1.5] &gt;<br><br><br clear="all">So I looked into 
configure.guess and I find:<br><br style="font-family: arial,sans-serif;"><pre style="font-family: arial,sans-serif;">UNAME_MACHINE=`(uname -m) 2&gt;/dev/null` || UNAME_MACHINE=unknown<br>UNAME_RELEASE=`(uname -r) 2&gt;/dev/null` || UNAME_RELEASE=unknown
<br>UNAME_SYSTEM=`(uname -s) 2&gt;/dev/null`  || UNAME_SYSTEM=unknown<br>UNAME_VERSION=`(uname -v) 2&gt;/dev/null` || UNAME_VERSION=unknown<br><br># Note: order is significant - the case branches are not exclusive.<br>case &quot;${UNAME_MACHINE}:${UNAME_SYSTEM}:${UNAME_RELEASE}:${UNAME_VERSION}&quot; in
<br><span style="font-family: arial,sans-serif;">&lt;A bunch of Case Statements&gt;<br></span>ppc:Linux:*:*)<br>	echo powerpc-unknown-linux-gnu<br>	exit ;;<br>&lt;More Case Statements.&gt;<br></pre><span style="font-family: arial,sans-serif;">
However
I do not see a case where the UNAME_MACHINE is set to powerpc, other
than for the Machten.&nbsp; Is there something I did wrong when creating my
cross-compiler?
<br></span><br clear="all"><br>-- <br>------------------------------------------------------------------<br>Jeff Parent<br>Computer Engineer

------=_Part_19757_29496859.1199828348011--
