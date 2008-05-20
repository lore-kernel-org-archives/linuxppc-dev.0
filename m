Return-Path: <brking@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CAA4CDDED6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:52:41 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m4KDqc5R007115
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:52:38 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m4KDqco3094868
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:52:38 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m4KDqb8L020388
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:52:38 -0400
Message-ID: <4832D7A4.1070609@linux.vnet.ibm.com>
Date: Tue, 20 May 2008 08:52:36 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/1] ibmvscsi: Non SCSI error status fixup
References: <12112108763801-patch-mail.ibm.com>
	<18481.41759.969242.972595@gargle.gargle.HOWL>
	<1211245688.12970.0.camel@localhost>
In-Reply-To: <1211245688.12970.0.camel@localhost>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, SCSI Mailing List <linux-scsi@vger.kernel.org>
Reply-To: brking@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Mon, 2008-05-19 at 10:56 -0500, Dave Boutcher wrote:
>> On Mon, 19 May 2008 10:27:56 -0500, Brian King <brking@linux.vnet.ibm.com> said:
>>> Some versions of the Virtual I/O Server on Power
>>> return 0x99 in the non-SCSI error status field as success,
>>> rather than 0. This fixes the ibmvscsi driver to treat this
>>> response as success.
>> Yeah....0x99...that's an intuitive value for success.
> 
> Hopefully there are no versions that return 0x99 for an error? :)

There shouldn't be. 0x99 is actually not defined as a valid value for
that field, but it is what the ibmvscsis VIOS that is included in
SLES 9 and SLES 10 return on success, due to a bug in that driver.
We plan to fix the ibmvscsis driver as well, but it will take a while
for that fix to propagate. Until very recently, the status field was not
checked, which is why we are only recently running into this problem.

-Brian

-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
