Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A181367BF3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:27:27 +1100 (EST)
Date: Tue, 12 Dec 2006 20:27:11 +0900 (JST)
Message-Id: <200612121127.kBCBRJjo002437@toshiba.co.jp>
To: michael@ellerman.id.au
Subject: Re: [PATCH 6/15] hypervisor console driver for Celleb
In-Reply-To: <1165896566.14839.3.camel@concordia.ozlabs.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Michael-san,

Thank you for your comment.

From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 6/15] hypervisor console driver for Celleb
Date: Tue, 12 Dec 2006 15:09:26 +1100

> Why do you need hvc_beat_useit? You don't want the driver loaded at all
> sometimes? Is console=blah not enough?

Mainly it is used to stop polling "beat" console temporary without
changing code. Because the "beat" console does not use interrupts
and/or buffers, polling the console and printing to the console
impact kernel performance deeply. Adding to that, the code was written
when the serial port driver is not implemented.

In short, we'd like to stop working the "beat" driver in some situation;
I don't know that console=blah is enough to do that.

Best regards,
Kou Ishizaki
