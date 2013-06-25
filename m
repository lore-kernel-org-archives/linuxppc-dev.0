Return-Path: <tony.luck@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 3B8E42C008A
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Jun 2013 02:03:05 +1000 (EST)
From: "Luck, Tony" <tony.luck@intel.com>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>, Kees Cook
 <keescook@chromium.org>
Subject: RE: [PATCH 3/3] powerpc/pseries: Support compression of oops text
 via pstore
Date: Tue, 25 Jun 2013 16:02:58 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31C5376F@ORSMSX106.amr.corp.intel.com>
References: <20130624061936.12963.72529.stgit@aruna-ThinkPad-T420>
 <20130624062316.12963.87911.stgit@aruna-ThinkPad-T420>
 <CAGXu5jJezRynWEBmmH8wp=pt1yEjukhe6Pg_aRcZP7E6t-1R=g@mail.gmail.com>
 <51C94101.3030702@linux.vnet.ibm.com>
In-Reply-To: <51C94101.3030702@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 Colin Cross <ccross@android.com>, LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Introducing headersize in pstore_write() API would need changes at
> multiple places whereits being called. The idea is to move the
> compression support to pstore infrastructure so that other platforms
> could also make use of it.

Any thoughts on the back/forward compatibility as we switch to compressed
pstore data?   E.g. imagine I have a system installed with some Linux distr=
ibution
with a kernel too old to know about compressed pstore. I use that machine t=
o
run the latest kernels that do compression ... and one fine day one of them=
 crashes
hard - logging in compressed form to pstore. Now I boot my distro kernel to=
 pick
up the pieces ... what do I see in /sys/fs/pstore/*? Some compressed files?=
 Can I
read them with some tool?

This somewhat of a corner case - but not completely unrealistic ... I'd at =
least
like to be reassured that the old kernel won't choke when it sees the compr=
essed
blobs.

-Tony
