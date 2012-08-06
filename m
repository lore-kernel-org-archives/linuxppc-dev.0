Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91F9E2C00A1
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2012 09:36:28 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return path
Date: Mon, 6 Aug 2012 23:36:20 +0000
Message-ID: <CAOZdJXWYyc_=iikFwSLy4gX7Grag=jxvWhYrP4Y9U3QZcwieBw@mail.gmail.com>
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
 <CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
In-Reply-To: <CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 6, 2012 at 2:12 PM, Tabi Timur-B04825 <b04825@freescale.com> wr=
ote:
> On Mon, Jul 30, 2012 at 3:15 AM, Tiejun Chen <tiejun.chen@windriver.com> =
wrote:
>> We miss that correct WDIOC_GETSUPPORT return path when perform
>> copy_to_user() properly.
>
> Thanks for catching this.  I'm amazed that this driver still has bugs lik=
e this.

While you're at it, I found a few related bugs.  Can you fix these, also?

1.	case WDIOC_SETOPTIONS:
		if (get_user(tmp, p))
			return -EINVAL;

This should return -EFAULT.

2. 	case WDIOC_GETBOOTSTATUS:
		/* XXX: something is clearing TSR */
		tmp =3D mfspr(SPRN_TSR) & TSR_WRS(3);
		/* returns CARDRESET if last reset was caused by the WDT */
		return (tmp ? WDIOF_CARDRESET : 0);

This should use put_user() to return the value, instead of returning
it as a return code.

You can title the new patch something like, "booke/wdt: some ioctls do
not return values properly"

--=20
Timur Tabi
Linux kernel developer at Freescale=
