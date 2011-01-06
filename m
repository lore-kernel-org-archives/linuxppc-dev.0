Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 11ED9B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Jan 2011 19:27:22 +1100 (EST)
Received: by fxm5 with SMTP id 5so15166864fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 06 Jan 2011 00:27:20 -0800 (PST)
MIME-Version: 1.0
Sender: baringforge@gmail.com
From: Thomas Taranowski <tom@baringforge.com>
Date: Thu, 6 Jan 2011 00:26:59 -0800
Message-ID: <AANLkTi=ns4-bz1JBdzjX0tvqNuEDRiM6UpmzMu_Fr8cw@mail.gmail.com>
Subject: RapidIO: question about rionet probe call
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm doing some work to support multiple mport architectures, and have
run into an issue where the rionet_probe() function isn't being
called, so my rionet net device never get's created.  I've also
verified that the rio_device_probe() isn't being called either.

The low level rio bus driver initializes and probes correctly, and
creates the required entries in sysfs.  Then, later, I see the
rionet_init get called and return success, indicating it registered
with the rapidio bus correctly, so everything looks good.


I see the following output (extra debug prints added) , indicating the
rionet driver is being added, but it never gets probed afterward.
~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~ rio_register_driver ~~~
~~~~~~~~~~~~~~~~~~~~~~~~~~~
bus: 'rapidio': add driver rionet
initializing klist
init and added kobj, err=0
driver_create_file err=0
driver added attrs, err=0
returning 0
RIO: rionet_init rio_register_driver: rc=0


Any ideas on why rionet isn't being probed?  Is rionet currently working?
I'm running a 2.6.36-rc8 baseline.

Thanks,
Thomas Taranowski
