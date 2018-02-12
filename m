Return-Path: <srs0=4l9b=fg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgHGp3CFFzF0nr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:25:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zgHGn6znjz8x0g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:25:21 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zgHGn1c6vz9t34
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2018 07:25:21 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1CKNnEv127358
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2018 15:25:19 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g3g84v6nn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Feb 2018 15:25:17 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 13:25:16 -0700
Date: Mon, 12 Feb 2018 12:25:10 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] powerpc/vas: Fix cleanup when VAS is not configured
References: <1518234567-24869-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1518234567-24869-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <87d11awzkp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87d11awzkp.fsf@concordia.ellerman.id.au>
Message-Id: <20180212202510.GB28183@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> 
> > When VAS is not configured in the system, make sure to remove
> > the VAS debugfs directory and unregister the platform driver.
> >
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ...
> > diff --git a/arch/powerpc/platforms/powernv/vas.c b/arch/powerpc/platforms/powernv/vas.c
> > index aebbe95..f83e27d8 100644
> > --- a/arch/powerpc/platforms/powernv/vas.c
> > +++ b/arch/powerpc/platforms/powernv/vas.c
> > @@ -169,8 +169,11 @@ static int __init vas_init(void)
> >  		found++;
> >  	}
> >  
> > -	if (!found)
> > +	if (!found) {
> > +		platform_driver_unregister(&vas_driver);
> > +		vas_cleanup_dbgdir();
> >  		return -ENODEV;
> > +	}
> 
> The better patch would be to move the call to vas_init_dbgdir() down
> here, where we know we have successfully registered the driver.

Well, when VAS is configured, init_vas_instance() expects the top level
"vas" debugfs dir to already be setup.

We could have each init_vas_instance() assume it is the first and
unconditionally call vas_init_dbgdir(). vas_init_dbgdir() could make
sure to initialize only once.

Or, we could make a separate pass countng "ibm,vas" nodes. If there are
none, skip both steps (dbgdir and registering platform driver).

Sukadev
