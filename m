Return-Path: <aruna@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42AF12C0090
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 19:42:30 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Jun 2013 19:35:11 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 707152BB0051
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 19:42:25 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R9gGjk54329574
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 19:42:16 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R9gNVC031780
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 19:42:25 +1000
Message-ID: <51CC08FC.6000301@linux.vnet.ibm.com>
Date: Thu, 27 Jun 2013 15:12:20 +0530
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 3/3] powerpc/pseries: Support compression of oops text
 via pstore
References: <20130624061936.12963.72529.stgit@aruna-ThinkPad-T420>
 <20130624062316.12963.87911.stgit@aruna-ThinkPad-T420>
 <CAGXu5jJezRynWEBmmH8wp=pt1yEjukhe6Pg_aRcZP7E6t-1R=g@mail.gmail.com>
 <51C94101.3030702@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31C5376F@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31C5376F@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 Kees Cook <keescook@chromium.org>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 Colin Cross <ccross@android.com>, LKML <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "paulus@samba.org" <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Tony,

On Tuesday 25 June 2013 09:32 PM, Luck, Tony wrote:
>> Introducing headersize in pstore_write() API would need changes at
>> multiple places whereits being called. The idea is to move the
>> compression support to pstore infrastructure so that other platforms
>> could also make use of it.
> Any thoughts on the back/forward compatibility as we switch to compressed
> pstore data?   E.g. imagine I have a system installed with some Linux distribution
> with a kernel too old to know about compressed pstore. I use that machine to
> run the latest kernels that do compression ... and one fine day one of them crashes
> hard - logging in compressed form to pstore. Now I boot my distro kernel to pick
> up the pieces ... what do I see in /sys/fs/pstore/*? Some compressed files? Can I
> read them with some tool?
>
> This somewhat of a corner case - but not completely unrealistic ... I'd at least
> like to be reassured that the old kernel won't choke when it sees the compressed
> blobs.

openssl command line tool can be used to decompress the compressed data of
the pstore file in the above scenario.

Usage:

cat <file> | openssl zlib -d

> -Tony
>
