Return-Path: <xcarandiru@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1B465B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 23:49:41 +1000 (EST)
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215]) by ozlabs.org (Postfix) with ESMTP id 7445DDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 23:49:40 +1000 (EST)
Received: by gxk11 with SMTP id 11so192469gxk.16
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 06:49:38 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 26 Aug 2009 10:25:47 -0300
Message-ID: <d970ff420908260625q2d34bc10p62241218f022b5c2@mail.gmail.com>
Subject: PPC driver - generic bus width
From: Alemao <xcarandiru@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Im trying to develop a driver for my device, and its data bus can be 8, 16
or 32 bits. This information is passed through the device tree source.
My code is like this:

struct device_info_t {
	void (*read)();
	void (*write)();
};

static int __devinit device_probe()
{
	prop = of_get_property(ofdev->node, "bus-width", &size);

	device->bus_width = *prop;

	switch (device->bus_width) {
	case 8:
		device->read  = in_8;
		device->write = out_8;
		break;
	case 16:
		device->read  = in_be16;
		device->write = out_be16;
		break;
	case 32:
		device->read  = in_be32;
		device->write = out_be32;
		break;
	default:
		break;
	}
}

Can someone point me some driver that is doing something similar to the
ideia shown above?

Or what Im doing wrong in my code? Cause Im getting erros (warnings) like:

cc1: warnings being treated as errors
drivers/dev_test.c:37: warning: function declaration isn't a prototype
drivers/dev_test.c:38: warning: function declaration isn't a prototype
drivers/dev_test.c: In function 'device_probe':
drivers/dev_test.c:113: warning: assignment from incompatible pointer
type

PS: Im using a MPC8349, linux kernel 2.6.26

Cheers,

--
Alemao
