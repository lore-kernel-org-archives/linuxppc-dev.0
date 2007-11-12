Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711111630x5a9471b7mcfbc690ee446ba98@mail.gmail.com>
Date: Sun, 11 Nov 2007 19:30:55 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: benh@kernel.crashing.org
Subject: Re: Gianfar ethernet device
In-Reply-To: <9e4733910711111622v5ad6fdd2jd30989819d05615d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711111511v36aa3504s3b55438698a4b4a8@mail.gmail.com>
	<9e4733910711111530g1f50d6e6hfaa76b4f051b5887@mail.gmail.com>
	<1194825876.18185.3.camel@pasglop>
	<9e4733910711111622v5ad6fdd2jd30989819d05615d@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

BTW, this exercise of disabling platform bus is turning up some real bugs.

There are several tests in the kernel like this:

        if (!shost->shost_gendev.parent)
                shost->shost_gendev.parent = dev ? dev : &platform_bus;

	if (adap->dev.parent == NULL) {
		adap->dev.parent = &platform_bus;
		pr_debug("I2C adapter driver [%s] forgot to specify "
			 "physical device\n", adap->name);
	}

This doesn't do the right thing when the device is on of_platform_bus
instead of platform_bus. What's the right fix for these? Shouldn't the
call error out instead of trying to fix up the parent? Then fix the
code to set the parent right when the device was created.

-- 
Jon Smirl
jonsmirl@gmail.com
