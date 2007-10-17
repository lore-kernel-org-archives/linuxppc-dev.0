Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 151C1DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 01:22:10 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l9HFLgtw433318
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 15:21:42 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l9HFLgGc2867332
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:21:42 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l9HFLP10032221
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 16:21:25 +0100
From: Joachim Fenkes <fenkes@de.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 4/5] ibmebus: Move to of_device and of_platform_driver,
	match eHCA and eHEA drivers
Date: Wed, 17 Oct 2007 17:21:07 +0200
References: <OF48E0997F.B61F7220-ONC125736F.002D7F06-C125736F.002DD39C@de.ibm.com>
	<200710162320.00630.fenkes@de.ibm.com>
	<20071017012706.adbd3188.sfr@canb.auug.org.au>
In-Reply-To: <20071017012706.adbd3188.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710171721.08565.fenkes@de.ibm.com>
Cc: Thomas Q Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Paul Mackerras <pmac@au1.ibm.com>, netdev@vger.kernel.org,
	Jan-Bernd Themann <THEMANN@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 16 October 2007 17:27, Stephen Rothwell wrote:

> One small change - I intend to remove the name and owner fields from
> struct of_platform_driver, so you should not bother initialising the name
> field and just initialise the name field of the embedded struct
> device_driver instead.  This, of course, means that you don't need
> 
> 	drv->driver.name = drv->name;
> 
> in ibmebus_register_driver.

I'd prefer to let this line stay in place until you actually make your
change, to keep the data structures consistent as long as the name field is
present. You could remove it in your patch then.

Regards,
  Joachim
