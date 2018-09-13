Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429g4Z3KbSzF3MW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 10:48:29 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8D0dWN0016059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 20:48:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mfb9fvmxg-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 20:48:26 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 13 Sep 2018 01:48:24 +0100
Subject: Re: [PATCH v2 03/17] compat_ioctl: use correct compat_ptr()
 translation in drivers
To: Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Frank Haverkamp <haver@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Felipe Balbi <balbi@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
 linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912150142.157913-3-arnd@arndb.de>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 13 Sep 2018 10:48:15 +1000
MIME-Version: 1.0
In-Reply-To: <20180912150142.157913-3-arnd@arndb.de>
Message-Id: <11132252-c6ba-8b53-9314-f91e77574eba@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/09/18 01:01, Arnd Bergmann wrote:
> A handful of drivers all have a trivial wrapper around their ioctl
> handler, but don't call the compat_ptr() conversion function at the
> moment. In practice this does not matter, since none of them are used
> on the s390 architecture and for all other architectures, compat_ptr()
> does not do anything, but using the new generic_compat_ioctl_ptrarg
> helper makes it more correct in theory, and simplifies the code.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For cxl:

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
