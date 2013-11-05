Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ee0-x22a.google.com (mail-ee0-x22a.google.com
 [IPv6:2a00:1450:4013:c00::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB39B2C0399
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 09:17:47 +1100 (EST)
Received: by mail-ee0-f42.google.com with SMTP id c1so1732243eek.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Nov 2013 14:17:41 -0800 (PST)
Message-ID: <52796E82.5010800@gmail.com>
Date: Tue, 05 Nov 2013 23:17:38 +0100
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Arnaud Ebalard <arno@natisbad.org>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH] net: mv643xx_eth: Add missing phy_addr_set in DT mode
References: <1383611239-14556-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <87sivacxcf.fsf@natisbad.org>
In-Reply-To: <87sivacxcf.fsf@natisbad.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 linux-kernel@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2013 11:12 PM, Arnaud Ebalard wrote:
> Hi Jason,
>
> Jason Gunthorpe <jgunthorpe@obsidianresearch.com> writes:
>
>> Commit cc9d4598 'net: mv643xx_eth: use of_phy_connect if phy_node
>> present' made the call to phy_scan optional, if the DT has a link to
>> the phy node.
>>
>> However phy_scan has the side effect of calling phy_addr_set, which
>> writes the phy MDIO address to the ethernet controller. If phy_addr_set
>> is not called, and the bootloader has not set the correct address then
>> the driver will fail to function.
>
> Thanks *a lot* for fixing this one! I had the issue on my ReadyNAS 102
> (Armada 370 based) which I had put on a todo list and temporarily

Erm, just to make sure: Armada 370 isn't using mv643xx_eth but mvneta,
are you sure it is (was) related to Jason's fix?

Sebastian

> workarounded by including a 'ping whatever' call in my u-boot env in
> order to force it to do the init. Without it, I was unable to properly
> use the interface. With your fix, after multiple reboots to test it,
> everything works as expected. So, FWIW:
>
> Tested-by: Arnaud Ebalard <arno@natisbad.org>
