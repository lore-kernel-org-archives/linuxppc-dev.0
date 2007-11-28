Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 45710DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 22:12:06 +1100 (EST)
Date: Wed, 28 Nov 2007 12:00:37 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH] powerpc: fix os-term usage on kernel panic
Message-ID: <20071128110037.GB31217@aepfle.de>
References: <20071120012815.GB7969@austin.ibm.com>
	<1196208960.11297.26.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1196208960.11297.26.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, Will Schmidt wrote:

> > -void rtas_os_term(char *str)
> > +void rtas_panic_msg(char *str)

> > -	if (panic_timeout)
> > -		return;

This change is wrong. Booting with panic=123 really means the system
has to reboot in 123 seconds after a panic.
But, maybe this panic_timeout check was moved elsewhere.

Please revert this part of commit
a2b51812a4dc5db09ab4d4638d4d8ed456e2457e before 2.6.24 is released.
