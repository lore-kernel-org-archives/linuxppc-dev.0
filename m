Return-Path: <ryusuke@osrg.net>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E744B67B83
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Nov 2006 23:40:06 +1100 (EST)
Date: Thu, 30 Nov 2006 21:39:58 +0900 (JST)
Message-Id: <20061130.213958.46869121.ryusuke@osrg.net>
To: paulus@samba.org
Subject: Re: [PATCH 2.6.19-rc6] powerpc: fix of_device __must_check warning
From: Ryusuke Konishi <ryusuke@osrg.net>
In-Reply-To: <17773.18027.177795.192632@cargo.ozlabs.ibm.com>
References: <20061129.140751.48374104.ryusuke@osrg.net>
	<17773.18027.177795.192632@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Paul Mackerras wrote:
> Your patch also makes a policy change, though, in that without your
> patch, a failure in creating the "devspec" file in sysfs doesn't
> prevent of_device_register from performing its main function.  With
> your patch, of_device_register will fail if we can't create the
> "devspec" file.
>
> On the whole, I am inclined to think that it is useful for
> of_device_register to succeed even if the devspec file can't be
> created, since nothing in the kernel relies on the devspec file being
> present.
> 
> Paul.

Yes, you have a point there.

For the purpose of reference, I looked into other architectures.
Then, I found that sparc (and sparc64) had same of_device_register()
functions, and both are checking the result of device_create_file()
as follows.

in function arch/sparc/kernel/of_device.c:
>int of_device_register(struct of_device *ofdev)
>{
>        int rc;
>
>        BUG_ON(ofdev->node == NULL);
>
>        rc = device_register(&ofdev->dev);
>        if (rc)
>                return rc;
>
>        rc = device_create_file(&ofdev->dev, &dev_attr_devspec);
>        if (rc)
>                device_unregister(&ofdev->dev);
>
>        return rc;
>}

But then, I'd like to respect your point of view,
and I won't stick to this case example.

Ryusuke.
