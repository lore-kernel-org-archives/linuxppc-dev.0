Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 306792C00A1
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2012 12:01:38 +1000 (EST)
Message-ID: <502075B3.3020605@windriver.com>
Date: Tue, 7 Aug 2012 09:56:03 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/1] booke/wdt: fix incorrect WDIOC_GETSUPPORT return path
References: <1343636122-23273-1-git-send-email-tiejun.chen@windriver.com>
 <CAOZdJXWftkUSw57-Qbe9JFP9NwodkHprKr6_1xi6ZzzLN8A4wA@mail.gmail.com>
 <CAOZdJXWYyc_=iikFwSLy4gX7Grag=jxvWhYrP4Y9U3QZcwieBw@mail.gmail.com>
In-Reply-To: <CAOZdJXWYyc_=iikFwSLy4gX7Grag=jxvWhYrP4Y9U3QZcwieBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 08/07/2012 09:19 AM, Tabi Timur-B04825 wrote:
> On Mon, Aug 6, 2012 at 2:12 PM, Tabi Timur-B04825 <b04825@freescale.com> wrote:
>> On Mon, Jul 30, 2012 at 3:15 AM, Tiejun Chen <tiejun.chen@windriver.com> wrote:
>>> We miss that correct WDIOC_GETSUPPORT return path when perform
>>> copy_to_user() properly.
>>
>> Thanks for catching this.  I'm amazed that this driver still has bugs like this.
> 
> While you're at it, I found a few related bugs.  Can you fix these, also?
> 
> 1.	case WDIOC_SETOPTIONS:
> 		if (get_user(tmp, p))
> 			return -EINVAL;
> 
> This should return -EFAULT.
> 
> 2. 	case WDIOC_GETBOOTSTATUS:
> 		/* XXX: something is clearing TSR */
> 		tmp = mfspr(SPRN_TSR) & TSR_WRS(3);
> 		/* returns CARDRESET if last reset was caused by the WDT */
> 		return (tmp ? WDIOF_CARDRESET : 0);
> 
> This should use put_user() to return the value, instead of returning
> it as a return code.
> 
> You can title the new patch something like, "booke/wdt: some ioctls do
> not return values properly"

Will regenerate this patch including these error as v2.

Thanks
Tiejun
