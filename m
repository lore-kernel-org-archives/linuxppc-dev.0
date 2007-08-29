Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 44115DDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 04:12:57 +1000 (EST)
Date: Wed, 29 Aug 2007 13:12:32 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Joachim Fenkes <fenkes@de.ibm.com>
Subject: Re: [PATCH 2.6.23] ibmebus: Prevent bus_id collisions
Message-ID: <20070829181232.GB23140@localdomain>
References: <200708291815.18197.fenkes@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200708291815.18197.fenkes@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi-

Joachim Fenkes wrote:
> Previously, ibmebus derived a device's bus_id from its location code. The
> location code is not guaranteed to be unique, so we might get bus_id
> collisions if two devices share the same location code. The OFDT full_name,
> however, is unique, so we use that instead.

This is a userspace-visible change, but I guess it's unavoidable.
Will anything break?

Also, I dislike this approach of duplicating the firmware device tree
path in sysfs.  Are GX/ibmebus devices guaranteed to be children of
the same node in the OF device tree?  If so, their unit addresses will
be unique, and therefore suitable values for bus_id.  I believe this
is what the powerpc vio bus code does.
