Return-Path: <caz.yokoyama@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id E50EF1A0BFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 03:58:34 +1100 (AEDT)
From: "Yokoyama, Caz" <caz.yokoyama@intel.com>
To: Daniel Borkmann <dborkman@redhat.com>
Subject: RE: ppc64 and Documentation/mic/mpssd/mpssd.c issues
Date: Thu, 4 Dec 2014 16:48:20 +0000
Message-ID: <45C67EF7794AF747A87A45C9E1CC1B97926A6AFD@ORSMSX105.amr.corp.intel.com>
References: <54806490.6080303@redhat.com>
In-Reply-To: <54806490.6080303@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Dutt,
 Sudeep" <sudeep.dutt@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you for the report.
Have you tried to compile on x86_64? Which rhel do you use? Rhel6.X?
MIC card is expected to work with x86_64 host, not with ppc64. We have neve=
r compiled on ppc host while our primary development platform was rhel6.X.

Line 92 is the first use of htole16 and MIC_VRING_ENTRIES. Is there any cha=
nge on them?

Thank you.
-caz, Caz.Yokoyama@intel.com, yokoyama@member.fsf.org


-----Original Message-----
From: Daniel Borkmann [mailto:dborkman@redhat.com]=20
Sent: Thursday, December 04, 2014 5:42 AM
To: Yokoyama, Caz
Cc: benh@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org
Subject: ppc64 and Documentation/mic/mpssd/mpssd.c issues

Hi Caz,

I think commit ...

commit 8d49751580db804a02caf6a5b7cebe2ff26c0d7e
Author: Caz Yokoyama <Caz.Yokoyama@intel.com>
Date:   Thu Sep 5 16:42:39 2013 -0700

     Sample Implementation of Intel MIC User Space Daemon.

... actually triggers a build error on my default config
ppc64 (I'm using net-next tree):

   HOSTCC  Documentation/mic/mpssd/mpssd.o
Documentation/mic/mpssd/mpssd.c:93: error: braced-group within expression a=
llowed only inside a function
Documentation/mic/mpssd/mpssd.c:96: error: braced-group within expression a=
llowed only inside a function
Documentation/mic/mpssd/mpssd.c:113: error: braced-group within expression =
allowed only inside a function
Documentation/mic/mpssd/mpssd.c:116: error: braced-group within expression =
allowed only inside a function
Documentation/mic/mpssd/mpssd.c:119: error: braced-group within expression =
allowed only inside a function
Documentation/mic/mpssd/mpssd.c:146: error: braced-group within expression =
allowed only inside a function
Documentation/mic/mpssd/mpssd.c:149: error: braced-group within expression =
allowed only inside a function
Documentation/mic/mpssd/mpssd.c:151: error: braced-group within expression =
allowed only inside a function
Documentation/mic/mpssd/mpssd.c:152: error: braced-group within expression =
allowed only inside a function
make[3]: *** [Documentation/mic/mpssd/mpssd.o] Error 1
make[2]: *** [Documentation/mic/mpssd] Error 2
make[1]: *** [Documentation/mic] Error 2
make: *** [vmlinux] Error 2

gcc --version
gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-11)

Cheers,
Daniel
