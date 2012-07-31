Return-Path: <gerald.schaefer@de.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp15.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 391742C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 22:40:40 +1000 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gerald.schaefer@de.ibm.com>;
 Tue, 31 Jul 2012 13:40:35 +0100
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6VCe5XW2724072
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 13:40:05 +0100
Received: from d06av05.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6VCe3cV001509
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 06:40:04 -0600
Date: Tue, 31 Jul 2012 14:40:00 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH v5 12/19] memory-hotplug: introduce new function
 arch_remove_memory()
Message-ID: <20120731144000.33fd4a0a@thinkpad>
In-Reply-To: <50166379.4090305@cn.fujitsu.com>
References: <50126B83.3050201@cn.fujitsu.com> <50126E2F.8010301@cn.fujitsu.com>
 <20120730102305.GB3631@osiris.boeblingen.de.ibm.com>
 <50166379.4090305@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
Reply-To: gerald.schaefer@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 30 Jul 2012 18:35:37 +0800
Wen Congyang <wency@cn.fujitsu.com> wrote:

> At 07/30/2012 06:23 PM, Heiko Carstens Wrote:
> > On Fri, Jul 27, 2012 at 06:32:15PM +0800, Wen Congyang wrote:
> >> We don't call __add_pages() directly in the function add_memory()
> >> because some other architecture related things need to be done
> >> before or after calling __add_pages(). So we should introduce
> >> a new function arch_remove_memory() to revert the things
> >> done in arch_add_memory().
> >>
> >> Note: the function for s390 is not implemented(I don't know how to
> >> implement it for s390).
> >=20
> > There is no hardware or firmware interface which could trigger a
> > hot memory remove on s390. So there is nothing that needs to be
> > implemented.
>=20
> Thanks for providing this information.
>=20
> According to this, arch_remove_memory() for s390 can just return
> -EBUSY.

Yes, but there is a prototype mismatch for arch_remove_memory() on s390
and also other architectures (u64 vs. unsigned long).

arch/s390/mm/init.c:262: error: conflicting types for
=E2=80=98arch_remove_memory=E2=80=99 include/linux/memory_hotplug.h:88: err=
or: previous
declaration of =E2=80=98arch_remove_memory=E2=80=99 was here

In memory_hotplug.h you have:
extern int arch_remove_memory(unsigned long start, unsigned long size);

On all archs other than x86 you have:
int arch_remove_memory(u64 start, u64 size)
