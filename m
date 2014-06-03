Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60CA81A0840
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 17:45:34 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20140603055415.GA24370@iris.ozlabs.ibm.com>
Date: Tue, 3 Jun 2014 09:45:27 +0200
Message-Id: <5C4E374F-0BE1-4BE3-991C-E6BD64E90E6A@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140603055415.GA24370@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 03.06.2014 um 07:54 schrieb Paul Mackerras <paulus@samba.org>:
>=20
>> On Tue, May 20, 2014 at 01:25:11PM +0200, Alexander Graf wrote:
>>=20
>>> On 20.05.14 10:30, Gavin Shan wrote:
>>> If we detects frozen state on PE that has been passed to guest, we
>>> needn't handle it. Instead, we rely on the guest to detect and recover
>>> it. The patch avoid EEH event on the frozen passed PE so that the guest
>>> can have chance to handle that.
>>>=20
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>=20
>> How does the guest learn about this failure? We'd need to inject an error=

>> into it, no?
>>=20
>> I think what you want is an irqfd that the in-kernel eeh code notifies wh=
en
>> it sees a failure. When such an fd exists, the kernel skips its own error=

>> handling.
>=20
> Well... we don't have irqfd support for book3s HV upstream yet.  The
> way the current code is, we have to turn on GSI routing, which puts a
> hard and relatively small limit on the hardware IRQ numbers we can use
> as it uses a flat array indexed by hardware IRQ number.  Which is a
> problem that I need to solve somehow,

Please sync up with the ARM folks on this - they were also unhappy about the=
 routing requirements for irqfd ;).

> but it makes using an irqfd
> unattractive in the short term.

For EEH it could as well be a dumb eventfd - really just a side channel that=
 can tell user space that something happened asynchronously :).


Alex
