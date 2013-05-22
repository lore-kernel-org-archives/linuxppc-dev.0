Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x232.google.com (mail-ea0-x232.google.com
 [IPv6:2a00:1450:4013:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2BA5F2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 19:43:23 +1000 (EST)
Received: by mail-ea0-f178.google.com with SMTP id q16so1032026ead.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 02:43:19 -0700 (PDT)
Message-ID: <519C9333.20609@gmail.com>
Date: Wed, 22 May 2013 11:43:15 +0200
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
MIME-Version: 1.0
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v4 06/12] ARM: dove: add gigabit ethernet and mvmdio device
 tree nodes
References: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369154510-4927-7-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130521174849.GL26249@lunn.ch>
In-Reply-To: <20130521174849.GL26249@lunn.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org,
 Lennert Buytenhek <buytenh@wantstofly.org>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/21/2013 07:48 PM, Andrew Lunn wrote:
> On Tue, May 21, 2013 at 06:41:44PM +0200, Sebastian Hesselbarth wrote:
>> This patch adds orion-eth and mvmdio device tree nodes for DT enabled
>> Dove boards. As there is only one ethernet controller on Dove, a default
>> phy node is also added with a note to set its reg property on a per-board
>> basis.
>>
>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>> ---
...
>> +			ethernet-port@0 {
>> +				device_type = "network";
>> +				compatible = "marvell,orion-eth-port";
>> +				reg =<0>;
>> +				interrupts =<29>;
>> +				/* overwrite MAC address in bootloader */
>> +				local-mac-address = [00 00 00 00 00 00];
>
> Hi Sebastian
>
> Its probably a good idea to set the local administration bit in this
> MAC address. i.e. first byte is 02.

Andrew,

we just need an invalid address here to trigger the default behavior of
the driver and load the MAC address from its register. As PPC binding
documentation also has all zero, I just took it.

Sebastian
