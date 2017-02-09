Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vK0kK108wzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 01:26:16 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, Scott Bauer <scott.bauer@intel.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>, Rafael Antognolli
 <rafael.antognolli@intel.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] block: sed-opal: reduce stack size of ioctl handler
Date: Thu, 9 Feb 2017 14:26:02 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB0281652@AcuExch.aculab.com>
References: <20170208211546.2789607-1-arnd@arndb.de>
In-Reply-To: <20170208211546.2789607-1-arnd@arndb.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnd Bergmann
> Sent: 08 February 2017 21:15
>
> When CONFIG_KASAN is in use, the sed_ioctl function uses unusually large =
stack,
> as each possible ioctl argument gets its own stack area plus redzone:

Why not do a single copy_from_user() at the top of sed_ioctl() based on
the _IOC_DIR() and __IOC_SIZE() values?

Something like:
int sed_ioctl(..., unsigned int cmd, void __user *arg)
{
	u64 buf[??]; /* or a union */
	unsigned int cmd_sz =3D _IOC_SIZE(cmd);

	if (_IOC_DIR(cmd) & (_IOC_WRITE | _IOC_READ) && cmd_sz > sizeof buf)
		return -EINVAL;

	if (_IOC_DIR(cmd) & _IOC_WRITE) {
		if (copy_from_user(buf, arg, cmd_sz))
			return -EFAULT;
	} else {
		if (IOC_DIR(cmd) & _IOC_READ))
			memzero(buf, cmd_sz);
	}

	switch (cmd) {
	...
		rval =3D ...
	...
	}

	if (rval >=3D 0 && (_IOC_DIR(cmd) & _IOC_READ)
			&& copy_to_user(arg, buf, cmd_sz));
		return -EFAULT;

	return rval;
}

	David
