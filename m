Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zg1FT24WxzF0mG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 20:53:13 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1C9q0UR053529
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 04:53:10 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g30fv7p88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 04:53:10 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 09:53:08 -0000
Subject: Re: linux-4.16-rc1/drivers/misc/ocxl/file.c:320:broken error checking
 ?
To: David Binderman <dcb314@hotmail.com>,
 "andrew.donnellan@au1.ibm.com" <andrew.donnellan@au1.ibm.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HE1PR0802MB23312F7C9FFE65D802F9D0259CF70@HE1PR0802MB2331.eurprd08.prod.outlook.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 10:53:02 +0100
MIME-Version: 1.0
In-Reply-To: <HE1PR0802MB23312F7C9FFE65D802F9D0259CF70@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <6e051309-c236-7715-cffb-b53d2da600b3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/02/2018 à 09:58, David Binderman a écrit :
> Hello there,
> 
> 
> linux-4.16-rc1/drivers/misc/ocxl/file.c:320]: (style) Checking if 
> unsigned variable 'used' is less than zero.
> 
> Source code is
> 
> 
>         used = append_xsl_error(ctx, &header, buf + sizeof(header));
>          if (used < 0)
>              return used;
> 
> Suggest put return value from function into signed variable, sanity 
> check it,
> 
> then assign it to an unsigned variable.
> 
> 
> Also, use of the gcc compiler flag -Wtype-limits will show up this kind 
> of problem in future.

Thanks for reporting it. A patch to address it is working its way up and 
should land in the next rc release.

   Fred


> 
> Regards
> 
> 
> David Binderman
> 
> 
