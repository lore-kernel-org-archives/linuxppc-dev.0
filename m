Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 800621A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 14:49:11 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 26 Jun 2014 00:49:09 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2BFF638C8027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 00:49:05 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5Q4n5f13604986
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 04:49:05 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q4n4wV003765
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 00:49:04 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v1 2/3] powerpc/powernv: Support PCI error injection
In-Reply-To: <20140625000524.GA6632@shangw>
References: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403489682-14841-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <1403505404.28453.7.camel@ale.ozlabs.ibm.com> <20140625000524.GA6632@shangw>
Date: Thu, 26 Jun 2014 14:48:59 +1000
Message-ID: <m38uokuvgk.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, agraf@suse.de, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
> On Mon, Jun 23, 2014 at 04:36:44PM +1000, Michael Neuling wrote:
>>On Mon, 2014-06-23 at 12:14 +1000, Gavin Shan wrote:
>>> The patch implements one OPAL firmware sysfs file to support PCI error
>>> injection: "/sys/firmware/opal/errinjct", which will be used like the
>>> way described as follows.
>>> 
>>> According to PAPR spec, there are 3 RTAS calls related to error injection:
>>> "ibm,open-errinjct": allocate token prior to doing error injection.
>>> "ibm,close-errinjct": release the token allocated from "ibm,open-errinjct".
>>> "ibm,errinjct": do error injection.
>>> 
>>> Sysfs file /sys/firmware/opal/errinjct accepts strings that have fixed
>>> format "ei_token ...". For now, we only support 32-bits and 64-bits
>>> PCI error injection and they should have following strings written to
>>> /sys/firmware/opal/errinjct as follows. We don't have corresponding
>>> sysfs files for "ibm,open-errinjct" and "ibm,close-errinjct", which
>>> means that we rely on userland to maintain the token by itself.
>>
>>This sounds cool.  
>>
>>Can you document the sysfs interface in Documentation/powerpc?
>>
>
> Yeah, Documentation/powerpc/eeh-pci-error-recovery.txt needs update
> as Ben suggested. It's something in my list :-)

It should probably also/instead be in
Documentation/ABI/(testing|stable)/sysfs-firmware-opal-errinjct  as this
seems to be where sysfs bits get documented.

Also, considering that we're specifically looking at PCI error
injection, should the sysfs name be /sys/firmware/opal/pci-error-inject
instead?
