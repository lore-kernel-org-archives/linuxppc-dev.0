Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75C291A0814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 16:16:27 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1400631189.3986.145.camel@pasglop>
Date: Wed, 21 May 2014 08:16:20 +0200
Message-Id: <4B606C3E-66D1-4B0B-A6B7-5EFC5019168C@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140520115606.GB20397@shangw>
 <537B4740.6090806@suse.de> <20140520124504.GB28441@shangw>
 <537B5D85.3010305@suse.de> <1400631189.3986.145.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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



> Am 21.05.2014 um 02:13 schrieb Benjamin Herrenschmidt <benh@kernel.crashin=
g.org>:
>=20
>> On Tue, 2014-05-20 at 15:49 +0200, Alexander Graf wrote:
>> Instead of
>>=20
>>   if (passed_flag)
>>     return;
>>=20
>> you would do
>>=20
>>   if (trigger_irqfd) {
>>     trigger_irqfd();
>>     return;
>>   }
>>=20
>> which would be a much nicer, generic interface.
>=20
> But that's not how PAPR works.

But it's what a non-QEMU VFIO user would want, and it should be easy to impl=
ement.


Alex
