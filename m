Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f157.google.com (mail-gx0-f157.google.com
	[209.85.217.157]) by ozlabs.org (Postfix) with ESMTP id D237BDDE98
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 05:36:46 +1100 (EST)
Received: by gxk1 with SMTP id 1so7510701gxk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Mar 2009 11:36:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090322154710.GA6473@lixom.net>
References: <20090321222047.20493.87335.stgit@localhost.localdomain>
	<20090321222901.20493.67103.stgit@localhost.localdomain>
	<20090322154710.GA6473@lixom.net>
Date: Sun, 22 Mar 2009 12:36:44 -0600
Message-ID: <fa686aa40903221136k5a926381u69fe6e57b927d1d2@mail.gmail.com>
Subject: Re: [PATCH v2 09/13] net: Rework pasemi_mac driver to use of_mdio
	infrastructure
From: Grant Likely <grant.likely@secretlab.ca>
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net, afleming@freescale.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 22, 2009 at 9:47 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sat, Mar 21, 2009 at 04:29:01PM -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> This patch simplifies the driver by making use of more common code.
>
> Did you ever try building it? pasemi_defconfig gives me:

No.  I mentioned it in the series header email, but not in the patch
description.  My 64bit build environment is broken at the moment so I
couldn't build test the pasemi patch.  All the others are build
tested.  I'll have it sorted out before I post v3.

> drivers/net/pasemi_mac.c: In function 'pasemi_mac_phy_init':
> drivers/net/pasemi_mac.c:1102: error: implicit declaration of function 'of_phy_connect'
> drivers/net/pasemi_mac.c:1103: warning: assignment makes pointer from integer without a cast
> drivers/net/pasemi_mac.c:1114: warning: label 'err' defined but not used
> drivers/net/pasemi_mac.c:1092: warning: unused variable 'ret'
> drivers/net/pasemi_mac.c:1091: warning: unused variable 'r'
> drivers/net/pasemi_mac.c:1090: warning: unused variable 'prop'
> drivers/net/pasemi_mac.c:1089: warning: unused variable 'ph'
> make[2]: *** [drivers/net/pasemi_mac.o] Error 1
>
> The changes needed are trivial, include <linux/of_mdio.h> and remove the
> variables, label and following code. I could send a patch but that's likely
> more of a hassle than you fixing it up yourself?

Yeah, I'll fix it.  Thanks for the testing.

> Otherwise, with the above changes, seems to test out ok on my Electra.
> When you checkin the changes, feel free to add:

Awesome.  Thanks for the testing.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
